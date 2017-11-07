1.)

create table residence ( 
res_id number(5) not null,
street varchar(40) not null,
plz number(5) not null,
city varchar(32) not null);

create table res_acc (
account_id number(38) not null,
first_res_id number(38) not null,
second_res_id number(38));	 
		 
		 
		 
		 
2.)		 

alter table gas_station
add (x_coord number(10,5),
     y_coord number(10,5));

3.)




4.1)
SELECT *
 FROM all_tab_privs
 WHERE table_schema = 'SCOTT';	

4.2)
SELECT * 
 FROM user_role_privs; 
 
4.3)
SELECT granted_role, role
FROM role_role_privs 
WHERE role in(
	select granted_role
	from user_role_privs);
 

4.4)

 
 
 
 
5.)

SELECT to_char(r.receipt_date, 'yyyy') "Jahr",
	   p.provider_name "Anbieter",
	   gs.street "Straße",
	   a.plz "PLZ",
	   a.city "Stadt",
	   a.country_name "Land",
	   SUM(r.price_l * r.liter * (1 + r.duty_amount)) "Umsatz"
FROM receipt r
	inner join gas_station gs on (r.gas_station_id = gs.gas_station_id)
	inner join provider p on (p.provider_id = gs.provider_id)
	inner join country c on (c.country_id = gs.country_id)
	inner join address a on (a.address_id = gs.address_id)
GROUP BY r.receipt_date,
	   p.provider_name,
	   gs.street,
	   a.plz,
	   a.city, 
	   a.country_name
ORDER BY "Jahr", "Anbieter", "Straße", "PLZ", "Stadt", "Land";
 
 
 
 
 
 
 
 
 
 
 
 
 
 
