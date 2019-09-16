CREATE TABLE tls201_appln (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_auth character(2) DEFAULT '' NOT NULL,
    appln_nr character varying(15) DEFAULT '' NOT NULL,
    appln_kind character(2) DEFAULT '  ' NOT NULL,
    appln_filing_date date DEFAULT '9999-12-31' NOT NULL,
    appln_filing_year smallint DEFAULT '9999' NOT NULL,	
    appln_nr_epodoc character varying(20) DEFAULT '' NOT NULL,
    ipr_type character(2) DEFAULT '' NOT NULL,
    internat_appln_id integer DEFAULT 0 NOT NULL,
    earliest_filing_date date DEFAULT '9999-12-31' NOT NULL,
    earliest_filing_year smallint DEFAULT '9999' NOT NULL,
    earliest_filing_id integer DEFAULT 0 NOT NULL,
    earliest_publn_date date DEFAULT '9999-12-31' NOT NULL,
    earliest_publn_year smallint DEFAULT 9999 NOT NULL,
    earliest_pat_publn_id integer DEFAULT 0 NOT NULL,
    granted smallint DEFAULT 0 NOT NULL,
    doc_db_family_id integer DEFAULT 0 NOT NULL,
    inpadoc_family_id integer DEFAULT 0 NOT NULL,
    docdb_family_size smallint DEFAULT 0 NOT NULL,
    nb_citing_docdb_fam smallint DEFAULT 0 NOT NULL,
    nb_applicants smallint DEFAULT 0 NOT NULL,
    nb_inventors smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls202_appln_title (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_title_lg character(2) DEFAULT '' NOT NULL,
    appln_title text NOT NULL
);

CREATE TABLE tls203_appln_abstr (
    appln_id integer DEFAULT 0 NOT NULL,
    appln_abstract_lg character(2) DEFAULT '' NOT NULL,
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
    person_address text DEFAULT '' NOT NULL,
    person_ctry_code character varying(2) DEFAULT '' NOT NULL, 
    doc_std_name_id integer DEFAULT 0 NOT NULL,
    doc_std_name character varying(500) DEFAULT '' NOT NULL
);

CREATE TABLE tls207_pers_appln (
    person_id integer DEFAULT 0 NOT NULL,
    appln_id integer DEFAULT 0 NOT NULL,
    applt_seq_nr smallint DEFAULT 0 NOT NULL,
    invt_seq_nr smallint DEFAULT 0 NOT NULL
);

CREATE TABLE tls209_appln_ipc (
    appln_id integer DEFAULT 0 NOT NULL,
    ipc_class_symbol character varying(15) DEFAULT '' NOT NULL,
    ipc_class_level character(1) DEFAULT '' NOT NULL,
    ipc_version date DEFAULT '9999-12-31' NOT NULL,
    ipc_value character(1) DEFAULT '' NOT NULL,
    ipc_position character(1) DEFAULT '' NOT NULL,
    ipc_gener_auth character(2) DEFAULT '' NOT NULL
);

CREATE TABLE tls210_appln_n_cls (
    appln_id integer DEFAULT 0 NOT NULL,
    nat_class_symbol character varying(15) DEFAULT '' NOT NULL
);

CREATE TABLE tls211_pat_publn (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    publn_auth character(2) DEFAULT '' NOT NULL,
    publn_nr character varying(15) DEFAULT '' NOT NULL,
    publn_kind character(2) DEFAULT '' NOT NULL,
    appln_id integer,
    publn_date date DEFAULT '9999-12-31' NOT NULL,
    publn_lg character(2) DEFAULT '' NOT NULL,
    publn_first_grant smallint DEFAULT 0 NOT NULL,
    publn_claims integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls212_citation (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    citn_id smallint DEFAULT 0 NOT NULL,
    citn_origin character(3) DEFAULT '' NOT NULL,
    cited_pat_publn_id integer DEFAULT 0 NOT NULL,
    cited_appln_id integer DEFAULT 0 NOT NULL,
    pat_citn_seq_nr smallint DEFAULT 0::smallint NOT NULL,
    npl_publn_id integer DEFAULT 0 NOT NULL,
    npl_citn_seq_nr smallint DEFAULT 0 NOT NULL,
    citn_gener_auth character varying(2) DEFAULT '' NOT NULL
);

CREATE TABLE tls214_npl_publn (
    npl_publn_id integer DEFAULT 0 NOT NULL,
    npl_biblio text DEFAULT '' NOT NULL
);

CREATE TABLE tls215_citn_categ (
    pat_publn_id integer DEFAULT 0 NOT NULL,
    citn_id smallint DEFAULT 0 NOT NULL,
    citn_categ character(1) DEFAULT '' NOT NULL
);

CREATE TABLE tls216_appln_contn (
    appln_id integer DEFAULT 0 NOT NULL,
    parent_appln_id integer DEFAULT 0 NOT NULL,
    contn_type character(3) DEFAULT '' NOT NULL
);

CREATE TABLE tls222_appln_jp_class (
    appln_id integer DEFAULT 0 NOT NULL,
    jp_class_scheme character varying(5) DEFAULT '' NOT NULL,
    jp_class_symbol character varying(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls223_appln_docus (
    appln_id integer DEFAULT 0 NOT NULL,
    docus_class_symbol character varying(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls224_appln_cpc (
    appln_id integer DEFAULT 0 NOT NULL,
    cpc_class_symbol character varying(19) DEFAULT '' NOT NULL,
    cpc_scheme character varying(5) DEFAULT '' NOT NULL,
    cpc_version date DEFAULT '9999-12-31',
    cpc_value character(1) DEFAULT '' NOT NULL,
    cpc_position character(1) DEFAULT '' NOT NULL,
    cpc_gener_auth character varying(2) DEFAULT '' NOT NULL
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
    nace2_code character varying(5) DEFAULT '' NOT NULL,
    weight numeric DEFAULT 1 NOT NULL
);

CREATE TABLE tls230_appln_tech_field (
    appln_id integer DEFAULT 0 NOT NULL,
    tech_field_nr smallint DEFAULT 0 NOT NULL,
    weight numeric DEFAULT 1 NOT NULL
);

CREATE TABLE tls801_country (
    country_code character(2) DEFAULT '' NOT NULL,
    iso_alph3 character varying(3) DEFAULT '' NOT NULL,
    st3_name character varying(100) DEFAULT '' NOT NULL,
    state_indicator character varying(1) DEFAULT '' NOT NULL,
    continent character varying(25) DEFAULT '' NOT NULL,
    eu_member character varying(1) DEFAULT '' NOT NULL,
    epo_member character varying(1) DEFAULT '' NOT NULL,
    oecd_member character varying(1) DEFAULT '' NOT NULL,
    discontinued character varying(1) DEFAULT '' NOT NULL
);

CREATE TABLE tls901_techn_field_ipc (
    ipc_maingroup_symbol character varying(8) DEFAULT '' NOT NULL,
    techn_field_nr smallint DEFAULT 0 NOT NULL,
    techn_sector character varying(50) DEFAULT '' NOT NULL,
    techn_field character varying(50) DEFAULT '' NOT NULL
);

CREATE TABLE tls902_ipc_nace2 (
    ipc character varying(8) DEFAULT '' NOT NULL,
    not_with_ipc character varying(8) DEFAULT '' NOT NULL,
    unless_with_ipc character varying(8) DEFAULT '' NOT NULL,
    nace2_code character varying(5) DEFAULT '' NOT NULL,
    nace2_weight numeric DEFAULT 1 NOT NULL,
    nace2_descr character varying(150) DEFAULT '' NOT NULL
);

CREATE TABLE tls906_person (
    person_id integer DEFAULT 0 NOT NULL,
    person_name text DEFAULT '' NOT NULL,
    person_address text DEFAULT '' NOT NULL,
    person_ctry_code character varying(2) DEFAULT '' NOT NULL,
    doc_std_name_id integer DEFAULT 0 NOT NULL,
    doc_std_name character varying(500) DEFAULT '' NOT NULL,
    hrm_l2_id integer DEFAULT 0 NOT NULL,
    hrm_l1 character varying(400) DEFAULT '' NOT NULL,
    hrm_l2 character varying(400) DEFAULT '' NOT NULL,
    hrm_level smallint DEFAULT 0 NOT NULL,
    sector character varying(50) DEFAULT '' NOT NULL,
    han_id integer DEFAULT 0 NOT NULL,
    han_name character varying(500) DEFAULT '' NOT NULL,
    han_harmonized smallint DEFAULT 0 NOT NULL
);
