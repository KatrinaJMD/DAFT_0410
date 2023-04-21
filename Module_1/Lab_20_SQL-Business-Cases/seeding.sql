use lab_mysql;

insert into cars (vin, manufacturer, model, year, color)
values
	('3K096I98581DHSNUP', 'Volkswagen', 'Tiguan', 2019, 'Blue'),
    ('ZM8G7BEUQZ97IH46V', 'Peugeot', 'Rifter', 2019, 'Red'),
    ('RKXVNNIHLVVZOUB4M', 'Ford', 'Fusion', 2018, 'White'),
    ('HKNDGS7CU31E9Z7JW', 'Toyota', 'RAV4', 2018, 'Silver'),
    ('DAM41UDN3CHU2WVF6', 'Volvo', 'V60', 2019 ,'Gray'),
    ('DAM41UDN3CHU2WVF6', 'Volvo', 'V60 Cross Country', 2019, 'Gray');
    
insert into customers (customer_id, first_name, last_name, phone, address, city, state_province, country, zipcode)
values
	(10001, 'Pablo', 'Picasso', '+34 636 17 63 82', 'Paseo de la Chopera, 14', 'Madrid', 'Madrid', 'Spain', 28045),
    (20001, 'Abraham', 'Lincoln', '+1 305 907 7086', '120 SW 8th St', 'Miami', 'Florida', 'United States', 33130),
    (30001, 'Napoléon', 'Bonaparte', '+33 1 79 75 40 00 40', 'Rue du Colisée', 'Paris', 'Île-de-France', 'France', 75008);
    
insert into salespersons (first_name, last_name, store)
values
	('Petey', 'Cruiser', 'Madrid'),
    ('Anna', 'Sthesia', 'Barcelona'),
    ('Paul', 'Molive', 'Berlin'),
    ('Gail', ' Forcewind', 'Paris'),
    ('Paige', ' Turner', 'Mimia'),
    ('Bob', ' Frapples', 'Mexico City'),
    ('Walter', ' Melon', 'Amsterdam'),
    ('Shonda', ' Leer', 'São Paulo');
    
insert into invoices (invoice_no, date, car, customer, salesperson)
values
	(852399038, '2018-08-22', 1, 2, 4),
    (731166526, '2018-12-31', 4, 1, 6),
    (271135104, '2019-01-22', 3, 3, 8);