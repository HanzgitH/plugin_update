#!/bin/bash

echo -e "\n\n################# Making directory for tls and creating .crt files #################\n\n"

sudo sed -i -e "/PLUGIN_TLS_PORT=0/d" /opt/docker/goplugin/plugin-deployment/plugin.env
sudo sed -i -e "/SECURE_COOKIES=false/d" /opt/docker/goplugin/plugin-deployment/plugin.env

sudo mkdir -p /opt/docker/goplugin/plugin-deployment/tls && cd /opt/docker/goplugin/plugin-deployment/tls && sleep 5

openssl req -x509 -out  server.crt  -keyout server.key \
  -newkey rsa:2048 -nodes -sha256 -days 365 \
  -subj '/CN=localhost' -extensions EXT -config <( \
   printf "[dn]\nCN=localhost\n[req]\ndistinguished_name = dn\n[EXT]\nsubjectAltName=DNS:localhost\nkeyUsage=digitalSignature\nextendedKeyUsage=serverAuth") && wait

sleep 10

echo -e "\n\n################# Adding external-adapter folder #################\n\n"

cd /opt/docker/goplugin/plugin-deployment && sudo mkdir -p external-adapters && sleep 1

echo "TLS_CERT_PATH=/Plugin/server.crt
TLS_KEY_PATH=/Plugin/server.key" >> plugin.env

echo -e "\n\n################# Bringing up node  #################\n\n"

sudo docker-compose up -d && sleep 10
