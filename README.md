# plugin_update

RPC and Websocket update.

Before doing this update ensure you have the correct docker install (one-click) check if this is the correct version for update.

    sudo docker ps -a

Read the output, at the right hand side under `"name"` if the strings are `plinode, psql_node and psql_ei` then use this update process.

This will cover:
  - Taking the node and PGSQL services down with docker-compose down
  - Updating the startNode.sh and plugin.env file with the correct endpoints.
  - Adding TLS on port 6689 for a more secure dashboard login.
  - Adding more mounting points to the container for ease of use.
  - Docker compose up then restarting node services.
 
 Please read the docker-compose.yaml file for the mounts and directories that have been linked and can be used outside of the container.
 
 
 
 Update installation:
 
 MUST INSTALL IN `/home` directory and user account where plugin node was installed:
 
    cd /home
 
 Download git files:
 
    sudo git clone https://github.com/HanzgitH/plugin_update.git && cd plugin_update && sudo chmod +x update.sh
    
As they are multiple RPC and WS types each user will have to manually add the new RPC endpoint and Websocket address:

Move directory to edit the startEI.sh:

    cd /opt/docker/goplugin/plugin-deployment
    
Open the `startEI.sh` file and edit:

    nano startEI.sh
    
   Edit rpc from `https://plirpc.blocksscan.io → https://plixdcrpc.icotokens.net`
  
  If your RPC is different then please ensure it is `https://plixdcrpc.icotokens.net`
  
Open the `plugin.env` file and edit websocket:

    nano plugin.env
    
Save and exit:
  `ctrl + x, y , press enter`
    
   Edit websocket from `wss://pluginws.blocksscan.io` → `wss://plixdcwss.icotokens.net`

  If your Websocket is different then please ensure it is `wss://plixdcwss.icotokens.net`
  
Save and exit:
  `ctrl + x, y , press enter`

Now move to the update directory.

    cd /home/plugin_update
    
Run the `update.sh` file for TLS and dockercompose:

    ./update.sh
    
 - IMPORTANT - Now use `6689` to login to your dashboard:

   `https://ip:6689`
        
As the certificates are selfsigned each browser will show a warning, as its your own certificate this is acceptable.
    
    
    
Disclaimer:

This update is to assist the normal operation of a $PLI node.

I have tested this install against my nodes and is free to share and use at each individual's discression, I take no personal responsibility for the use, distribution and implementation of this update.

It is strongly advised to test against a node that matches your installation. 

Having a test node is crucial when updating or making changes to reduce errors and downtime. 

Read through the code that is located within `update.sh` to familiarise yourself with what is intended to be updated and how.

Any points or concerns please reach out in the official goplugin discord channel:

`https://discord.gg/fMyankEBXY`

#NodeLife

Hanz @DeFi_Jon
    
