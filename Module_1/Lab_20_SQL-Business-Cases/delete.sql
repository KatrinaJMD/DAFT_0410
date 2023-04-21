use lab_mysql;

-- delete DUPLICATES
# check error
select vin, manufacturer, year, color, count(*) as duplicates
from cars
group by vin, manufacturer, year, color;

# delete ID no.5
delete from cars
where id = 5;

# verify results
select * from cars;