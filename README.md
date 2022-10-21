# plugin_update
RPC and Websocket update

As they are multiple RPC and WS types each user will have to manually add the new RPC endpoint and Websocket address:

This will cover:
  - Taking the node and PGSQL services down with docker-compose down
  - Updating the startNode.sh and plugin.env file with the correct endpoints.
  - Adding TLS on port 6689 for a more secure dashboard login.
  - Adding more mounting points to the container for ease of use.
  - Docker compose up then restarting node services.
 
 Please read the docker-compose.yaml file for the mounts and directories that have been linked and can be used outside of the container.
 
 Update installation:
 
    sudo git clone https://github.com/HanzgitH/plugin_update.git && cd plugin_update && sudo chmod +x update.sh
