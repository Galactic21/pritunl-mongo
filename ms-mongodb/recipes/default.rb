#
# Cookbook:: ms-mongodb
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.
require 'yaml'

# To test in kitchen you need to enable the attribute default['base']['test_kitchen'].
hostname 'vpn configuration' do
  hostname 'vpn-db.in.anbstuff.net'
  only_if { node['base']['test_kitchen'] == true }
end

apt_update 'update' do
  action :update
  compile_time true
end

directory '/opt/mongo-pritunl' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/opt/mongo-pritunl/vpn-db.in.anbstuff.pem' do
  source 'vpn-db.in.anbstuff.pem'
  owner 'root'
  group 'root'
  mode '0644'
  action :create
  notifies :restart, 'service[mongodb]', :delayed
end

include_recipe 'sc-mongodb::default'

mongodb_instance 'mongodb' do
  port 27_017
end

include_recipe 'ms-mongodb::user_management'

include_recipe 'ms-mongodb::backup_s3'
