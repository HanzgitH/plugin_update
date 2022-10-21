# plugin_update
RPC and Websocket update

This will cover:
  - Taking the node and PGSQL services down with docker-compose down
  - Updating the startNode.sh and plugin.env file with the correct endpoints.
  - Adding TLS on port 6689 for a more secure dashboard login.
  - Adding more mounting points to the container for ease of use.
  - Docker compose up then restarting node services.
 
 Please read the docker-compose.yaml file for the mounts and directories that have been linked and can be used outside of the container.
 
 Update installation:
 
    sudo git clone https://github.com/HanzgitH/plugin_update.git && cd plugin_update && sudo chmod +x update.sh
    
As they are multiple RPC and WS types each user will have to manually add the new RPC endpoint and Websocket address:

Move directory to edit the startEI.sh:

    cd /opt/docker/goplugin/plugin-deployment
    
Open the startEI.sh file and edit:

    nano startEI.sh
    
(edit rpc from https://plirpc.blocksscan.io/ → https:/pliws.xdcrpc.com/)
  
  # If your RPC is different then please ensure it is https:/pliws.xdcrpc.com/
  
  
Open the plugin.env file and edit websocket:

    nano plugin.env
    
Save and exit:
  ctrl + x
  y
press enter
    
(edit websocket from wss://pluginws.blocksscan.io → wss://pliws1.xdcrpc.com)

   # If your Websocket is different then please ensure it is wss://pliws1.xdcrpc.com
   
Save and exit:
  ctrl + x
  y
press enter

Now move to the correct directory and run update.sh:

    cd /home/plugin_update

    ./update.sh

Any points or concerns please reach out in the official goplugin discord channel.

