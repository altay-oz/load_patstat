#!/bin/bash
# count row numbers in patstat db

# define the patstat database name
read -e -p "Enter the name of the database: [patstat_year_edition] " PATSTAT_DB_NAME

# Define timestamp for the filename (using underscores for better CLI compatibility)
TIMESTAMP=$(date "+%Y-%m-%d_%H-%M-%S")
LOGFILE="db_counts_${TIMESTAMP}_${PATSTAT_DB_NAME}.log"

IFS=$'\n'

# row count for each table documented by EPO in text file located at /CreateScripts/

table_name_count="
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

for table_name in ${table_name_count}
do
    # Get the count silently
    row_count=$(psql -t -c "SELECT count(*) FROM $table_name" "$PATSTAT_DB_NAME" | xargs)

    # Log and display the formatted output
    echo "$table_name, row_count = $row_count" | tee -a "$LOGFILE"
    echo " " | tee -a "$LOGFILE"
done
