#!/bin/bash
set -e

MODE="iptables"
API_URL=""
API_KEY=""

echo "-> Replacing environment variables"


echo "-> Validating config file"
/crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml -t

echo "-> Starting crowdsec-firewall-bouncer"
exec /crowdsec-firewall-bouncer -c /etc/crowdsec/bouncers/crowdsec-firewall-bouncer.yaml
