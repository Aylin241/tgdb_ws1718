1.)	/*suche den größten ID-Wert, und den Namen mit der Anfangsbuchstabe P, gebe es aus
	falls dieser Benutzer nicht gefunden wird, gebe Fehler aus ansonsten gebe unerwarteter... 
	Raise= stoppe die Funktion*/


DECLARE
  v_account_id account.account_id%TYPE;

BEGIN
  SELECT MAX(a.account_id) INTO v_account_id, forename, surname
  FROM account a
  WHERE a.surname LIKE 'P%';

  DBMS_OUTPUT.PUT_LINE('Der neuste Benutzer mit dem Anfangsbuchstaben P im Nachnamen hat die ID ' || v_account_id);
  DBMS_OUTPUT.PUT_LINE('Vorname:' || forename);
  BMS_OUTPUT.PUT_LINE('Nachname:' || surname);
EXCEPTION
  WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde kein Benutzer gefunden');
  WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
/


2.) /*
	*/
	
DECLARE
  v_account_id account.account_id%TYPE;

BEGIN
  SELECT MAX(a.account_id) INTO v_account_id, forename, surname
  FROM account a
  WHERE a.surname LIKE 'P%';

  DBMS_OUTPUT.PUT_LINE('Der neuste Benutzer mit dem Anfangsbuchstaben P im Nachnamen hat die ID ' || v_account_id);
  DBMS_OUTPUT.PUT_LINE('Vorname:' || forename);
  BMS_OUTPUT.PUT_LINE('Nachname:' || surname);
EXCEPTION
  WHEN NO_DATA_FOUND
    THEN RAISE_APPLICATION_ERROR(-20001, 'Es wurde kein Benutzer gefunden');
  WHEN OTHERS
    THEN DBMS_OUTPUT.PUT_LINE ('Folgender unerwarteter Fehler ist aufgetreten: ');
  RAISE;
END;
/


3.) /*gebe alle Tankstellen aus, durchlaufe die Tankstellen, gebe deren name straße usw.
		aus, die auch in Deutschland einen Sitz haben bis alle Tankstellen durch sind
	*/

DECLARE
BEGIN
  DBMS_OUTPUT.PUT_LINE('Liste alle Tankstellen aus Deutschland');
  DBMS_OUTPUT.PUT_LINE('____________________________________________');
  FOR rec_gs IN (  SELECT p.provider_name, gs.street, a.plz, a.city, c.country_name
                    FROM gas_station gs
                      INNER JOIN address a ON (a.address_id = gs.address_id)
                      INNER JOIN provider p ON (gs.provider_id = p.provider_id)
                      INNER JOIN country c ON (gs.country_id = c.country_id)
                    WHERE c.country_name LIKE 'Deutschland') LOOP
    DBMS_OUTPUT.PUT_LINE('++ ' || rec_gs.provider_name || ' ++ ' || rec_gs.street || ' ++ ' || rec_gs.plz || ' ++ ' || rec_gs.city || ' ++ ' || rec_gs.country_name);
  END LOOP;
END;
/



-- für jede Tankstelle alle Kunden die dort einmal tanken, waren ausgegeben



4.) /*alle deine Fahrzeuge auflistet und die dazugehörigen Belege inkl. Betrag, der ausgegeben 
	wurde für jeden Tankvorgang
	*/


















