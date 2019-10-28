#!/bin/bash

# Copyright (c) 2015 Altay Özaygen

# insert data into patstat db for tls221 and tls802 tables from zip files

# this script has tree parts
# 1- creating tables in PATSTAT
# 2- inserting data into the database by using zip files obtained from CDs.
# 3- creaing indexes in PATSTAT. This one is taking more time than the
#    second step.

# creating tables within the PATSTAT database
psql patstat < ./create_patstat_legal_events_tables.sql

read -e -p "Enter the path to the zip files: [/path/to/patstat/zip_files]" ZIP_FILES_DIR

TMP_DIR=$ZIP_FILES_DIR/tmp

if [ ! -d $TMP_DIR ]; then
    mkdir $TMP_DIR
fi

# list of tables to be filled

table_list="tls221_inpadoc_prs
tls802_legal_event_code"


for table_name in $table_list
do
   echo $table_name
   # extract the tlsXXX part from the table name
   base_name="${table_name:0:6}"
   echo $base_name

   # for files starting tlsXXX_partXXX.gzip
   for file in $ZIP_FILES_DIR/$base_name*
   do
       # file tlsXXX_partXXX.gzip is unziped in a temporary directory
       echo "gunzip'ing $file"
       gunzip -c $file > $TMP_DIR/file_to_be_inserted.csv
       psql -c "\COPY $table_name from '$TMP_DIR/file_to_be_inserted.csv' DELIMITER AS ',' CSV HEADER QUOTE AS '\"' " patstat
       echo "INSERTED $file"
   done
done

# cleaning the rest
rm $TMP_DIR/file_to_be_inserted.csv
rmdir $TMP_DIR

# creating index
psql patstat < ./create_patstat_legal_events_keys.sql
