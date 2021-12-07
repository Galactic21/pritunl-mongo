# Script to execute the backups to s3
template '/usr/local/bin/mongodb-s3-backup.sh' do
  source 'mongodb-s3-backup.erb'
  variables(
    backup_host: node['s3']['backup']['host'],
    backup_dbname: node['s3']['backup']['dbname'],
    backup_bucket: node['s3']['backup']['bucket'],
    backup_bucket_f: node['s3']['backup']['bucket_f'],
    db_owner_user: node['mongo_db']['dbOwner']['user'],
    db_owner_pass: node['mongo_db']['dbOwner']['pass']
  )
  owner 'root'
  group 'root'
  mode  '755'
end

# Setup cron jobs
cron 's3_mongodb_backups' do
  command '/usr/local/bin/mongodb-s3-backup.sh  '
  minute '10'
  hour '0'
  day '*'
  mailto "''"
  user 'root'
  only_if { ::File.exist?('/usr/local/bin/mongodb-s3-backup.sh') }
  action :create
end
