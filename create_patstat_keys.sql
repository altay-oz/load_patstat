-- defining primary keys
ALTER TABLE tls201_appln ADD PRIMARY KEY (appln_id);

ALTER TABLE tls202_appln_title ADD PRIMARY KEY (appln_id);

ALTER TABLE tls203_appln_abstr ADD PRIMARY KEY (appln_id);

ALTER TABLE tls204_appln_prior ADD PRIMARY KEY (appln_id, prior_appln_id);

ALTER TABLE tls205_tech_rel ADD PRIMARY KEY (appln_id, tech_rel_appln_id);

ALTER TABLE tls206_person ADD PRIMARY KEY (person_id);

ALTER TABLE tls207_pers_appln ADD PRIMARY KEY (person_id, appln_id, applt_seq_nr, invt_seq_nr);

ALTER TABLE tls209_appln_ipc ADD PRIMARY KEY (appln_id, ipc_class_symbol);

ALTER TABLE tls210_appln_n_cls ADD PRIMARY KEY (appln_id, nat_class_symbol);

ALTER TABLE tls211_pat_publn ADD PRIMARY KEY (pat_publn_id);

ALTER TABLE tls212_citation ADD PRIMARY KEY (pat_publn_id, citn_replenished, citn_id);

ALTER TABLE tls214_npl_publn ADD PRIMARY KEY (npl_publn_id);

ALTER TABLE tls215_citn_categ ADD PRIMARY KEY (pat_publn_id, citn_replenished, citn_id, citn_categ, relevant_claim);

ALTER TABLE tls216_appln_contn ADD PRIMARY KEY (appln_id, parent_appln_id);

ALTER TABLE tls222_appln_jp_class ADD PRIMARY KEY (appln_id, jp_class_scheme, jp_class_symbol);

ALTER TABLE tls223_appln_docus ADD PRIMARY KEY (appln_id, docus_class_symbol);

ALTER TABLE tls224_appln_cpc ADD PRIMARY KEY (appln_id, cpc_class_symbol);

ALTER TABLE tls225_docdb_fam_cpc ADD PRIMARY KEY (docdb_family_id, cpc_gener_auth);

ALTER TABLE tls226_person_orig ADD PRIMARY KEY (person_orig_id);

ALTER TABLE tls227_pers_publn ADD PRIMARY KEY (person_id, pat_publn_id, applt_seq_nr, invt_seq_nr);

ALTER TABLE tls228_docdb_fam_citn ADD PRIMARY KEY (docdb_family_id, cited_docdb_family_id);

ALTER TABLE tls229_appln_nace2 ADD PRIMARY KEY (appln_id, nace2_code);

ALTER TABLE tls230_appln_techn_field ADD PRIMARY KEY (appln_id, techn_field_nr);

ALTER TABLE tls231_inpadoc_legal_event ADD PRIMARY KEY (event_id);

ALTER TABLE tls801_country ADD PRIMARY KEY (ctry_code);

ALTER TABLE tls803_legal_event_code ADD PRIMARY KEY (event_auth, event_code);

ALTER TABLE tls901_techn_field_ipc ADD PRIMARY KEY (ipc_maingroup_symbol);

ALTER TABLE tls902_ipc_nace2 ADD PRIMARY KEY (ipc, not_with_ipc, unless_with_ipc, nace2_code);

ALTER TABLE tls904_nuts ADD PRIMARY KEY (nuts);

------------------------------------------------
-- defining alternate keys
CREATE INDEX ON tls201_appln (appln_auth, appln_nr, appln_kind, receiving_office);

CREATE INDEX ON tls206_person (person_name, person_name_orig_lg, person_address, person_ctry_code);

CREATE INDEX ON tls211_pat_publn (publn_auth, publn_nr, publn_kind, publn_date);

CREATE INDEX ON tls231_inpadoc_legal_event (appln_id, event_seq_nr);

------------------------------------------------
-- defining foreign keys
ALTER TABLE tls202_appln_title ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls203_appln_abstr ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls204_appln_prior ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);
ALTER TABLE tls204_appln_prior ADD FOREIGN KEY (prior_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls205_tech_rel ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls205_tech_rel ADD FOREIGN KEY (tech_rel_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls207_pers_appln ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls207_pers_appln ADD FOREIGN KEY (person_id) REFERENCES tls206_person(person_id);

ALTER TABLE tls209_appln_ipc ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls210_appln_n_cls ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls211_pat_publn ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls212_citation ADD FOREIGN KEY (cited_appln_id) REFERENCES tls201_appln(appln_id);
ALTER TABLE tls212_citation ADD FOREIGN KEY (cited_pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);
ALTER TABLE tls212_citation ADD FOREIGN KEY (pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);
ALTER TABLE tls212_citation ADD FOREIGN KEY (cited_npl_publn_id) REFERENCES tls214_npl_publn(npl_publn_id);

ALTER TABLE tls215_citn_categ ADD FOREIGN KEY (pat_publn_id, citn_replenished, citn_id) REFERENCES tls212_citation(pat_publn_id, citn_replenished, citn_id);

ALTER TABLE tls216_appln_contn ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);
ALTER TABLE tls216_appln_contn ADD FOREIGN KEY (parent_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls222_appln_jp_class ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls223_appln_docus ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls224_appln_cpc ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

--ALTER TABLE tls225_docdb_fam_cpc ADD FOREIGN KEY (docdb_family_id) REFERENCES tls201_appln(doc_db_family_id);

ALTER TABLE tls227_pers_publn ADD FOREIGN KEY (person_id) REFERENCES tls206_person(person_id);
ALTER TABLE tls227_pers_publn ADD FOREIGN KEY (pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);

--ALTER TABLE tls228_docdb_fam_citn ADD FOREIGN KEY (docdb_family_id) REFERENCES tls201_appln(doc_db_family_id);
--ALTER TABLE tls228_docdb_fam_citn ADD FOREIGN KEY (cited_docdb_family_id) REFERENCES tls201_appln(doc_db_family_id);

ALTER TABLE tls229_appln_nace2 ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);
--ALTER TABLE tls229_appln_nace2 ADD FOREIGN KEY (nace2_code) REFERENCES tls902_ipc_nace2(nace2_code);

ALTER TABLE tls230_appln_techn_field ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);
--ALTER TABLE tls230_appln_techn_field ADD FOREIGN KEY (techn_field_nr) REFERENCES tls901_techn_field_ipc(techn_field_nr);

--ALTER TABLE tls231_inpadoc_legal_event ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);
--ALTER TABLE tls231_inpadoc_legal_event ADD FOREIGN KEY (event_auth, event_code) REFERENCES tls803_legal_event_code(event_auth, event_code);

--ALTER TABLE tls901_techn_field_ipc ADD FOREIGN KEY (techn_field_nr) REFERENCES tls209_appln_ipc(techn_field_nr);
