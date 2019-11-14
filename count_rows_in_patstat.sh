#!/bin/bash
# count row numbers in patstat db

IFS=$'\n'

# number of rows are in the Readmefirst PATSTAT.pdf 

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
tls223_appln_docus
tls224_appln_cpc
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
tls904_nuts
tls906_person"

for i in ${table_name_count}
do
    table_name=`echo $i | cut -f1 -d" "`
#    epo_count=`echo $i | cut -f2 -d" "`
    db_count=`psql -t -c "SELECT count(*) FROM $table_name" patstat`

:'
    diff=$(($epo_count - $db_count))

    if [[ $diff == 0 ]]; then
	echo "$table_name OK! Number of rows inserted and given by EPO are equal."
    elif [[ $diff < 0 ]]; then
	echo "$table_name, ${diff#-} MORE rows ARE INSERTED. ++++++++++++++++++++"
    elif [[ $diff > 0 ]]; then
	echo "$table_name, $diff rows are NOT INSERTED.--------------------------"
    fi
    echo "table_name = $table_name, epo_count = $epo_count, db_count = $db_count, diff = $diff"
    echo " "
'

echo "$table_name contains $epo_count lines."

done

#set +x

