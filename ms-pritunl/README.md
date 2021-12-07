# ms-pritunl

This cookbook is responsible for the implementation of the pritunl Server. 
It is connected to an external database instance in MongoDB.

In order to perform tests in the kitchen, it is necessary to enable the "default['base']['test_kitchen']" attribute.
Although it is enable in kitchen.yml by default, it is recommended to also change the attribute.
This will allow pritunl to run over https. 
To do the necessary tests it is also necessary to change the mongodb_uri with the data of the mongo instance in the "default['pritunl']['conf']['mongodb_uri']" attribute and add the IP of the mongo's testing machine in the "default['pritunl']['mongodb_ip']" attribute.
