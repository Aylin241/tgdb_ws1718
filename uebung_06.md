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
 
 
 6.)
select surname, buy_price, buy_kilometer
   from account
   inner join acc_vehic
   on account.account_id=acc_vehic.account_id;
   
7.)
select provider_name
    from provider
    join
	
	
	group by ...
	order by... desc
 

 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
