## EPO PATSTAT (2021 spring) installation bash scripts for PostgreSQL

These scripts help to insert data into PATSTAT DB from zip files found
in PATSTAT bulk data sets.

The patstat_example_queries.sql file includes SQLs given in Gaétan de
Rassenfosse, Hélène Dernis, Geert Boedt (2014, 1 April version), An
introduction to the Patstat database with example queries.

Please take into account to use dos2unix or unix2dos to adjust the file
format to your used system.  These scripts were tested with Ubuntu 18
for the PATSTAT 2021 version and Debian 10 and 11 for the PATSTAT 2019.

First, all zip files should be copied into a folder, preferably in an
external hard disk or a HD other than the one containing the PATSTAT DB.

The database PATSTAT should be created in PostgreSQL. To create the
PATSTAT DB you should become a postgres user then in the postgres shell
enter the following commands;

postgres=# CREATE USER _your_user_name_ WITH PASSWORD '_your_password_';         
postgres=# CREATE DATABASE patstat;                                           
postgres=# GRANT ALL PRIVILEGES ON DATABASE patstat to _your_user_name_;     

This is the simplest type to create a user and a database, please give
attention to your system security.

Then run insert_data_patstat.sh, after few hours to control the number
of rows in the patstat database run count_rows_in_patstat.sh

