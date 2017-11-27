1.) /*
Prezedur, die das anlegen von Benutzern duch übergabe von Paramentern ermöglicht
*/
Create or replace PROCEDURE benutzer (surname IN VARCHAR2, forename IN VARCHAR2, email IN VARCHAR2, c_date IN DATE, u_date IN DATE) 
AS
v_id account.account_id%TYPE;
BEGIN
select max(account_id) +1 INTO v_id 
from account;

Insert into account
values(v_id, surname, forename, email, c_date, u_date);

DBMS_OUTPUT.PUT_LINE('Account mit der ID : ' || v_id || 'angelegt');

EXCEPTION

WHEN OTHERS THEN
RAISE_APPLICATION_ERROR(-20030, 'Unbekannter Fehler' );

END;
/


EXEC benutzer ('Yildirim', 'Aylin', 'aylinblaxk', sysdate, sysdate);

2.) 
