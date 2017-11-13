1.)
	
	SELECT ucc.constraint_name, ucc.column_name, ucc.position
	FROM user_cons_columns ucc
	WHERE ucc.constraint_name IN (
									SELECT uc.constraint_name
									FROM user_constraints uc
									WHERE uc.table_name LIKE 'VEHICLE'
									AND uc.constraint_type = 'P'
	);
	
	
	SELECT ucc.constraint_name, ucc.column_name, ucc.position
	FROM user_cons_columns ucc
	INNER JOIN user_constraints uc ON (ucc.constraint_name = uc.constraint_name)
	WHERE uc.table_name LIKE 'VEHICLE'
	AND uc.constraint_type = 'P';
	
2.)

	SELECT ucc.constraint_name, ucc.column_name, ucc.table_name
	FROM user_cons_columns ucc
	WHERE ucc.constraint_name IN (
				SELECT uc.r_constraint_name
				FROM user_constraints uc
				WHERE uc.table_name LIKE 'ACC_VEHIC'
				AND uc.constraint_type = 'R'
	);


3.)
	ALTER TABLE ACCOUNT ADD CONSTRAINT c_date
	CHECK (U_DATE >= C_DATE);
	
	
	überprüfung
	
	UPDATE account
	SET u_date = TO_DATE('2014-11-13', 'YYYY-MM-DD')
	WHERE account_id = 1;

		
	löschen
	
	alter table account
	drop constraint c_date;
		
		
4.)
	
	ALTER TABLE gas
	ADD CONSTRAINT gas_co
	CHECK (REGEXP_LIKE(gas_name, '^[A-Z].*$', 'c'));

5.)
	alter table acc_vehic
 	add constraint c_kennz
 	check (regexp_like(identicator, '^[A-Z]{1,3}:([A-Z]{1,2}:[1-9][0-9]{0,3}|[1-9][0-9]{0,5})$', 'c'));
 
 	-- Tests durch Falscheingabe
 	UPDATE acc_vehic
 	SET identicator = '8:ß:I'
 	WHERE vehicle_id = 1;
 
 	UPDATE acc_vehic
 	SET identicator = 'ZF:53:833'
 	WHERE vehicle_id = 1;
 
 	UPDATE acc_vehic
 	SET identicator = '10:MP:783'
 	WHERE vehicle_id = 1;
 
 	UPDATE acc_vehic
 	SET identicator = '10: :783'
 	WHERE vehicle_id = 1;
 
 	-- Update funktioniert
 	UPDATE acc_vehic
 	SET identicator = 'TR:WS:52'
 	WHERE vehicle_id = 1;
 
6.)
 
 
	SELECT  a.surname, a.forename,
         (
           SELECT SUM(r.price_l*r.liter*1+r.duty_amount)
           FROM receipt r
           WHERE account_id = a.account_id
           GROUP BY r.account_id
         ) "Ausgaben2",
         (
           SELECT SUM(r.liter)
           FROM receipt r
           WHERE account_id = a.account_id
         ) "Getankte Liter"
	FROM account a;
 
7.)

	SELECT  TO_CHAR(r.c_date, 'YYYY') "Jahr",
        	 p.provider_name "Provider",
         	gs.street "Straße",
         	a.plz "PLZ",
         	a.city "Stadt",
         	COUNT(r.account_id) "Anzahl"
 	FROM  gas_station gs
   		INNER JOIN provider p ON (p.provider_id = gs.provider_id)
   		INNER JOIN address a ON (a.address_id = gs.address_id)
   		INNER JOIN receipt r ON (r.gas_station_id = gs.gas_station_id)
 	GROUP BY r.c_date, p.provider_name, gs.street, a.plz, a.city;
 
8.)

	CREATE TABLE LBOOK (
   	LBOOK_ID      NUMBER(38) NOT NULL,  -- PK
   	ACCOUNT_ID    NUMBER(38) NOT NULL,  -- FK
   	ACC_VEHIC_ID  NUMBER(38) NOT NULL,  -- FK
   	B_DATE        DATE NOT NULL,
   	KILOMETER     NUMBER(7,3) NOT NULL,
   	S_DATE        DATE NOT NULL
 	);
 
 ALTER TABLE LBOOK
 ADD CONSTRAINT LBOOK_PK
 PRIMARY KEY (LBOOK_ID);
 
 ALTER TABLE LBOOK
 ADD CONSTRAINT buxdehude_fk
 FOREIGN KEY (ACCOUNT_ID) REFERENCES ACCOUNT(ACCOUNT_ID);
 
 ALTER TABLE LBOOK
 ADD CONSTRAINT trier_fk
 FOREIGN KEY (ACC_VEHIC_ID) REFERENCES ACC_VEHIC(ACC_VEHIC_ID);
 
 ALTER TABLE LBOOK
 ADD CONSTRAINT check_date
 CHECK (S_DATE >= B_DATE);
  

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
