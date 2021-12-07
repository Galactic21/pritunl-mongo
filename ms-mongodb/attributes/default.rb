default['base']['test_kitchen'] = false

default['mongodb']['package_version'] = '4.4.3'
default['mongodb']['packager_options'] = '-o Dpkg::Options::="--force-confold" "--allow-downgrades"'

default['mongodb']['config']['mongod']['net']['tls']['mode'] = 'preferTLS'

default['mongodb']['config']['mongod']['net']['tls']['certificateKeyFile'] = '/opt/mongo-pritunl/vpn-db.in.anbstuff.pem'

default['mongodb']['port'] = 27_017

default['mongo_db']['admin']['user'] = 'admin'

# Change the admin password.
default['mongo_db']['admin']['pass'] = 'CHANGE_ME'
default['mongo_db']['admin']['new_pass'] = 'CHANGE_ME'

# Credentials to access the database that needs to be created.
# Note: if you use the database to connect to pritunl, it is mandatory to change the URI with the created
# credentials in the ms-pritunl cookbook.
default['mongo_db']['dbOwner']['user'] = 'CHANGE_ME'
default['mongo_db']['dbOwner']['pass'] = 'CHANGE_ME'

# Name of the database you want to create.
default['mongo_db']['dbOwner']['db'] = 'CHANGE_ME'

node.default['mongodb']['config']['auth'] = true
node.default['mongodb']['mongos_create_admin'] = true

node.default['mongodb']['authentication']['username'] = node['mongo_db']['admin']['user']
node.default['mongodb']['authentication']['password'] = node['mongo_db']['admin']['pass']

node.default['mongodb']['admin'] = {
  'username' => node['mongo_db']['admin']['user'],
  'password' => node['mongo_db']['admin']['new_pass'],
  'roles' => %w(root),
  'database' => 'admin',
}

node.default['mongodb']['users'] = [{
  'username' => node['mongo_db']['dbOwner']['user'],
  'password' => node['mongo_db']['dbOwner']['pass'],
  'roles' => %w(dbOwner),
  'database' => node['mongo_db']['dbOwner']['db'],
}]

default['mongodb']['config']['mongod']['security']['authorization'] = 'enabled'

# Filling in the fields regarding backups from mongo to s3

default['mongo_db']['profile'] = 'CHANGE_ME'

case node['mongo_db']['profile']

when 'pritunl'
  default['s3']['backup']['host'] = '127.0.0.1'
  default['s3']['backup']['dbname'] = 'pritunl'
  default['s3']['backup']['bucket'] = 'com.mailspike.infra.backup'
  default['s3']['backup']['bucket_f'] = 'vpn-db'
else
  default['s3']['backup']['host'] = 'CHANGE_ME'
  default['s3']['backup']['dbname'] = 'CHANGE_ME'
  default['s3']['backup']['bucket'] = 'CHANGE_ME'
  default['s3']['backup']['bucket_f'] = 'CHANGE_ME'
end
