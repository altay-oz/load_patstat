EPO PATSTAT (2015 autumn amended version) installation bash scripts for PostgreSQL

These scripts help to insert data into PATSTAT DB from zip files found in PATSTAT CDs.                

First all zip files found in the CDs should be copied into a folder, preferably in an external hard disk or a HD other than the one containing the PATSTAT DB.                         

The database PATSTAT should be created in PostgreSQL to create the PATSTAT DB you should become a postgres user then in the postgres shell enter the following commands;

postgres=# CREATE USER _your_user_name_ WITH PASSWORD '_your_password_';         
postgres=# CREATE DATABASE patstat;                                           
postgres=# GRANT ALL PRIVILEGES ON DATABASE patstat to _your_user_name_;     

Then run insert_data_patstat.sh, after few hours to control the number of rows in the patstat database run count_rows_in_patstat.sh
