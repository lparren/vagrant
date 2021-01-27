echo "******************************************************************************"
echo "Setup docker_user "
echo "******************************************************************************"

# Clone the latest Git repository. Use SSH so no password.
cd /u01
git clone https://github.com/lparren/dockerfiles.git
git clone https://github.com/oracle/db-sample-schemas.git
cd /u01/db-sample-schemas
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat 

echo "******************************************************************************"
echo "Install PyCharm"
echo "******************************************************************************"
dnf install -y libgl
wget https://download-cf.jetbrains.com/python/pycharm-community-2020.3.2.tar.gz
tar -xvf pycharm-community-2020.3.2.tar.gz
mv pycharm-community-2020.3.2 pycharm-community
mv pycharm-community /opt/
rm pycharm-community-2020.3.2.tar.gz

echo "alias pycharm=\"/opt/pycharm-community/bin/pycharm.sh &\"" >> /home/docker_user/.bash_profile

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
