#!/bin/bash

# Copyright (c) 2015 Altay Özaygen

# this script has tree parts
# 1- creating tables in PATSTAT
# 2- inserting data into the database by using zip files obtained from CDs.
# 3- creaing indexes in PATSTAT. This one is taking more time than the
#    second step.

# control wheather all other files are present
if [ ! -e ./create_patstat_tables.sql ]; then
    echo "There is no create_patstat_tables.sql file!"
    exit 0
fi

if [ ! -e ./create_patstat_keys.sql ]; then
    echo "There is no create_patstat_keys.sql file!"
    exit 0
fi

# creating tables within the PATSTAT database
psql patstat < ./create_patstat_tables.sql

read -e -p "Enter the path to the zip files: [/path/to/patstat/zip_files]" ZIP_FILES_DIR

TMP_DIR=$ZIP_FILES_DIR/tmp

if [ ! -d $TMP_DIR ]; then
    mkdir $TMP_DIR
fi

# list of tables to be filled
table_list="	
tls201_appln
tls202_appln_title	
tls203_appln_abstr	
tls204_appln_prior	
tls205_tech_rel		
tls206_person
tls207_pers_appln	
tls209_appln_ipc	
tls210_appln_n_cls
tls211_pat_publn	
tls212_citation
tls214_npl_publn
tls215_citn_categ	
tls216_appln_contn	
tls218_docdb_fam	
tls219_inpadoc_fam
tls222_appln_jp_class	
tls223_appln_docus	
tls224_appln_cpc
tls227_pers_publn
tls228_docdb_fam_citn
tls229_appln_nace2
tls801_country
tls901_techn_field_ipc
tls902_ipc_nace2"

# control if there are zip files in the given directory
count=`ls $ZIP_FILES_DIR/*.zip 2>/dev/null | wc -l`
if [ $count == 0 ]; then
    echo "There is no zip file in ", $ZIP_FILES_DIR
    exit 0
fi

for table_name in $table_list
do
   echo $table_name
   # extract the tlsXXX part from the table name
   base_name="${table_name:0:6}"
   echo $base_name

   # for files starting tlsXXX_partXXX.gzip
   for file in $ZIP_FILES_DIR/$base_name*
   do
       # file tlsXXX_partXXX.zip is unziped in a temporary directory
       echo "unziping $file"
       gunzip -c $file > $TMP_DIR/file_to_be_inserted.csv
       psql -c "\COPY $table_name from '$TMP_DIR/file_to_be_inserted.csv' DELIMITER AS ',' CSV HEADER QUOTE AS '\"' " patstat
       echo "INSERTED $file"
   done
done

# cleaning the rest
rm $TMP_DIR/file_to_be_inserted.csv
rmdir $TMP_DIR

# creating index, it will take very long hours, don't despair :)
psql patstat < ./create_patstat_keys.sql
