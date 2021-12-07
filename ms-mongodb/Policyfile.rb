# Policyfile.rb - Describe how you want Chef Infra Client to build your system.
#
# For more information on the Policyfile feature, visit
# https://docs.chef.io/policyfile/

# A name that describes what the system you're building with Chef does.
name 'ms-mongodb'

# Where to find external cookbooks:
default_source :supermarket

# run_list: chef-client will run these recipes in the order specified.
run_list 'ms-base', 'ms-mongodb', 'ms-prometheus-exporters'

# Specify a custom source for a single cookbook:
cookbook 'ms-mongodb', path: '.'
cookbook 'ms-base', path: '../ms-base'
cookbook 'yum', path: '../yum'
cookbook 'chef-client', path: '../chef-client'
cookbook 'chef_client_updater', path: '../chef_client_updater'
cookbook 'openssh', path: '../openssh'
cookbook 'slack_handler', path: '../slack_handler'
cookbook 'cron', path: '../cron'
cookbook 'logrotate', path: '../logrotate'
cookbook 'users', path: '../users'
cookbook 'sudo', path: '../sudo'
cookbook 'iptables', path: '../iptables'
cookbook 'ms-users', path: '../ms-users'
cookbook 'sc-mongodb', path: '../sc-mongodb'
cookbook 'ms-prometheus-exporters', path: '../ms-prometheus-exporters'

