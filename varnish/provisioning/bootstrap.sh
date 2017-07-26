#!/usr/bin/env bash

sudo curl http://repo.varnish-cache.org/debian/GPG-key.txt | sudo apt-key add -

sudo echo "deb http://repo.varnish-cache.org/ubuntu/ lucid varnish-3.0" >> /etc/apt/sources.list

sudo apt-get update -y
sudo apt-get install varnish -y

echo '
START=yes
NFILES=131072
MEMLOCK=82000
DAEMON_OPTS="-a :80 \
             -T localhost:6082 \
             -f /etc/varnish/default.vcl \
             -S /etc/varnish/secret \
             -s malloc,256m"
' | sudo tee /etc/default/varnish;
echo '
backend default {
    .host = "192.168.60.2";
    .port = "80";
}

sub vcl_fetch {
        set beresp.do_esi = true;
}
' | sudo tee /etc/varnish/default.vcl
sudo service varnish restart
