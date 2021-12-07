# ms-mongodb

This cookbook is responsible to create a mongodb instance, with an admin user.
Also creates DB and user with db_owner role.

In order to perform tests in the kitchen, it is necessary to enable the "default['base']['test_kitchen']" attribute.
Although it is enable in kitchen.yml by default, it is recommended to also change the attribute.

# Change the admin or user passwords

To change passwords for admin user, you need to be careful. 
To make changes you just need to:
1st Step - Change the attribute default['mongo_db']['admin']['new_pass'].
2nd Step - Run the chef-client * with the changes. Ignore possible errors.
3rd Step - Update the new password in the attribute default['mongo_db']['admin']['pass'] and
           run the chef-client again.

* - chef-client if prod environments.
    kitchen if test environments.

To change passwords for one or more users, in this cookbook you only need to change the attribute default['mongo_db']['dbOwner']['pass'] with the new password. In case of pritunl, you must also change the mongo connection URI.