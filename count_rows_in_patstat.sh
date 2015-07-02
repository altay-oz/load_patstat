#!/bin/bash
# count row numbers in patstat db

IFS=$'\n'

# number of rows are in the Readmefirst PATSTAT.pdf 

table_name_count="
tls201_appln 81712369
tls202_appln_title 61941962	
tls203_appln_abstr 38478164
tls204_appln_prior 35878709
tls205_tech_rel 2152357
tls207_pers_appln 183138658	
tls209_appln_ipc 200557856
tls210_appln_n_cls 22016036
tls211_pat_publn 92588813
tls212_citation 170660156
tls214_npl_publn 27201124
tls215_citn_categ 24489486
tls216_appln_contn 2560156
tls218_docdb_fam 72642819
tls219_inpadoc_fam 79977867
tls222_appln_jp_class 305790087
tls223_appln_docus 39008363
tls224_appln_cpc 160309501
tls227_pers_publn 219902427
tls228_docdb_fam_citn 108369549
tls229_appln_nace2 99227516
tls801_country 234
tls901_techn_field_ipc 754
tls902_ipc_nace2 827
tls906_person 49078172"

for i in ${table_name_count}
do
    table_name=`echo $i | cut -f1 -d" "`
    epo_count=`echo $i | cut -f2 -d" "`
    db_count=`psql -t -c "SELECT count(*) FROM $table_name" patstat`

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
done

#set +x

