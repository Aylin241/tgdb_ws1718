1.)
select column_name, constraint_name 
from user_cons_columns 
where constraint_name = (SELECT CONSTRAINT_NAME 
						FROM user_constraints 
						where table_name='VEHICLE' and constraint_type = 'P');
						


4.)
alter table gas
add constraint c_gas check
(GAS_NAME = initcap(GAS_NAME));
 
 
 
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 