-- all sqls are based on
-- Gaétan de Rassenfosse, Hélène Dernis, Geert Boedt (2014, 1 April version)
-- An introduction to the Patstat database with example queries,
-- These sqls are tested on postgresql 13.5 and PATSTAT 2019

-- Q1 creating the sample by IPC class and patent applications.
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind
INTO our_sample
FROM tls201_appln t1, tls209_appln_ipc t2
WHERE t1.appln_id = t2.appln_id
AND t1.appln_filing_year > 2000                  -- limiting to all application filled after 2000, not in the paper
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND t2.ipc_class_symbol LIKE 'H01L%'             -- enter the ipc_class (LED ipc class)
ORDER BY t1.appln_auth, t1.appln_id;

-- Q2 obtaining pct application 
SELECT
t1.appln_id AS PCT_appln_id,
t1.appln_auth AS PCT_appln_auth,
t1.appln_nr AS PCT_appln_nr,
t1.appln_kind,
t2.appln_id AS appln_id_sf,
t2.appln_auth AS appln_auth_sf
FROM our_sample t1, tls201_appln t2
WHERE t1.appln_id = t2.internat_appln_id
AND t1.appln_auth = 'DK'                    --- pct app receiving office
AND t2.appln_auth IN ('CN', 'JP')           --- pct app that are in national phase
ORDER BY t1.appln_id;

-- Q3 Counting unique inventions involves counting only priority filings.
-- The query below returns the priority status of the patent documents in our_sample.
SELECT DISTINCT t1.appln_id,
       (
       CASE WHEN t2.appln_id IS NULL
       	    THEN 1
       	    ELSE 0
      	    END
       ) AS is_a_pf
FROM our_sample t1
LEFT OUTER JOIN tls204_appln_prior t2
ON t1.appln_id = t2.appln_id
ORDER BY t1.appln_id;

-- Q4 counts the patent family size associated with the applications in
-- our_sample.
SELECT t1.appln_id, t2.doc_db_family_id, t2.docdb_family_size
FROM our_sample t1, tls201_appln t2
WHERE t1.appln_id = t2.appln_id
ORDER BY docdb_family_size DESC;

-- Q5 measure the geographic family size
SELECT t1.appln_id, t2.doc_db_family_id, t2.docdb_family_size,
COUNT(DISTINCT t3.publn_auth) AS geog_family_size
FROM our_sample t1, tls201_appln t2, tls211_pat_publn t3
WHERE t1.appln_id = t2.appln_id
AND t2.appln_id = t3.appln_id
AND t3.publn_auth != 'WO' -- exclude PCT patents because it has a world coverage.
GROUP BY t1.appln_id, t2.doc_db_family_id, t2.docdb_family_size
ORDER BY t1.appln_id;

-- triadic patent families, which captures patents granted by the US Patent
-- and Trademark Office (USPTO) and filed at the EPO and the Japan Patent
-- Office (JPO) to protect the same set of inventions (Dernis and Khan
-- 2004)
-- obtain only triadic patent families
SELECT t1.*, (
       	     CASE WHEN t2.appln_id IS NULL THEN 1
	     	  ELSE 0
	     	  END
	     ) AS is_triadic
FROM our_sample t1
LEFT OUTER JOIN tls211_pat_publn t2
ON t1.appln_id = t2.appln_id
AND t2.publn_auth != 'WO' -- exclude PCT patents because it has a world coverage.
AND t1.appln_auth IN ('EP', 'JP')           --- filed at
AND t2.publn_auth = 'US';


-- Q6 Counting patents by country (fractional counts)
SELECT person_ctry_code, SUM(tot_in_ctry/tot_in_patent) AS fractional_count
FROM (
     SELECT
     t.appln_id,
     nullif(t1.person_ctry_code, '') AS person_ctry_code,
     nullif(t1.tot_in_ctry, 1) AS tot_in_ctry,
     nullif(t2.tot_in_patent, 1) AS tot_in_patent
     FROM our_sample t
     LEFT OUTER JOIN (
     	  	     --> Accounts for missing inventor references in tls207_pers_appln table
     	 	      SELECT a.appln_id, b.person_ctry_code,
      		      	     COUNT(b.person_id) AS tot_in_ctry
    		      FROM tls207_pers_appln a
      		      INNER JOIN tls206_person b ON a.person_id = b.person_id
    		      WHERE a.invt_seq_nr > 0
    		      GROUP BY a.appln_id, person_ctry_code
    		      --> Compiles country-level count of inventors per patent
                      ) t1 ON t.appln_id = t1.appln_id
      		      LEFT OUTER JOIN (
		      	   SELECT appln_id, MAX(invt_seq_nr) AS tot_in_patent
    			   FROM tls207_pers_appln
    			   GROUP BY appln_id HAVING MAX(invt_seq_nr) > 0
    			   --> Compiles total count of inventors per patent
    			   ) t2 ON t.appln_id = t2.appln_id
     ) our_sample_with_country
GROUP BY person_ctry_code
ORDER BY SUM(tot_in_ctry/tot_in_patent) DESC;

-- Q7 Identifying patents resulting from international collaborations
SELECT t1.appln_id, COUNT(DISTINCT t3.person_ctry_code) AS nb_locations
FROM our_sample t1
INNER JOIN tls207_pers_appln t2 ON t1.appln_id = t2.appln_id
INNER JOIN tls206_person t3 ON t2.person_id = t3.person_id
WHERE t3.person_ctry_code IS NOT NULL
AND t2.invt_seq_nr > 0
GROUP BY t1.appln_id
ORDER BY nb_locations DESC, t1.appln_id ASC;

-- Q8 Counting citations received
SELECT t1.appln_id, COUNT(distinct t3.pat_publn_id) AS cites_3y
FROM our_sample t1
INNER JOIN (
      SELECT appln_id, earliest_publn_year
      FROM tls201_appln
      GROUP BY appln_id
      ) t2 ON t1.appln_id = t2.appln_id
INNER JOIN tls211_pat_publn t2b ON t2b.appln_id = t2.appln_id
INNER JOIN tls212_citation t3 ON t2b.pat_publn_id = t3.cited_pat_publn_id
INNER JOIN tls211_pat_publn t4 ON t3.pat_publn_id = t4.pat_publn_id
WHERE t2b.publn_auth = 'DE'
AND t4.publn_auth = 'EP'
AND t2.earliest_publn_year != 9999
AND date_part('year', t4.publn_date) != 9999
AND date_part('year', t4.publn_date) <= t2.earliest_publn_year + 3
GROUP BY t1.appln_id
ORDER BY cites_3y DESC, t1.appln_id ASC;

-- Q9 obtaining grant information
SELECT t1.appln_id, MAX(t2.publn_first_grant) AS granted
FROM our_sample t1
INNER JOIN tls211_pat_publn t2 ON t1.appln_id = t2.appln_id
WHERE t1.appln_auth = 'GB'
AND t1.appln_kind = 'A'
GROUP BY t1.appln_id
ORDER BY t1.appln_id;

--Q10 Linking Patstat with data provided by national patent offices
SELECT DISTINCT t1.appln_id, t2.publn_nr AS publn_nr_patstat,
CONCAT('GB',RIGHT(t2.publn_nr,7)) AS publn_nr_ukipo
FROM our_sample t1
INNER JOIN tls211_pat_publn t2 ON t1.appln_id = t2.appln_id
WHERE t1.appln_auth = 'GB'
AND t1.appln_kind = 'A'
AND t2.publn_kind != 'D0'
ORDER BY t1.appln_id;

-- The following queries are not in the de Rassenfosse et. al(2014)
-- Added by Özaygen.
-- Q101 creating the sample by keywords and patent applications.
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind
INTO our_sample
FROM tls201_appln t1, tls202_appln_title t2, tls203_appln_abstr t3
WHERE t1.appln_id = t2.appln_id
AND t1.appln_id = t3.appln_id
AND t1.appln_filing_year > 2000
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND t2.appln_title ILIKE '%method%'
AND t3.appln_abstract ILIKE '%method%'             
ORDER BY t1.appln_auth, t1.appln_id;

-- Q102 creating the sample by appln_nace2_code and patent applications.
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind
INTO our_sample
FROM tls201_appln t1, tls229_appln_nace2 t2, tls902_ipc_nace2 t3
WHERE t1.appln_id = t2.appln_id
AND t1.appln_filing_year > 2000
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND t2.nace2_code = t3.nace2_code
AND t3.nace2_descr ilike '%agriculture%'         -- nace2 field description with like
ORDER BY t1.appln_auth, t1.appln_id;

-- Q103 creating the sample by tech_field and patent applications.
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind
INTO our_sample
FROM tls201_appln t1, tls230_appln_techn_field t2, tls902_techn_field_ipc t3
WHERE t1.appln_id = t2.appln_id
AND t1.appln_filing_year > 2000
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND t2.tech_field_nr = t3.tech_field_nr
AND t3.techn_field ilike '%agriculture%'         -- technical field with like
ORDER BY t1.appln_auth, t1.appln_id;

-- Q104 creating the sample by firm_name
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind,
       		t2.applt_seq_nr, t2.invt_seq_nr, t3.psn_name
INTO our_sample
FROM tls201_appln t1, tls207_pers_appln t2, tls206_person t3
WHERE t1.appln_id = t2.appln_id
AND t2.person_id = t3.person_id
AND t1.appln_filing_year > 2000
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND (t2.applt_seq_nr > 0 OR t2.invt_seq_nr = 0)  -- only firms
AND t3.psn_name LIKE '%NOKIA%'                   -- firm name with like
ORDER BY t1.appln_auth, t1.appln_id;

-- Q105 creating the sample by firms' country
SELECT DISTINCT t1.appln_id, t1.appln_auth, t1.appln_nr, t1.appln_kind,
       		t2.applt_seq_nr, t2.invt_seq_nr, t3.psn_name
INTO our_sample
FROM tls201_appln t1, tls207_pers_appln t2, tls206_person t3
WHERE t1.appln_id = t2.appln_id
AND t2.person_id = t3.person_id
AND t1.appln_filing_year > 2000
AND (t1.appln_kind = 'A' OR t1.appln_kind = 'W') -- patent or PCT application
AND (t2.applt_seq_nr > 0 OR t2.invt_seq_nr = 0)  -- only firms
AND t3.person_ctry_code LIKE 'CN'                -- china
ORDER BY t1.appln_auth, t1.appln_id;

-- Q201 ipc distribution
SELECT COUNT(ipc_class_symbol), ipc_class_symbol
FROM our_sample t1, tls209_appln_ipc t2
WHERE t1.appln_id = t2.appln_id
GROUP BY ipc_class_symbol;

-- Q201 ipc main group distribution, 4 digit
SELECT count(appln_id) as appln_id_count, ipc_4
FROM (
     SELECT DISTINCT t1.appln_id, substring(t2.ipc_class_symbol, 0, 4) as ipc_4
     FROM our_sample t1, tls209_appln_ipc t2
     WHERE t1.appln_id = t2.appln_id
     ) grouped_ipc
GROUP BY ipc_4
ORDER BY appln_id_count DESC;

--Q301 network of citation based on USPTO published patents
SELECT t4.pat_publn_id as from_pat_publn_id, t4.cited_pat_publn_id as to_pat_publn_id
INTO patent_citation_network
FROM  our_sample t1, tls201_appln t2, tls211_pat_publn t3, tls212_citation t4
WHERE t1.appln_id = t2.appln_id
AND t1.appln_auth = 'US'
AND t2.earliest_filing_year > 2000
AND t1.appln_id = t3.appln_id
AND t3.publn_auth = 'US'
AND t3.pat_publn_id = t4.pat_publn_id;

--Q302 network of citation based on USPTO published patents with firm names
SELECT t3.psn_name as from_firm, t5.psn_name as to_firm
INTO firm_citations_network
FROM patent_citation_network t1,
     tls227_pers_publn t2, tls206_person t3,
     tls227_pers_publn t4, tls206_person t5
WHERE t1.from_pat_publn_id = t2.pat_publn_id
AND t2.person_id = t3.person_id
AND (t2.applt_seq_nr > 0 OR t2.invt_seq_nr = 0)  -- only firms
AND t1.to_pat_publn_id = t4.pat_publn_id
AND t4.person_id = t5.person_id
AND (t4.applt_seq_nr > 0 OR t4.invt_seq_nr = 0);  -- only firms
