# VirtualBox VM for Docker Vagrant Build

I use a VirtualBox VM for playing around with Docker builds. This represents the base of that VM.

## Required Software

* [Vagrant](https://www.vagrantup.com/downloads.html)
* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)

## Build

### Install the vagrant virtualbox guest additions plug-in

```
vagrant plugin install vagrant-vbguest
```

### Start Vitrual machine
```
vagrant up
```

### Oracle Software
In addition you will need to download all the required software and put it into the "software" directory, so it can be copied into place and used during the builds.

for Oracle Database
- jdk-8u241-linux-x64.rpm
- LINUX.X64_193000_db_home.zip
- V983368-01.zip
- V988574-01.zip

for db-sample-schemas
- [db-sample-schemas-master.zip](https://github.com/oracle/db-sample-schemas/archive/master.zip)

for RStudio
- oracle-instantclient-basic-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-devel-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-jdbc-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-odbc-21.1.0.0.0-1.x86_64.rpm
- oracle-instantclient-sqlplus-21.1.0.0.0-1.x86_64.rpm
- ore-client-linux-x86-64-1.5.1.zip
- ore-server-linux-x86-64-1.5.1.zip
- ore-supporting-linux-x86-64-1.5.1.zip
- rstudio-server-rhel-1.3.1093-x86_64.rpm

With all software in place login to the virtual machine and start the build script
```
/vagrant/scripts/build.sh
```
after build there will be a database, OAS and RStudio image:

```
[docker_user@localhost ~]$ docker images

REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
thedoc/rstudio      3.6.1               dd70769d8638        17 minutes ago      2.15GB
oracle/oas          5.5.0               201ec1e6fc1c        4 weeks ago         21.5GB
oracle/database     19.3.0-ee           9b798901a56e        4 weeks ago         6.54GB
oraclelinux         7-slim              dc7e50513559        6 weeks ago         132MB
```

### Create the network and volume for the database and oas container
```
sudo docker network create --subnet=172.18.0.0/16 oracle_network
sudo docker volume create --name ora1930_oradata --opt type=none --opt device=/u01/volumes/ora1930_oradata/ --opt o=bind
```

### Start Oracle database container
```
 sudo docker run --name ora1930 \
  --detach \
  --network oracle_network \
  --ip 172.18.0.22 \
  -p 1521:1521 -p 5500:5500 \
  -e ORACLE_SID=db1930 \
  -e ORACLE_PDB=pdb1930 \
  -e ORACLE_PWD=oracle \
  --mount source=ora1930_oradata,destination=/opt/oracle/oradata \
  oracle/database:19.3.0-ee

docker logs -f ora1930
```

### Start Oracle OAS 5.5.0 container
```
sudo docker run --name oas55 \
  --detach \
  --network=oracle_network \
  -p 9500-9514:9500-9514 \
  --stop-timeout 600 \
  -e "BI_CONFIG_RCU_DBSTRING=172.18.0.22:1521:pdb1930" \
  -e "BI_CONFIG_RCU_PWD=oracle" \
  oracle/oas:5.5.0

docker logs -f oas55
```

### Start RStudio container
```
sudo docker run --name rstudio \
  --detach \
  --network oracle_network \
  -p 8787:8787 \
  thedoc/rstudio:3.6.1

docker logs -f rstudio
```

### Start Apache Zeppelin
```
docker run --name zeppelin \
  --detach \
  --network oracle_network \
  -p 8888:8080 \
  -e ORACLE_CONNECT=172.18.0.22:1521/pdb1930 \
  -e ORACLE_USER=bi \
  -e ORACLE_PASSWORD=bi \
  -v /u01/zeppelin/logs:/zeppelin/logs \
  -v /u01/zeppelin/notebook:/zeppelin/notebook \
  thedoc/zeppelin:0.9.0

  docker logs -f zeppelin
```
