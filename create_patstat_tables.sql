CREATE TABLE tls201_appln (
    appln_id integer NOT NULL,
    appln_auth character(2),
    appln_nr character varying(15),
    appln_kind character(2),
    appln_filing_date date,
    appln_nr_epodoc character varying(20),
    ipr_type character(2),
    appln_title_lg character(2),
    appln_abstract_lg character(2),
    internat_appln_id integer
);

CREATE TABLE tls202_appln_title (
    appln_id integer NOT NULL,
    appln_title text
);

CREATE TABLE tls203_appln_abstr (
    appln_id integer NOT NULL,
    appln_abstract text
);

CREATE TABLE tls204_appln_prior (
    appln_id integer NOT NULL,
    prior_appln_id integer NOT NULL,
    prior_appln_seq_nr smallint
);

CREATE TABLE tls205_tech_rel (
    appln_id integer NOT NULL,
    tech_rel_appln_id integer NOT NULL
);

CREATE TABLE tls206_person (
    person_id integer,
    person_name text,
    person_address text DEFAULT ''::text NOT NULL,
    person_ctry_code character varying(2) DEFAULT ''::character varying NOT NULL,
    doc_std_name_id integer DEFAULT 0 NOT NULL,
    doc_std_name character varying(500) DEFAULT ''::character varying NOT NULL,
    hrm_l2_id integer,
    hrm_l1 character varying(400),
    hrm_l2 character varying(400),
    hrm_level smallint,
    sector character varying(50),
    han_id integer,
    han_name character varying(500),
    han_harmonized smallint
);

CREATE TABLE tls207_pers_appln (
    person_id integer,
    appln_id integer,
    applt_seq_nr smallint DEFAULT 0::smallint NOT NULL,
    invt_seq_nr smallint DEFAULT 0::smallint NOT NULL
);

CREATE TABLE tls209_appln_ipc (
    appln_id integer NOT NULL,
    ipc_class_symbol character varying(15) NOT NULL,
    ipc_class_level character(1) NOT NULL,
    ipc_version date,
    ipc_value character(1),
    ipc_position character(1),
    ipc_gener_auth character(2)
);

CREATE TABLE tls210_appln_n_cls (
    appln_id integer NOT NULL,
    nat_class_symbol character varying(15) NOT NULL
);

CREATE TABLE tls211_pat_publn (
    pat_publn_id integer NOT NULL,
    publn_auth character(2),
    publn_nr character varying(15),
    publn_kind character(2),
    appln_id integer,
    publn_date date DEFAULT '9999-12-31'::date,
    publn_lg character(2),
    publn_first_grant smallint,
    publn_claims integer DEFAULT 0
);

CREATE TABLE tls212_citation (
    pat_publn_id integer NOT NULL,
    citn_id smallint NOT NULL,
    citn_origin character(3),
    cited_pat_publn_id integer DEFAULT 0 NOT NULL,
    cited_appln_id integer DEFAULT 0 NOT NULL,
    pat_citn_seq_nr smallint DEFAULT 0::smallint NOT NULL,
    npl_publn_id integer DEFAULT 0 NOT NULL,
    npl_citn_seq_nr smallint DEFAULT 0::smallint NOT NULL,
    citn_gener_auth character varying(2)
);

CREATE TABLE tls214_npl_publn (
    npl_publn_id integer DEFAULT 0 NOT NULL,
    npl_biblio text
);

CREATE TABLE tls215_citn_categ (
    pat_publn_id integer NOT NULL,
    citn_id smallint NOT NULL,
    citn_categ character(1) NOT NULL
);

CREATE TABLE tls216_appln_contn (
    appln_id integer NOT NULL,
    parent_appln_id integer NOT NULL,
    contn_type character(3)
);

CREATE TABLE tls218_docdb_fam (
    appln_id integer NOT NULL,
    docdb_family_id integer DEFAULT 0 NOT NULL
);

CREATE TABLE tls219_inpadoc_fam (
    appln_id integer NOT NULL,
    inpadoc_family_id integer
);

CREATE TABLE tls222_appln_jp_class (
    appln_id integer NOT NULL,
    jp_class_scheme character varying(5) NOT NULL,
    jp_class_symbol character varying(50) NOT NULL
);

CREATE TABLE tls223_appln_docus (
    appln_id integer NOT NULL,
    docus_class_symbol character varying(50) NOT NULL
);

CREATE TABLE tls224_appln_cpc (
    appln_id integer,
    cpc_class_symbol character varying(19),
    cpc_scheme character varying(5),
    cpc_version date,
    cpc_value character(1) DEFAULT ' '::bpchar NOT NULL,
    cpc_position character(1) DEFAULT ' '::bpchar NOT NULL,
    cpc_gener_auth character varying(2)
);

CREATE TABLE tls227_pers_publn (
    person_id integer NOT NULL,
    pat_publn_id integer NOT NULL,
    applt_seq_nr integer NOT NULL,
    invt_seq_nr integer NOT NULL
);

CREATE TABLE tls228_docdb_fam_citn (
    docdb_family_id integer,
    cited_docdb_family_id integer
);

CREATE TABLE tls229_appln_nace2 (
    appln_id integer,
    nace2_code character varying(5),
    weight numeric
);

CREATE TABLE tls801_country (
    country_code character(2) NOT NULL,
    iso_alph3 character varying(3),
    st3_name character varying(100),
    state_indicator character varying(1),
    continent character varying(25),
    eu_member character varying(1),
    epo_member character varying(1),
    oecd_member character varying(1),
    discontinued character varying(1)
);

CREATE TABLE tls901_techn_field_ipc (
    ipc_maingroup_symbol character varying(8) NOT NULL,
    techn_field_nr smallint NOT NULL,
    techn_sector character varying(50),
    techn_field character varying(50)
);

CREATE TABLE tls902_ipc_nace2 (
    ipc character varying(8),
    not_with_ipc character varying(8),
    unless_with_ipc character varying(8),
    nace2_code character varying(5),
    nace2_weight numeric,
    nace2_descr character varying(150)
);

CREATE TABLE tls906_person (
    person_id integer NOT NULL,
    person_name text,
    person_address text DEFAULT ''::text NOT NULL,
    person_ctry_code character varying(2) DEFAULT ''::character varying NOT NULL,
    doc_std_name_id integer DEFAULT 0 NOT NULL,
    doc_std_name character varying(500) DEFAULT ''::character varying NOT NULL,
    hrm_l2_id integer,
    hrm_l1 character varying(400),
    hrm_l2 character varying(400),
    hrm_level smallint,
    sector character varying(50),
    han_id integer,
    han_name character varying(500),
    han_harmonized smallint
);

