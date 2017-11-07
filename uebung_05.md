
Aufgabe1.)

+Inner join: Liefert Ergebnisse aus beiden Tabellen, deren Werte in beide Tabellen vorliegen.
+Left join : Liefert die Schnittmenge aus zwei Tabellen inkl. der Menge A(left)
+Right join : Liefert die Schnittmenge aus zwei Tabellen inkl. der Menge B(right)
+Outer join : Liefert die Mengen A (left) und A(right)



Aufgabe2.)

select surname, forename
 from account a
 left join acc_vehic ac
 on (a.account_id = ac.account_id)
 where vehicle_id is null;
 
 
 select surname, forename, vehicle_id
 from acc_vehic ac
 right join account a
 on (ac.account_id = a.account_id)
 where vehicle_id is null;
 
 
 
 
