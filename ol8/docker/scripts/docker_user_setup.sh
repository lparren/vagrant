echo "******************************************************************************"
echo "Setup docker_user "
echo "******************************************************************************"

# Clone the latest Git repository. Use SSH so no password.
cd /u01
git clone https://github.com/lparren/dockerfiles.git
git clone https://github.com/oracle/db-sample-schemas.git
cd /u01/db-sample-schemas
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat 
cd ~

echo "******************************************************************************"
echo "Install PyCharm"
echo "******************************************************************************"
wget -q https://download-cf.jetbrains.com/python/pycharm-community-2020.3.2.tar.gz
tar -xvf pycharm-community-2020.3.2.tar.gz
mv pycharm-community-2020.3.2 pycharm-community
rm pycharm-community-2020.3.2.tar.gz
cd ~

echo "alias pycharm=\"~/pycharm-community/bin/pycharm.sh &\"" >> /home/docker_user/.bash_profile

echo "******************************************************************************"
echo "Add lazydocker alias"
echo "******************************************************************************"
echo "alias lazydocker=\"sudo /usr/local/bin/lazydocker\"" >> /home/docker_user/.bash_profile

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
