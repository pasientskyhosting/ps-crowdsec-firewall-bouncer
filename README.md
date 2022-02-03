# ps-crowdsec-firewall-bouncer

## Description

Dockerized implementation of crowdsec-firewall-bouncer

## environment file
```
$ cat /etc/default/crowdsec-firewall-bouncer

TZ=Europe/Copenhagen
API_URL=https://0.0.0.0:8080/
API_KEY=xyz
```

### Example docker startup command
```
/usr/bin/docker run --name crowdsec-firewall-bouncer --rm --env-file /etc/default/crowdsec-firewall-bouncer \
--net=host \
--privileged \
--cap-add ALL \
pasientskyhosting/ps-crowdsec-firewall-bouncer:1.0
```

## Example systemd service unit
```
$ cat /etc/systemd/system/crowdsec-firewall-bouncer_container.service

[Unit]
After=docker.service
PartOf=docker.service
Requires=docker.service


[Service]
EnvironmentFile=/etc/default/crowdsec-firewall-bouncer
ExecStartPre=-/usr/bin/docker stop crowdsec-firewall-bouncer
ExecStartPre=/bin/bash -c 'if [[ "$(docker images -q pasientskyhosting/ps-crowdsec-firewall-bouncer:1.0)" == "" ]]; then /usr/bin/docker pull pasientskyhosting/ps-crowdsec-firewall-bouncer:1.0; fi'

ExecStart=/usr/bin/docker run --name crowdsec-firewall-bouncer --rm --env-file /etc/default/crowdsec-firewall-bouncer \
--net=host \
--privileged \
--cap-add ALL \
pasientskyhosting/ps-crowdsec-firewall-bouncer:1.0

ExecStop=/usr/bin/docker stop crowdsec-firewall-bouncer

SyslogIdentifier=crowdsec-firewall-bouncer
KillMode=process
LimitNOFILE=1048576
LimitNPROC=1048576
LimitCORE=infinity
TimeoutStartSec=1min
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
TasksMax=infinity

[Install]
WantedBy=docker.service
```
