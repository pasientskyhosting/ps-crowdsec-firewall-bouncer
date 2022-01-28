#!/bin/bash
set -e

echo "-> Replacing environment variables"
sed -i "s|{API_URL}|${API_URL:-localhost}|" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sed -i "s|{API_KEY}|${API_KEY:-none}|" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
sed -i "s|{UPDATE_FREQ}|${UPDATE_FREQ:-10s}|" /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml

echo "-> Validating config file"
/crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml -t

echo "-> Starting crowdsec-firewall-bouncer"
exec /crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
