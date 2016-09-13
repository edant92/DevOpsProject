#set language
sudo locale-gen en_US.UTF-8
#update
sudo apt-get update
#install server
sudo apt-get install -y openssh-server openssh-client
#install vim
sudo apt-get install -y vim

#disable firewall
sudo ufw disable
echo 'devops - ufw disabled'

#install puppet
sudo apt-get install -y puppet puppetmaster
echo 'devops - puppet installed'

#Variables
agentfqdn=$(sudo facter fqdn)
agentip=$(sudo facter ipaddress_eth1)
echo  'devops - variables set ' $agentfqdn
echo  'devops - variables set ' $agentip

#edit host file
sudo sed -i "1s/^/127.0.0.1 $agentfqdn puppetmaster \n$agentip $agentfqdn puppetmaster\n\n/" /etc/hosts
echo 'devops - hosts edited'

#create site.pp
sudo touch /etc/puppet/manifests/site.pp
echo 'devops - site touched'

#autosign
sudo sed -i "\$aautosign = true" /etc/puppet/puppet.conf
echo 'devops - autosign enabled'

#java puppet install
puppet module install puppetlabs-java
echo 'devops - java installed'
#jenkins puppet install
puppet module install rtyler-jenkins
echo 'devops - jenkins installed'
#maven puppet install
puppet module install maestrodev-maven
echo 'devops - maven installed'
#git puppet install
puppet module install puppetlabs-git
echo 'devops - git installed'
#jira puppet install
puppet module install puppet-jira
echo 'devops - jira installed'

##java non puppet install
#echo 'start java install'
#sudo apt-get install -y default-jre
#sudo apt-get install -y default-jdk
#echo 'devops - java installed'

##jenkins non puppet install
#wget -q -O - https://pkg.jenkins.io/debian/jenkins-ci.org.key | sudo apt-key add -
#sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
#sudo apt-get install -y jenkins
#echo 'devops - jenkins installed'

##maven non puppet install
#sudo apt-get install -y maven
#echo 'devops - maven installed'
