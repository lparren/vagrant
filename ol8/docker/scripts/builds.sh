# This is an optional file used for my setup.

echo "******************************************************************************"
echo "Get latest oraclelinux:7/8-slim." `date`
echo "******************************************************************************"

# Get latest oraclelinux:7-slim
sudo docker pull oraclelinux:7-slim
sudo docker pull oraclelinux:8-slim

echo "******************************************************************************"
echo "Copy Oracle 19.3.0 software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/OracleDatabase/19.3.0
cp /vagrant/software/LINUX.X64_193000_db_home.zip .
cp /vagrant/software/ore-server-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-supporting-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-supporting-linux-x86-64-1.5.1.zip .
cp /vagrant/scripts/installORE.sh .
cp /vagrant/scripts/installSampleSchemas.sh .

echo "******************************************************************************"
echo "docker build Oracle 19.3.0 software" `date`
echo "******************************************************************************"
sudo docker build --force-rm=true --no-cache=true   --build-arg DB_EDITION=ee   -t oracle/database:19.3.0-ee  .

#echo "******************************************************************************"
#echo "Copy OracleAnalyticsServer 5.5.0 software." `date`
#echo "******************************************************************************"
#
#cd /u01/dockerfiles/OracleAnalyticsServer/5.5.0
#cp /vagrant/software/V983368-01.zip .
#cp /vagrant/software/V988574-01.zip .
#cp /vagrant/software/jdk-8u241-linux-x64.rpm .
#
#echo "******************************************************************************"
#echo "docker build OracleAnalyticsServer 5.5.0." `date`
#echo "******************************************************************************"
#sudo docker build --force-rm=true --no-cache=true   -t oracle/oas:5.5.0  .

echo "******************************************************************************"
echo "Copy OracleAnalyticsServer 5.9.0 software." `date`
echo "******************************************************************************"

cd /u01/dockerfiles/OracleAnalyticsServer/5.9.0
cp /vagrant/software/jdk-8u281-linux-x64.rpm .
cp /vagrant/software/Oracle_Analytics_Server_Linux_5.9.0.zip .
cp /vagrant/software/fmw_12.2.1.4.0_infrastructure_Disk1_1of1.zip .
cp /vagrant/software/p30657796_122140_Generic.zip .

echo "******************************************************************************"
echo "docker build OracleAnalyticsServer 5.9.0." `date`
echo "******************************************************************************"
sudo docker build --force-rm=true --no-cache=true   -t oracle/oas:5.9.0  .

echo "******************************************************************************"
echo "Copy RStudio software." `date`
echo "******************************************************************************"
cd /u01/dockerfiles/Rstudio
cp /vagrant/software/oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm .
cp /vagrant/software/oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm .
cp /vagrant/software/oracle-instantclient-jdbc-21.1.0.0.0-1.x86_64.rpm .
cp /vagrant/software/oracle-instantclient-odbc-21.1.0.0.0-1.x86_64.rpm .
cp /vagrant/software/oracle-instantclient-sqlplus-21.1.0.0.0-1.x86_64.rpm .
cp /vagrant/software/ore-client-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-server-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-supporting-linux-x86-64-1.5.1.zip .
cp /vagrant/software/rstudio-server-rhel-1.3.1093-x86_64.rpm .

echo "******************************************************************************"
echo "docker build RStudio Server 3.6.1." `date`
echo "******************************************************************************"
sudo docker build --force-rm=true --no-cache=true   -t thedoc/rstudio:3.6.1  .

echo "******************************************************************************"
echo "Copy Zeppelin aditional software." `date`
echo "******************************************************************************"
cd /u01/dockerfiles/Zeppelin
cp /vagrant/software/instantclient*.zip .
cp /vagrant/software/ore-client-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-server-linux-x86-64-1.5.1.zip .
cp /vagrant/software/ore-supporting-linux-x86-64-1.5.1.zip .
cp /vagrant/software/jdk-8u241-linux-x64.rpm .
cp /vagrant/software/zeppelin-0.9.0-bin-all.tgz .

echo "******************************************************************************"
echo "docker build Apache/Zeppelin 0.9.0" `date`
echo "******************************************************************************"
sudo docker build --force-rm=true --no-cache=true   -t thedoc/zeppelin:0.9.0  .

sudo docker image prune -f

echo "******************************************************************************"
echo "Finished"
echo " - user docker run to create an ora1930, OAS55, RStudio and/or Zepplin"
echo "   container"
echo "******************************************************************************"
