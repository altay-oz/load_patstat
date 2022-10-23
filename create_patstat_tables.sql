CREATE TABLE tls201_appln (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_auth char(2) DEFAULT '' NOT NULL,
    appln_nr varchar(15) DEFAULT '' NOT NULL,
    appln_kind char(2) DEFAULT '' NOT NULL,
    appln_filing_date date DEFAULT '9999-12-31' NOT NULL,
    appln_filing_year smallint DEFAULT '9999' NOT NULL,
    appln_nr_epodoc varchar(20) DEFAULT '' NOT NULL,
    appln_nr_original varchar(100) DEFAULT '' NOT NULL,
    ipr_type char(2) DEFAULT '' NOT NULL,
    receiving_office char(2) DEFAULT '' NOT NULL,
    internat_appln_id integer DEFAULT 0 NOT NULL,
    int_phase char(1) DEFAULT 'N' NOT NULL,
    reg_phase char(1) DEFAULT 'N' NOT NULL,
    nat_phase char(1) DEFAULT 'N' NOT NULL,
    earliest_filing_date date DEFAULT '9999-12-31' NOT NULL,
    earliest_filing_year smallint DEFAULT '9999' NOT NULL,
    earliest_filing_id integer DEFAULT 0 NOT NULL,
    earliest_publn_date date DEFAULT '9999-12-31' NOT NULL,
    earliest_publn_year smallint DEFAULT 9999 NOT NULL,
    earliest_pat_publn_id integer DEFAULT 0 NOT NULL,
    granted char(1) DEFAULT 'N' NOT NULL,
    doc_db_family_id integer DEFAULT 0 NOT NULL,
    inpadoc_family_id integer DEFAULT 0 NOT NULL,
    docdb_family_size smallint DEFAULT 0 NOT NULL,
    nb_citing_docdb_fam smallint DEFAULT 0 NOT NULL,
    nb_applicants smallint DEFAULT 0 NOT NULL,
    nb_inventors smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls202_appln_title (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_title_lg char(2) DEFAULT '' NOT NULL,
    appln_title text NOT NULL
);

CREATE TABLE tls203_appln_abstr (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_abstract_lg char(2) DEFAULT '' NOT NULL,
    appln_abstract text DEFAULT '' NOT NULL
);

CREATE TABLE tls204_appln_prior (
    appln_id integer DEFAULT 0 NOT NULL,
    prior_appln_id integer DEFAULT 0 NOT NULL,
    prior_appln_seq_nr smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls205_tech_rel (
    appln_id integer DEFAULT 0 NOT NULL,
    tech_rel_appln_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls206_person (
    person_id integer DEFAULT 0 NOT NULL,
    person_name text DEFAULT '' NOT NULL,
    person_name_orig_lg varchar(500) DEFAULT '' NOT NULL,
    person_address text DEFAULT '' NOT NULL,
    person_ctry_code char(2) DEFAULT '' NOT NULL,
    nuts varchar(5) DEFAULT '' NOT NULL,
    nuts_level smallint DEFAULT 9 NOT NULL,
    doc_std_name_id integer DEFAULT 0 NOT NULL,
    doc_std_name varchar(500) DEFAULT '' NOT NULL,
    psn_id integer DEFAULT 0 NOT NULL,
    psn_name varchar(500) DEFAULT '' NOT NULL,
    psn_level smallint DEFAULT 0 NOT NULL,
    psn_sector varchar(50) DEFAULT '' NOT NULL,
    han_id integer DEFAULT 0 NOT NULL,
    han_name text DEFAULT '' NOT NULL,
    han_harmonized integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls207_pers_appln (
    person_id integer DEFAULT 0 NOT NULL,
    appln_id integer DEFAULT 0 NOT NULL,
    applt_seq_nr smallint DEFAULT 0 NOT NULL,
    invt_seq_nr smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls209_appln_ipc (
    appln_id integer DEFAULT 0 NOT NULL,
    ipc_class_symbol varchar(15) DEFAULT '' NOT NULL,
    ipc_class_level char(1) DEFAULT '' NOT NULL,
    ipc_version date DEFAULT '9999-12-31' NOT NULL,
    ipc_value char(1) DEFAULT '' NOT NULL,
    ipc_position char(1) DEFAULT '' NOT NULL,
    ipc_gener_auth char(2) DEFAULT '' NOT NULL
);

CREATE TABLE tls210_appln_n_cls (
    appln_id integer DEFAULT 0 NOT NULL,
    nat_class_symbol varchar(15) DEFAULT '' NOT NULL
);

CREATE TABLE tls211_pat_publn (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    publn_auth char(2) DEFAULT '' NOT NULL,
    publn_nr varchar(15) DEFAULT '' NOT NULL,
    publn_nr_original varchar(100) DEFAULT '' NOT NULL,
    publn_kind char(2) DEFAULT '' NOT NULL,
    appln_id integer,
    publn_date date DEFAULT '9999-12-31' NOT NULL,
    publn_lg char(2) DEFAULT '' NOT NULL,
    publn_first_grant char(1) DEFAULT '' NOT NULL,
    publn_claims integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls212_citation (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    citn_replenished integer DEFAULT 0 NOT NULL,
    citn_id smallint DEFAULT 0 NOT NULL,
    citn_origin char(3) DEFAULT '' NOT NULL,
    cited_pat_publn_id integer DEFAULT 0 NOT NULL,
    cited_appln_id integer DEFAULT 0 NOT NULL,
    pat_citn_seq_nr smallint DEFAULT 0::smallint NOT NULL,
    cited_npl_publn_id varchar(32) DEFAULT '0' NOT NULL,
    npl_citn_seq_nr smallint DEFAULT 0 NOT NULL,
    citn_gener_auth char(2) DEFAULT '' NOT NULL
);

CREATE TABLE tls214_npl_publn (
    npl_publn_id varchar(32) DEFAULT '0' NOT NULL,
    xp_nr integer DEFAULT 0 NOT NULL,
    npl_type char(1) DEFAULT '' NOT NULL,
    npl_biblio text DEFAULT '' NOT NULL,
    npl_author varchar(1000) DEFAULT '' NOT NULL,
    npl_title1 varchar(1000) DEFAULT '' NOT NULL,
    npl_title2 varchar(1000) DEFAULT '' NOT NULL,
    npl_editor varchar(500) DEFAULT '' NOT NULL,
    npl_volume varchar(50) DEFAULT '' NOT NULL,
    npl_issue varchar(50) DEFAULT '' NOT NULL,
    npl_publn_date varchar(8) DEFAULT '' NOT NULL,
    npl_publn_end_date varchar(8) DEFAULT '' NOT NULL,
    npl_publisher varchar(500) DEFAULT '' NOT NULL,
    npl_page_first varchar(200) DEFAULT '' NOT NULL,
    npl_page_last varchar(200) DEFAULT '' NOT NULL,
    npl_abstract_nr varchar(50) DEFAULT '' NOT NULL,
    npl_doi varchar(500) DEFAULT '' NOT NULL,
    npl_isbn varchar(30) DEFAULT '' NOT NULL,
    npl_issn varchar(30) DEFAULT '' NOT NULL,
    online_availability varchar(500) DEFAULT '' NOT NULL,
    online_classification varchar(35) DEFAULT '' NOT NULL,
    online_search_date varchar(8) DEFAULT '' NOT NULL
);

CREATE TABLE tls215_citn_categ (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    citn_replenished integer DEFAULT 0 NOT NULL,
    citn_id smallint DEFAULT 0 NOT NULL,
    citn_categ varchar(10) DEFAULT '' NOT NULL,
    relevant_claim smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls216_appln_contn (
    appln_id integer DEFAULT 0 NOT NULL,
    parent_appln_id integer DEFAULT 0 NOT NULL,
    contn_type char(3) DEFAULT '' NOT NULL
);

CREATE TABLE tls222_appln_jp_class (
    appln_id integer DEFAULT 0 NOT NULL,
    jp_class_scheme varchar(5) DEFAULT '' NOT NULL,
    jp_class_symbol varchar(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls223_appln_docus (
    appln_id integer DEFAULT 0 NOT NULL,
    docus_class_symbol varchar(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls224_appln_cpc (
    appln_id integer DEFAULT 0 NOT NULL,
    cpc_class_symbol varchar(19) DEFAULT '' NOT NULL
);

CREATE TABLE tls225_docdb_fam_cpc (
    docdb_family_id integer DEFAULT 0 NOT NULL,
    cpc_class_symbol varchar(19) DEFAULT '' NOT NULL,
    cpc_gener_auth varchar(2) DEFAULT '' NOT NULL,
    cpc_version date DEFAULT '9999-12-31' NOT NULL,
    cpc_position char(1) DEFAULT '' NOT NULL,
    cpc_value char(1) DEFAULT '' NOT NULL,
    cpc_action_date date DEFAULT '9999-12-31' NOT NULL,
    cpc_status char(1) DEFAULT '' NOT NULL,
    cpc_data_source char(1) DEFAULT '' NOT NULL
);

CREATE TABLE tls226_person_orig (
	person_orig_id integer DEFAULT 0 NOT NULL,
	person_id integer DEFAULT 0 NOT NULL,
	source char(5) DEFAULT '' NOT NULL,
	source_version varchar(10) DEFAULT '' NOT NULL,
	name_freeform varchar(500) DEFAULT '' NOT NULL,
	person_name_orig_lg varchar(500) DEFAULT '' NOT NULL,
	last_name varchar(500) DEFAULT '' NOT NULL,
	first_name varchar(500) DEFAULT '' NOT NULL,
	middle_name varchar(500) DEFAULT '' NOT NULL,
	address_freeform varchar(1000) DEFAULT '' NOT NULL,
	address_1 varchar(500) DEFAULT '' NOT NULL,
	address_2 varchar(500) DEFAULT '' NOT NULL,
	address_3 varchar(500) DEFAULT '' NOT NULL,
	address_4 varchar(500) DEFAULT '' NOT NULL,
	address_5 varchar(500) DEFAULT '' NOT NULL,
	street varchar(500) DEFAULT '' NOT NULL,
	city varchar(200) DEFAULT '' NOT NULL,
  	zip_code varchar(30) DEFAULT '' NOT NULL,
	state char(2) DEFAULT '' NOT NULL,
	person_ctry_code char(2) DEFAULT '' NOT NULL,
	residence_ctry_code char(2) DEFAULT '' NOT NULL,
	role varchar(2) DEFAULT '' NOT NULL
);


CREATE TABLE tls227_pers_publn (
    person_id integer DEFAULT 0 NOT NULL,
    pat_publn_id integer DEFAULT 0 NOT NULL,
    applt_seq_nr integer DEFAULT 0 NOT NULL,
    invt_seq_nr integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls228_docdb_fam_citn (
    docdb_family_id integer DEFAULT 0 NOT NULL,
    cited_docdb_family_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls229_appln_nace2 (
    appln_id integer DEFAULT 0 NOT NULL,
    nace2_code varchar(5) DEFAULT '' NOT NULL,
    weight numeric DEFAULT 1 NOT NULL
);

CREATE TABLE tls230_appln_techn_field (
    appln_id integer DEFAULT 0 NOT NULL,
    techn_field_nr smallint DEFAULT 0 NOT NULL,
    weight numeric DEFAULT 1 NOT NULL
);

CREATE TABLE tls231_inpadoc_legal_event (
    event_id integer DEFAULT 0 NOT NULL,
    appln_id integer DEFAULT 0 NOT NULL,
    event_seq_nr smallint DEFAULT 0,
    event_type char(3) DEFAULT '',
    event_auth char(2) DEFAULT '',
    event_code varchar(4)  DEFAULT '',
    event_filing_date date DEFAULT '9999-12-31' NOT NULL,
    event_publn_date date DEFAULT '9999-12-31' NOT NULL,
    event_effective_date date DEFAULT '9999-12-31' NOT NULL,
    event_text text DEFAULT '',
    ref_doc_auth char(2) DEFAULT '',
    ref_doc_nr varchar(20) DEFAULT '',
    ref_doc_kind char(2) DEFAULT '',
    ref_doc_date date DEFAULT '9999-12-31' NOT NULL,
    ref_doc_text text DEFAULT '',
    party_type varchar(3) DEFAULT '',
    party_seq_nr smallint default '0',
    party_new text DEFAULT '',
    party_old text DEFAULT '',
    spc_nr varchar(40) DEFAULT '',
    spc_filing_date date DEFAULT '9999-12-31' NOT NULL,
    spc_patent_expiry_date date DEFAULT '9999-12-31' NOT NULL,
    spc_extension_date date DEFAULT '9999-12-31' NOT NULL,
    spc_text text DEFAULT '',
    designated_states text DEFAULT '',
    extension_states varchar(30) DEFAULT '',
    fee_country char(2) DEFAULT '',
    fee_payment_date date DEFAULT '9999-12-31' NOT NULL,
    fee_renewal_year smallint DEFAULT '9999' NOT NULL,
    fee_text text DEFAULT '',
    lapse_country char(2) DEFAULT '',
    lapse_date date  DEFAULT '9999-12-31' NOT NULL,
    lapse_text text DEFAULT '',
    reinstate_country char(2) DEFAULT '',
    reinstate_date date DEFAULT '9999-12-31' NOT NULL,
    reinstate_text text DEFAULT '',
    class_scheme varchar(4) DEFAULT '',
    class_symbol varchar(50) DEFAULT ''
);

CREATE TABLE tls801_country (
    ctry_code char(2) DEFAULT '' NOT NULL,
    iso_alph3 varchar(3) DEFAULT '' NOT NULL,
    st3_name varchar(100) DEFAULT '' NOT NULL,
    organisation_flag char(1) DEFAULT '' NOT NULL,
    continent varchar(25) DEFAULT '' NOT NULL,
    eu_member varchar(1) DEFAULT '' NOT NULL,
    epo_member varchar(1) DEFAULT '' NOT NULL,
    oecd_member varchar(1) DEFAULT '' NOT NULL,
    discontinued varchar(1) DEFAULT '' NOT NULL
);


CREATE TABLE tls803_legal_event_code (
    event_auth char(2) DEFAULT '' NOT NULL,
    event_code varchar(4) DEFAULT '' NOT NULL,
    event_impact char(1) DEFAULT '',
    event_descr varchar(250) DEFAULT '',
    event_descr_orig varchar(250) DEFAULT '',
    event_category_code char(1) DEFAULT '',
    event_category_title varchar(100) DEFAULT ''
);

CREATE TABLE tls901_techn_field_ipc (
    ipc_maingroup_symbol varchar(8) DEFAULT '' NOT NULL,
    techn_field_nr smallint DEFAULT 0 NOT NULL,
    techn_sector varchar(50) DEFAULT '' NOT NULL,
    techn_field varchar(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls902_ipc_nace2 (
    ipc varchar(8) DEFAULT '' NOT NULL,
    not_with_ipc varchar(8) DEFAULT '' NOT NULL,
    unless_with_ipc varchar(8) DEFAULT '' NOT NULL,
    nace2_code varchar(5) DEFAULT '' NOT NULL,
    nace2_weight smallint DEFAULT 1 NOT NULL,
    nace2_descr varchar(150) DEFAULT '' NOT NULL
);

CREATE TABLE tls904_nuts (
    nuts varchar(5) DEFAULT ('') NOT NULL,
    nuts_level smallint DEFAULT '0',
    nuts_label varchar(250) DEFAULT ''
);
