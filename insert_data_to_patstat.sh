#!/bin/bash

# Copyright (c) 2015 Altay Özaygen

# this script has tree parts
# 1- creating tables in PATSTAT
# 2- inserting data into the database by using csv files.
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

export PGPASSWORD=''
read -e -p "Enter the path to the csv files: [/path/to/patstat/zip_files] " CSV_FILES_DIR

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
tls222_appln_jp_class
tls223_appln_docus
tls224_appln_cpc
tls225_docdb_fam_cpc
tls226_person_orig
tls227_pers_publn
tls228_docdb_fam_citn
tls229_appln_nace2
tls230_appln_techn_field
tls231_inpadoc_legal_event
tls801_country
tls803_legal_event_code
tls901_techn_field_ipc
tls902_ipc_nace2
tls904_nuts"

# creating tables within the PATSTAT database
psql -h localhost -U patstat patstat < ./create_patstat_tables.sql

for table_name in $table_list
do
   echo $table_name
   # extract the tlsXXX part from the table name
   base_name="${table_name:0:6}"
   echo $base_name

   # for files starting tlsXXX_partXXX.csv
   for file in "$CSV_FILES_DIR/"$base_name*
   do
       psql -h localhost -U patstat -c "\COPY $table_name from '$file' DELIMITER AS ',' CSV HEADER QUOTE AS '\"' " patstat
       echo "INSERTED $file"
       echo " "
   done
done

echo "creating indexes and keys, it will take very long hours, don't despair :)"
psql -h localhost -U patstat patstat < ./create_patstat_keys.sql 

echo "The script has finished."
