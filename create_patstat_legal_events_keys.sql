ALTER TABLE tls221_inpadoc_prs ADD PRIMARY KEY (appln_id, prs_event_seq_nr);

ALTER TABLE tls802_legal_event_code ADD PRIMARY KEY (lec_id);

ALTER TABLE tls221_inpadoc_prs ADD FOREIGN KEY (appln_id) REFERENCES tls201_appln(appln_id);

ALTER TABLE tls221_inpadoc_prs ADD FOREIGN KEY (lec_id) REFERENCES tls802_legal_event_code(lec_id);
