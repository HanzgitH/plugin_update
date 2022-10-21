# plugin_update
RPC and Websocket update

As they are multiple RPC and WS types each user will have to manually add the new RPC endpoint and Websocket address:

This will cover:
  - Taking the node and PGSQL services down with docker-compose down
  - Updating the startNode.sh and plugin.env file with the correct endpoints.
  - Adding TLS on port 6689 for a more secure dashboard login.
  - Adding more mounting points to the container for eas of use
  
 #Points to node, the nodeboot autoservice and logs will be removed as they are within the container. This will need to be redone and is covered in this     guide.

Update guide:

  
  


