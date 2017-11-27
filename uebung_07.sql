1.)	/*suche den größten ID-Wert, und den Namen mit der Anfangsbuchstabe P, gebe es aus
	falls dieser Benutzer nicht gefunden wird, gebe Fehler aus ansonsten gebe unerwarteter... 
	Raise= stoppe die Funktion*/


DECLARE
   v_account_id account.account_id%TYPE;
   v_surname account.surname%TYPE;
   v_forename account.forename%TYPE;
   v_anzahl acc_vehic.vehicle_id%TYPE;

BEGIN
  SELECT MAX(a.account_id), a.forename, a.surname, count(accv.vehicle_id)
  INTO v_account_id, v_forename, v_surname, v_anzahl
  FROM account a
  Inner Join acc_vehic accv ON (a.account_id=accv.account_id)
  WHERE a.surname LIKE 'P%'
  GROUP BY a.surname, a.forename;

  DBMS_OUTPUT.PUT_LINE('Der neuste Benutzer mit dem Anfangsbuchstaben P im Nachnamen hat die ID ' || v_account_id);
  DBMS_OUTPUT.PUT_LINE('Vorname:' || v_forename);
  BMS_OUTPUT.PUT_LINE('Nachname:' || v_surname);
  DBMS_OUTPUT.PUT_LINE(' Anzahl der Fahrzeuge: ' || v_anzahl);
  
EXCEPTION
  WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde kein Benutzer gefunden');
  WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
/


2.) 

DECLARE
   v_min_tankstellen_id gas_station.gas_station_id%TYPE;
   v_provider_name provider.provider_name%TYPE;
   v_plz address.plz%TYPE;
   v_city address.city%TYPE;
   v_country_name country.country_name%TYPE;
   v_schnitt_besuche NUMBER;
   v_anzahl_besuche NUMBER;
   v_bewertung VARCHAR2(100);
 
 BEGIN
 
 	BEGIN
 		select min(gas_station_id) into v_min_tankstellen_id
 		from gas_station;
 	EXCEPTION
 		WHEN NO_DATA_FOUND
                 THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde keine Tankstelle gefunden');
 	END;
 
 	BEGIN
 		select p.provider_name, a.plz, a.city, c.country_name
 		into v_provider_name, v_plz, v_city, v_country_name
 		from gas_station gs
 		inner join provider p on gs.provider_id = p.provider_id
 		inner join address a on gs.address_id = a.address_id
 		inner join country c on gs.country_id = c.country_id
 		where gs.gas_station_id = v_min_tankstellen_id;
 	EXCEPTION
 		WHEN NO_DATA_FOUND
                 THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde keine Tankstelle gefunden');
 	END;
 
 	BEGIN
 		select avg(count(gas_station_id))
 		into v_schnitt_besuche
 		from receipt
 		where gas_station_id != v_min_tankstellen_id
 		group by gas_station_id;
 	END;
 
 	BEGIN
 		select count(gas_station_id)
 		into v_anzahl_besuche
 		from receipt
 		where gas_station_id = 1;
 	EXCEPTION
 		WHEN NO_DATA_FOUND
                 THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde keine Tankstelle gefunden');
 	END;
 
 	IF v_anzahl_besuche > v_schnitt_besuche THEN
 		v_bewertung := 'Gute Tankstelle!';
 	ELSE
 		v_bewertung := 'Schlechte Tankstelle!';
 	END IF;
 
 	
   
   DBMS_OUTPUT.PUT_LINE('TankstellenID ' || v_min_tankstellen_id);
   DBMS_OUTPUT.PUT_LINE('Name: ' || v_provider_name);
   DBMS_OUTPUT.PUT_LINE('PLZ: ' || v_plz);
   DBMS_OUTPUT.PUT_LINE('Stadt: ' || v_city);
   DBMS_OUTPUT.PUT_LINE('Land: ' || v_country_name);
   DBMS_OUTPUT.PUT_LINE('Bewertung: ' || v_bewertung);
   
 
 EXCEPTION
   WHEN OTHERS
     THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
   RAISE;
 END;
 /



3.) /*gebe alle Tankstellen aus, durchlaufe die Tankstellen, gebe deren name straße usw.
		aus, die auch in Deutschland einen Sitz haben bis alle Tankstellen durch sind
	*/

-- für jede Tankstelle alle Kunden die dort einmal tanken, waren ausgegeben

DECLARE
 BEGIN
   DBMS_OUTPUT.PUT_LINE('Liste alle Tankstellen aus Deutschland');
   DBMS_OUTPUT.PUT_LINE('____________________________________________');
   FOR rec_gs IN (  SELECT p.provider_name, gs.street, a.plz, a.city, c.country_name, gs.gas_station_id
                     FROM gas_station gs
                       INNER JOIN address a ON (a.address_id = gs.address_id)
                       INNER JOIN provider p ON (gs.provider_id = p.provider_id)
                       INNER JOIN country c ON (gs.country_id = c.country_id)
                     WHERE c.country_name LIKE 'Deutschland') LOOP
 				
     DBMS_OUTPUT.PUT_LINE('++ ' || rec_gs.provider_name || ' ++ ' || rec_gs.street || ' ++ ' || rec_gs.plz || ' ++ ' || rec_gs.city || ' ++ ' || rec_gs.country_name);
 
 	FOR cur_Kd IN (	SELECT acc.surname, acc.forename
 					FROM receipt r
 					INNER JOIN account acc ON r.account_id=acc.account_id
 					Where r.gas_station_id = rec_gs.gas_station_id
 					)LOOP
 		DBMS_OUTPUT.PUT_LINE(cur_Kd.surname||' ++ '||cur_Kd.forename);
 	END LOOP;
 	
   END LOOP;
 END;
/



4.) /*alle deine Fahrzeuge auflistet und die dazugehörigen Belege inkl. Betrag, der ausgegeben 
	wurde für jeden Tankvorgang
	*/


SELECT acc.forename, acc.account_id, ve.vehicle_id, re.receipt_id
 FROM receipt re
 INNER JOIN account acc ON re.account_id=acc.account_id
 INNER JOIN acc_vehic av ON acc.account_id=av.account_id
 INNER JOIN vehicle ve ON av.vehicle_id=ve.vehicle_id;
 
 DECLARE
 BEGIN
   FOR cur_vh IN (  SELECT pr.producer_name,ve.version, ve.vehicle_id
 					FROM vehicle ve
 					INNER JOIN acc_vehic av ON ve.vehicle_id = av.vehicle_id
 					INNER JOIN producer pr ON ve.producer_id = pr.producer_id
 					INNER JOIN account acc ON av.account_id = acc.account_id
 					WHERE acc.forename = 'Max'
 				) LOOP
 			
     DBMS_OUTPUT.PUT_LINE('Fahrzeug: ' || cur_vh.producer_name || ' Version: ' || cur_vh.version);
 
 	FOR cur_Beleg IN (	SELECT re.receipt_id
 						FROM receipt re
 						INNER JOIN vehicle ve ON ve.vehicle_id = cur_vh.vehicle_id
 					 )LOOP
 	
 	DBMS_OUTPUT.PUT_LINE('Beleg: ' || cur_Beleg.receipt_id);
 	
 		FOR cur_price IN (	SELECT re.liter, re.price_l
 							FROM receipt re
 							WHERE re.receipt_id = cur_Beleg.receipt_id
 						 )LOOP
 		
 		DBMS_OUTPUT.PUT_LINE('Rechnungsbetrag: ' || cur_price.liter*cur_price.price_l);
 		
 		END LOOP;
 	END LOOP;
 	
   END LOOP;
 END;
/













