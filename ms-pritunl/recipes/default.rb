#
# Cookbook:: ms-pritunl
# Recipe:: default
#
# Copyright:: 2021, The Authors, All Rights Reserved.

hostname 'vpn configuration' do
  hostname 'vpn-db.in.anbstuff.net'
  ipaddress node['pritunl']['mongodb_ip']
  only_if { node['base']['test_kitchen'] == true }
end

package 'python3-pymongo' do
  version node['pymongo']['version']
  action :install
  only_if { node['base']['test_kitchen'] == false }
end

include_recipe 'ms-pritunl::repo' if node['pritunl']['use_repo']
include_recipe "ms-pritunl::install_#{node['pritunl']['install_method']}"

service 'pritunl' do
  action %i[enable start]
end

template 'Pritunl configuration' do
  path '/etc/pritunl.conf'
  source 'pritunl.conf.erb'
  variables(
    conf_mongodb_uri: node['pritunl']['conf']['mongodb_uri'],
    conf_bind_addr: node['pritunl']['conf']['bind_addr'],
    conf_LAI: node['pritunl']['conf']['local_address_interface'],
    conf_port: node['pritunl']['conf']['port']
  )
  notifies :restart, 'service[pritunl]', :immediately
end

include_recipe 'ms-pritunl::lb_configuration' if node['base']['test_kitchen'] == false
