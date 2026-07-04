#!/bin/bash

# Copyright (c) 2019-2026 Altay Özaygen

# this script has tree parts
# 0- unzip files obtained from EPO to obtain few zip files containing data only for a single table
# 1- creating tables in PATSTAT
# 2- inserting data into the database by using zip files obtained from CDs.
# 3- creaing indexes in PATSTAT. This one is taking more time than the
#    second step.

# ============================================================================
# SECTION 0: PREREQUISITE CHECKS
# ============================================================================

# control wheather all other files are present
if [ ! -e ./create_patstat_tables.sql ]; then
    echo "There is no create_patstat_tables.sql file!"
    exit 1
fi

if [ ! -e ./create_patstat_keys.sql ]; then
    echo "There is no create_patstat_keys.sql file!"
    exit 1
fi

# Check if unzip is installed, exit if not
if ! command -v unzip &> /dev/null; then
    echo "Error: unzip is not installed. Please install it and try again."
    exit 1
fi


# Check if psql is installed
if ! command -v psql &> /dev/null; then
    echo "Error: psql (PostgreSQL client) is not installed. Please install PostgreSQL and try again."
    exit 1
fi

# ============================================================================
# SECTION 1: CONFIGURATION
# ============================================================================

# give a name for the patstat database
read -e -p "Enter the name of the database: [patstat_year_edition] " PATSTAT_DB_NAME

# Define timestamp for the filename (using underscores for better CLI compatibility)
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
LOGFILE="data_insert_${TIMESTAMP}_${PATSTAT_DB_NAME}.log"


# ============================================================================
# SECTION 2: DATABASE VALIDATION
# ============================================================================

# check if the patstat database is created
if psql -lqt | cut -d \| -f 1 | grep -qw $PATSTAT_DB_NAME; then
    # database exists
    echo "Database '$PATSTAT_DB_NAME' exists. Installation starting..."
else
    echo "Database '$PATSTAT_DB_NAME' does not exists."
    echo "To create the PATSTAT DB you should become a postgres user then in the postgres shell enter the following commands;
postgres=# CREATE USER your_user_name WITH PASSWORD 'your_password';
postgres=# CREATE DATABASE $PATSTAT_DB_NAME;
postgres=# ALTER DATABASE $PATSTAT_DB_NAME OWNER TO your_user_name;"
    exit 1
fi

read -e -p "Enter the path for the zip files: [/path/to/patstat/zip_files] " ZIP_FILES_DIR

# If user pressed Enter without input, prompt again (no default for safety)
if [ -z "$ZIP_FILES_DIR" ]; then
    echo "Error: Zip files directory is required!"
    exit 1
fi

# Remove trailing slash if present
ZIP_FILES_DIR="${ZIP_FILES_DIR%/}"

# Check if the directory exists
if [ ! -d "$ZIP_FILES_DIR" ]; then
    echo "Error: Directory '$ZIP_FILES_DIR' does not exist!"
    exit 1
fi

# Check if there are zip files in the given directory
ZIP_COUNT=$(ls "$ZIP_FILES_DIR"/*.zip 2>/dev/null | wc -l)
if [ "$ZIP_COUNT" -eq 0 ]; then
    echo "Error: No zip files found in '$ZIP_FILES_DIR'"
    exit 1
else
    echo "Found $ZIP_COUNT zip files in '$ZIP_FILES_DIR'"
fi

# ============================================================================
# SECTION 3: CREATE TEMPORARY DIRECTORY
# ============================================================================

## defining tmp directory
TMP_DIR=$ZIP_FILES_DIR"/tmp/"

## defining tmp directory
if [ ! -d "$TMP_DIR" ]; then
    mkdir "$TMP_DIR"
    echo "Created temporary directory: $TMP_DIR"
fi

# ============================================================================
# SECTION 4: TABLE LIST
# ============================================================================

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


# ============================================================================
# SECTION 5: CREATE TABLES
# ============================================================================

echo "========================================="
echo "Step 1: Creating tables in PATSTAT"
echo "========================================="
echo "Logging to: $LOGFILE"

# Create tables within the PATSTAT database
{
    echo "--- Creating tables in $PATSTAT_DB_NAME ---"
    psql "$PATSTAT_DB_NAME" < ./create_patstat_tables.sql
} 2>&1 | tee -a "$LOGFILE"

# Check if table creation was successful
if [ $? -ne 0 ]; then
    echo "Error: Failed to create tables. Please check the log file: $LOGFILE"
    exit 1
fi

# Ask if user wants to create indexes later
while true; do
    read -e -p "Do you want to create keys and indexes after data insertion? (y/n) " INDEX_Y
    case "$INDEX_Y" in
        y|Y|yes|Yes|YES)
            INDEX_Y="y"
            break
            ;;
        n|N|no|No|NO)
            INDEX_Y="n"
            break
            ;;
        *)
            echo "Please answer 'y' or 'n'"
            ;;
    esac
done

# ============================================================================
# SECTION 6: INSERT DATA
# ============================================================================

echo "========================================="
echo "Step 2: Inserting data into database"
echo "========================================="
echo "Logging to: $LOGFILE"
echo "Processing $ZIP_COUNT zip files..."

# Process each table
for table_name in $table_list
do
    echo "--- Processing table: $table_name ---"
    base_name="${table_name:0:6}"

    for file in "$ZIP_FILES_DIR"/$base_name*
    do
        {
            echo "Unzipping $file"

	    # Unzip the file directly to CSV
            unzip -p "$file" > "$TMP_DIR/"file_to_be_inserted.csv

            # Remove Windows line endings (CRLF -> LF)
            sed -i 's/\r//g' "$TMP_DIR/file_to_be_inserted.csv"

            echo "Inserting into $table_name..."
            # 2>&1 ensures psql errors are captured by tee
            psql -c "\COPY $table_name FROM '$TMP_DIR/file_to_be_inserted.csv' WITH (FORMAT CSV, HEADER, QUOTE '\"', DELIMITER ',')" "$PATSTAT_DB_NAME" 2>&1 | tee -a "$LOGFILE"

            echo "FINISHED $file"
            echo " "
        } | tee -a "$LOGFILE"
    done
done

# ============================================================================
# SECTION 7: CLEANUP
# ============================================================================

# cleaning the rest
rm "$TMP_DIR/"file_to_be_inserted.csv
rmdir "$TMP_DIR"


# ============================================================================
# SECTION 8: CREATE INDEXES
# ============================================================================

echo "========================================="
echo "Step 3: Index creation"
echo "========================================="

# index creation, it will take very long hours, don't despair :)
if [ $INDEX_Y == 'y' ]; then
    echo "Creating indexes and keys. This will take some time, be patient."
    echo "Starting at: $(date)"

    if psql "$PATSTAT_DB_NAME" < ./create_patstat_keys.sql 2>&1 | tee -a "$LOGFILE"; then
        echo "Indexes and keys created successfully!"
    else
        echo "Error: Failed to create indexes and keys. Check the log file: $LOGFILE"
        exit 1
    fi

    echo "Finished at: $(date)"
else
    echo "You chose not to create indexes and keys."
    echo "To create them later, run:"
    echo "  psql $PATSTAT_DB_NAME < ./create_patstat_keys.sql"
fi

echo "Script completed!"

