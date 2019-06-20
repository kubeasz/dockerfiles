## chrony 镜像

本 chrony 镜像是为项目[kubeasz](https://github.com/easzlab/kubeasz)提供离线安装时间同步服务器使用，参阅 https://github.com/easzlab/kubeasz/tree/master/roles/chrony

### TL;DR;

```
$ docker run -d \
  --name chrony \
  --cap-add SYS_TIME \
  --publish 123:123/udp \
  --volume /etc/chrony.conf:/etc/chrony/chrony.conf \
  --volume /var/lib/chrony:/var/lib/chrony \
  easzlab/chrony:$TAG
```
- --cap-add SYS_TIME 为容器添加系统权限，如果不考虑权限扩大风险，也可以替换指定`--privileged`
- --publish 123:123/udp 指定开放端口，如果 chrony 作为服务端使用，必须开放该端口；如果作为客户端可以不开放端口
- --volume /etc/chrony.conf:/etc/chrony/chrony.conf 指定个性化配置
- --volume /var/lib/chrony:/var/lib/chrony 可选保存时间校准记录的状态文件 /var/lib/chrony/drift

### 制作 chrony.service

在支持 systemd 的linux系统上，可以参考配置如下服务文件：

```
$ cat /etc/systemd/system/chrony.service 
[Unit]
Description=chrony
Documentation=https://github.com/kubeasz/dockerfiles/chrony
After=docker.service
Requires=docker.service

[Service]
User=root
ExecStart=/opt/kube/bin/docker run \
  --cap-add SYS_TIME \
  --name chrony \
  --network host \
  --volume /etc/chrony.conf:/etc/chrony/chrony.conf \
  --volume /var/lib/chrony:/var/lib/chrony \
  easzlab/chrony:0.1.0
ExecStartPost=/sbin/iptables -t raw -A PREROUTING -p udp -m udp --dport 123 -j NOTRACK
ExecStartPost=/sbin/iptables -t raw -A OUTPUT -p udp -m udp --sport 123 -j NOTRACK
ExecStop=/opt/kube/bin/docker rm -f chrony
Restart=always
RestartSec=10
Delegate=yes

[Install]
WantedBy=multi-user.target
```
- 主要 --network host 选项，而不是使用 --publish 123:123/udp，后者在使用中发现无法连接外部时间服务器

### 参考

1. https://github.com/publicarray/docker-chrony
2. chrony 官方文档 https://chrony.tuxfamily.org/index.html
