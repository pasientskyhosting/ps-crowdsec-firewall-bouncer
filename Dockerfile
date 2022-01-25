FROM debian:buster-slim

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y -q --install-recommends --no-install-suggests tzdata procps netbase iproute2 ipset curl && \
    mkdir -p /etc/crowdsec/bouncers/ && \
    mkdir -p /var/run/crowdsec/ && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/crowdsecurity/cs-firewall-bouncer/releases/download/v0.0.21/crowdsec-firewall-bouncer.tgz /crowdsec-firewall-bouncer.tgz

COPY config/crowdsec-firewall-bouncer.yaml /etc/crowdsec/bouncers/
COPY bin/start.sh /start.sh

RUN tar xzvf /crowdsec-firewall-bouncer.tgz && rm /crowdsec-firewall-bouncer.tgz && mv /crowdsec-firewall-bouncer-v0.0.21/crowdsec-firewall-bouncer /crowdsec-firewall-bouncer

CMD ["/start.sh"]
