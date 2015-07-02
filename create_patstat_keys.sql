ALTER TABLE tls201_appln ADD PRIMARY KEY (appln_id);

ALTER TABLE tls202_appln_title ADD PRIMARY KEY (appln_id);

ALTER TABLE tls203_appln_abstr ADD PRIMARY KEY (appln_id);

ALTER TABLE tls204_appln_prior ADD PRIMARY KEY (appln_id, prior_appln_id);

ALTER TABLE tls205_tech_rel ADD PRIMARY KEY (appln_id, tech_rel_appln_id);

ALTER TABLE tls209_appln_ipc ADD PRIMARY KEY (appln_id, ipc_class_symbol, ipc_class_level);

ALTER TABLE tls210_appln_n_cls ADD PRIMARY KEY (appln_id, nat_class_symbol);

ALTER TABLE tls211_pat_publn ADD PRIMARY KEY (pat_publn_id);

ALTER TABLE tls212_citation ADD PRIMARY KEY (pat_publn_id, citn_id);

ALTER TABLE tls214_npl_publn ADD PRIMARY KEY (npl_publn_id);

ALTER TABLE tls215_citn_categ ADD PRIMARY KEY (pat_publn_id, citn_id, citn_categ);

ALTER TABLE tls216_appln_contn ADD PRIMARY KEY (appln_id, parent_appln_id);

ALTER TABLE tls218_docdb_fam ADD PRIMARY KEY (appln_id);

ALTER TABLE tls219_inpadoc_fam ADD PRIMARY KEY (appln_id);

ALTER TABLE tls222_appln_jp_class ADD PRIMARY KEY (appln_id, jp_class_scheme, jp_class_symbol);

ALTER TABLE tls223_appln_docus ADD PRIMARY KEY (appln_id, docus_class_symbol);

ALTER TABLE tls227_pers_publn ADD PRIMARY KEY (person_id, pat_publn_id, applt_seq_nr, invt_seq_nr);

ALTER TABLE tls801_country ADD PRIMARY KEY (country_code);

ALTER TABLE tls901_techn_field_ipc ADD PRIMARY KEY (techn_field_nr, ipc_maingroup_symbol);

ALTER TABLE tls906_person ADD PRIMARY KEY (person_id);

CREATE INDEX ON tls201_appln (appln_auth, appln_nr, appln_kind);

CREATE INDEX ON tls201_appln (appln_filing_date);

CREATE INDEX ON tls211_pat_publn (appln_id);

CREATE INDEX ON tls212_citation (cited_pat_publn_id);

CREATE INDEX ON tls201_appln (internat_appln_id);

CREATE INDEX ON tls906_person (person_ctry_code);

CREATE INDEX ON tls211_pat_publn (publn_auth, publn_nr, publn_kind);

CREATE INDEX ON tls211_pat_publn (publn_date);

ALTER TABLE tls202_appln_title ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls203_appln_abstr ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls204_appln_prior ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls204_appln_prior ADD FOREIGN KEY (prior_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls205_tech_rel ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls205_tech_rel ADD FOREIGN KEY (tech_rel_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls207_pers_appln ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls209_appln_ipc ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls210_appln_n_cls ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls211_pat_publn ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls212_citation ADD FOREIGN KEY (cited_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls212_citation ADD FOREIGN KEY (cited_pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);

ALTER TABLE tls212_citation ADD FOREIGN KEY (pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);

ALTER TABLE tls215_citn_categ ADD FOREIGN KEY (pat_publn_id, citn_id) REFERENCES tls212_citation(pat_publn_id, citn_id);

ALTER TABLE tls216_appln_contn ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls216_appln_contn ADD FOREIGN KEY (parent_appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls218_docdb_fam ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls219_inpadoc_fam ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls222_appln_jp_class ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls223_appln_docus ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls224_appln_cpc ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls227_pers_publn ADD FOREIGN KEY (pat_publn_id) REFERENCES tls211_pat_publn(pat_publn_id);
