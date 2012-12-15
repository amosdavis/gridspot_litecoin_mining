gridspot_litcoin_mining
=======================

Mine Litecoins using Gridspot computing instances.

This project includes the following files:
get_gridspot.py: Obtains a list of running gridspot instances and is called by gridspot_configure.sh
  -- Setup add your own Gridspot API key to the file
gridspot_configure.sh: maintains a list of already configured instances obtained from get_gridspot.py and then configures them automagically using Chef's knife
  -- Add your litecoind username:password@IP:port to the file
default.rb: The default (and only) recipe for my gridspot cookbook.  This tells the chef-client how it is supposed to be configured
