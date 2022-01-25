#!/bin/bash
set -e

echo "-> Replacing environment variables"
sed -i -e "s/{MODE}/${MODE:-iptables}/g" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sed -i -e "s/{API_URL}/${API_URL:-localhost:8080}/g" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sed -i -e "s/{API_KEY}/${API_KEY:-none}/g" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml

echo "-> Validating config file"
/crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml -t

echo "-> Starting crowdsec-firewall-bouncer"
exec /crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
