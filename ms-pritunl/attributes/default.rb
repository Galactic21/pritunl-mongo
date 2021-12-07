default['pritunl']['version'] = '1.30.3001.87-0ubuntu1~focal'
default['pymongo']['version'] = '3.10.1-0ubuntu2'
default['pritunl']['use_repo'] = true
default['pritunl']['install_method'] = 'package'

# Activate kitchen
default['base']['test_kitchen'] = false
default['pritunl']['mongodb_ip'] = 'CHANGE_ME'

# Change the URI with the credentials defined in the ms-mongodb cookbook
default['pritunl']['conf']['mongodb_uri'] = 'mongodb://CHANGE_ME_USER:CHANGE_ME_PASS@CHANGE_ME_HOST:27017/pritunl?tls=true'
default['pritunl']['conf']['bind_addr'] = '0.0.0.0'
default['pritunl']['conf']['local_address_interface'] = 'auto'

default['pritunl']['conf']['port'] = case node['base']['test_kitchen']

                                     when true
                                       443
                                     else
                                       80
                                     end
