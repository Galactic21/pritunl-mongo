package 'pritunl' do
  version node['pritunl']['version']
  action :install
end

service 'pritunl' do
  supports(restart: true)
  action %i[enable start]
end
