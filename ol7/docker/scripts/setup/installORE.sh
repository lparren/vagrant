# Make sure ORE can be executed
chmod 755 ORE

# Save original R packages
cd $ORACLE_HOME/R/library

mv ORE ORE.orig
mv OREbase OREbase.orig
mv OREcommon OREcommon.orig
mv OREdm OREdm.orig
mv OREdplyr OREdplyr.orig
mv OREeda OREeda.orig
mv OREembed OREembed.orig
mv OREgraphics OREgraphics.orig
mv OREmodels OREmodels.orig
mv OREpredict OREpredict.orig
mv OREserver OREserver.orig
mv OREstats OREstats.orig
mv ORExml ORExml.orig

# Unzip ORE files
cd /opt/install
unzip $ORE_SERVER
unzip $ORE_SUPPORT


# install all tar.gz files
cd /opt/install/server
for f in ./*; do
     case "$f" in
         *.tar.gz)     echo "$0: running $f"; ORE CMD INSTALL "$f" ;;
     esac
     echo "";
 done
 
# Run rqcfg
sqlplus sys/$ORACLE_PWD@$ORACLE_PDB  @$ORACLE_HOME/R/server/rqcfg.sql sysaux temp $ORACLE_HOME /usr/lib64/R 

# install all tar.gz files
cd /opt/install/supporting
for f in ./*; do
     case "$f" in
         *.tar.gz)     echo "$0: running $f"; ORE CMD INSTALL "$f" ;;
     esac
     echo "";
 done

