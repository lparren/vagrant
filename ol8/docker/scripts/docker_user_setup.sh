# Clone the latest Git repository. Use SSH so no password.
cd /u01
git clone https://github.com/lparren/dockerfiles.git
#git clone https://github.com/oracle/db-sample-schemas.git
#cd /u01/db-sample-schemas
#perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat 

echo "*******************************************************"
echo "*** You need to copy all the software in place now! ***"
echo "*** /vagrant/scripts/builds.sh                      ***"
echo "*******************************************************"
