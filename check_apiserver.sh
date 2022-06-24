#!/bin/sh
# This should go at /etc/keepalived/check_apiserver.sh
errorExit() {
    echo "*** $*" 1>&2
    exit 1
}

# This must match value in /etc/haproxy/haproxy.cfg/keepalived.conf
APISERVER_DEST_PORT=172.21.64.64

# Port API server is listening on, default is 6443
# Must match values in
#  /etc/kubernetes/manifests/haproxy.yaml
#  /etc/haproxy/haproxy.cfg
APISERVER_DEST_PORT=8443

curl --silent --max-time 2 --insecure https://localhost:${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://localhost:${APISERVER_DEST_PORT}/"
if ip addr | grep -q ${APISERVER_VIP}; then
    curl --silent --max-time 2 --insecure https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/ -o /dev/null || errorExit "Error GET https://${APISERVER_VIP}:${APISERVER_DEST_PORT}/"
fi
