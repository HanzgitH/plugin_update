#!/bin/bash

echo -e "\n\n################# Docker compose down #################\n\n"

cd /opt/docker/goplugin/plugin-deployment/

sudo docker-compose down && sleep 5

cp /home/plugin_update/docker-compose.yaml /opt/docker/goplugin/plugin-deployment/docker-compose.yaml

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

echo -e "\n\n################# Starting node  #################\n\n"

sudo docker-compose up -d && sleep 10

sudo docker exec -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startNode.sh"
echo
echo -e "Waiting for Node to come up... (15 Seconds)"

sleep 15

echo
echo -e "\n\n################# Starting External Initiators (10 seconds) #################\n\n"

sudo docker exec --env-file ei.env -it plinode /bin/bash -c ". ~/.profile && pm2 start /pluginAdm/startEI.sh"

sleep 10

echo -e "\n\n################# Adding logrotate to docker, this will compress and delete logs every 7 days #################\n\n"

sleep 5

sudo docker exec -it plinode /bin/bash -c "apt-get install logrotate -y" &&
sleep 5
sudo docker cp /home/plugin_update/pm2logs plinode:/etc/logrotate.d/pm2logs &&
sudo docker cp /home/plugin_update/logjsonl plinode:/etc/logrotate.d/logjsonl &&

echo -e "\n\n################# Update complete #################\n\n"
