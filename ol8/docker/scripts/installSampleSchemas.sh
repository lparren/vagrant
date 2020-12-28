echo "*******************************************************"
echo "*** Installing db sample schemas                    ***"
echo "*******************************************************"
cd /opt/oracle
unzip db-sample-schemas-master.zip
cd db-sample-schemas-master
perl -p -i.bak -e 's#__SUB__CWD__#'$(pwd)'#g' *.sql */*.sql */*.dat 
echo "exit" >> mksample.sql
sqlplus system/$ORACLE_PWD@localhost:1521/$ORACLE_PDB @mksample $ORACLE_PWD $ORACLE_PWD hr oe pm ix sh bi users temp . localhost:1521/$ORACLE_PDB