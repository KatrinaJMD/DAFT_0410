use lab_mysql;

-- update SALESPERSONS table
# check the error
select *
from salespersons
where store like '%Mi%';

# correct mistakes
update salespersons
set store = 'Miami'
where staff_id = 5;

# verify results
select *
from salespersons;

-- update CUSTOMERS table
# missing emails
update customers
set email = (case id when 1 then 'ppicasso@gmail.com'
					 when 2 then 'lincoln@us.gov'
					 when 3 then 'hello@napoleon.me'
                     end)
where id in (1, 2, 3);    

# # verify results
select *
from customers;