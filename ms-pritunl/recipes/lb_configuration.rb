directory '/opt/pritunl' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

template 'LB configuration script' do
  path '/opt/pritunl/load_balacing_script.py'
  source 'load_balacing_script.erb'
  variables(
    conf_mongodb_uri: node['pritunl']['conf']['mongodb_uri']
  )
end

execute 'install lb_script' do
  command 'python3 /opt/pritunl/load_balacing_script.py'
  user 'root'
  action :run
end
