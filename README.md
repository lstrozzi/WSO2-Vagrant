# WSO2-Vagrant
Vagrant Scripts to configure WSO2 Products

# Required products:
- Tortoise Git
- Oracle Virtualbox
- Vagrant

# How to run WSO2 API-Manager
- open a CMD.exe prompt
- CD to the API-M folder
- start Vagrant with the command:
  vagrant up
- the first time it will create and start the VM, but an error occurs, so you need again to:
  vagrant up (again, just first time)
- once it's running, connect to the VM:
  vagrant ssh
  You are username=vagrant, password=vagrant
- in the VM, CD to the directory:
  cd /opt/wso2/wso2am/bin
- (optionally remove all Windows batch files: rm *.bat)
- in the VM, start the API Manager:
  ./api-manager.sh
- the application will start, and take about 2-5 minutes to complete startup
- you know when startup is
- once that is done, open a browser in the host (Windows) and connect in multiple tabs to the URLs shown in the next section

# How to connect to API Manager consoles
- You noticed during startup (towards the end) these lines in the log:
[2021-10-08 09:51:56,543]  INFO - CarbonUIServiceComponent Mgt Console URL  : https://localhost:9443/carbon/
[2021-10-08 09:51:56,544]  INFO - CarbonUIServiceComponent API Developer Portal Default Context : https://localhost:9443/devportal
[2021-10-08 09:51:56,544]  INFO - CarbonUIServiceComponent API Publisher Default Context : https://localhost:9443/publisher
- connect in multiple tabs to the URLs shown in the log file
- username and passwords: Admin / Admin

# How to stop WSO2 API-Manager
- in the previously opened CMD prompt, press CTRL-C and wait a few seconds until the program ends
- you're still inside the VM, press CTRL-D to quit (and return to Windows command prompt)
- stop the VM with this command
  vagrant halt


# How to clean-up used disk space
- open a CMD.exe prompt
- CD to the API-M folder
- delete the VM with this command:
  vagrant destroy
- optionally delete the centos/8 box with these commands:
  vagrant box list (it should have centos/8)
  vagrant box remove centos/8
  vagrant box list (now it should be empty)

# Example how to use the xmlstarlet program
echo $ROLE": configuring thrift for analytics"
XMLFILE=$FILE/repository/conf/api-manager.xml
xmlstarlet ed --inplace -P -u //Analytics/Enabled -v $ANALYTICS $XMLFILE
xmlstarlet ed --inplace -P -u //Analytics/StreamProcessorServerURL -v '{tcp://noded:7612}' $XMLFILE
xmlstarlet ed --inplace -P -a //Analytics/StreamProcessorServerURL -t elem -n StreamProcessorAuthServerURL -v '{ssl://noded:7712}' $XMLFILE
xmlstarlet ed --inplace -P -u //Analytics/StreamProcessorRestApiURL -v 'https://noded:7444' $XMLFILE
XMLFILE=$FILE/repository/conf/output-event-adapters.xml
xmlstarlet ed --inplace -P -u "//adapterConfig[@type='wso2event']/property[@key='default.thrift.tcp.url']" -v 'tcp://noded:7612' $XMLFILE
xmlstarlet ed --inplace -P -u "//adapterConfig[@type='wso2event']/property[@key='default.thrift.ssl.url']" -v 'ssl://noded:7712' $XMLFILE
xmlstarlet ed --inplace -P -u "//adapterConfig[@type='wso2event']/property[@key='default.binary.tcp.url']" -v 'tcp://noded:7612' $XMLFILE
xmlstarlet ed --inplace -P -u "//adapterConfig[@type='wso2event']/property[@key='default.binary.ssl.url']" -v 'ssl://noded:7712' $XMLFILE
