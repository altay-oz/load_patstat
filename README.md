EPO PATSTAT (2019 spring) installation bash scripts for PostgreSQL

These scripts help to insert data into PATSTAT DB from zip files found in PATSTAT bulk data sets.                

First, all zip files should be copied into a folder, preferably in an external hard disk or a HD other than the one containing the PATSTAT DB.                         

The database PATSTAT should be created in PostgreSQL. To create the PATSTAT DB you should become a postgres user then in the postgres shell enter the following commands;

postgres=# CREATE USER _your_user_name_ WITH PASSWORD '_your_password_';         
postgres=# CREATE DATABASE patstat;                                           
postgres=# GRANT ALL PRIVILEGES ON DATABASE patstat to _your_user_name_;     

This is the simplest type to create a user and a database, please give attention to your system security. 

Then run insert_data_patstat.sh, after few hours to control the number of rows in the patstat database run count_rows_in_patstat.sh
