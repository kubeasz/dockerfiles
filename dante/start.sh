#!/bin/sh

echo "[INFO] version: $DANTE_VER"
echo "[INFO] listening port: $PORT"
echo "[INFO] start workers number: $WORKERS"

# to support mounting config
if [ -e /etc/sockd.conf ];then
  echo "[INFO] load mounted config"
  cat /etc/sockd.conf > /sockd.conf
fi

if [[ "$USER" != "dummyUser" ]];then
  echo "[INFO] create user:$USER"
  adduser "$USER" > /dev/null
  printf "$PASS\n$PASS\n"|passwd "$USER" > /dev/null 2>&1
  echo "[INFO] enable username/password authentication"
  sed -i "s/^socksmethod:.*$/socksmethod: username/g" ./sockd.conf
fi

# change interface
if [[ "$IFACE" != "eth0" ]];then
  echo "[INFO] use interface: $IFACE"
else
  IFACE=$(ip route|grep default|awk '{print $5}')
  echo "[WARN] interface not set, use auto-detected: $IFACE"
fi
sed -i "s/^external:.*$/external: $IFACE/g" ./sockd.conf


# change listening port
sed -i "s/^internal:.*$/internal: 0.0.0.0  port = $PORT/g" ./sockd.conf

sockd -f ./sockd.conf -N "$WORKERS" -n
