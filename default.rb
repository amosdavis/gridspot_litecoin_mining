#
# Cookbook Name:: gridspot
# Recipe:: default
#
# Author: Amos Davis
# License: GNU GPLv3
#
execute "apt_update" do
    user "root"
    command "apt-get update"
end

#execcute "apt_install" do
#	user root
#	command "apt-get install git libcurl3 libcurl4-openssl-dev automake make rng-tools build-essential libpcre3-dev"
#end
%w{git libcurl3 libcurl4-openssl-dev automake make rng-tools build-essential libpcre3-dev }.each do |pkg|
	package pkg do
		action :install
		options "--force-yes"
	end
end

execute "apt_clean" do
    user "root"
#Remove extra packages... and kernel... these are single use instances and will not be powered off unless they are terminated
#Epic solution to the disk space problem,  I know.
    command "apt-get clean && rm -rf /tmp/* && sudo apt-get -y remove linux-generic linux-image-3.0.0-12-generic linux-image-generic wireless-crda wireless-tools"
end
execute "get_miner" do
    cwd "/home/gridspot_user/"
    user "gridspot_user"
    command "sudo rngd -r /dev/urandom -o /dev/random && wget -v http://ufasoft.com/files/ufasoft_coin-0.33.tar.xz 2>&1 && tar -xvJf ufasoft_coin-0.33.tar.xz && rm ufasoft_coin-0.33.tar.xz && cd ufasoft_coin-0.37/ && ./configure && make"
end
execute "run_miner" do
    cwd "/home/gridspot_user/ufasoft_coin-0.37/"
    user "gridspot_user"
#Don't forget to update with your own username/password
    command "screen -S bitcoin -m -d ./bitcoin-miner -a scrypt -o  http://username:password@litecoin_server_ip:80 -t4 -v"
end

