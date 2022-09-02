drop schema vk cascade;

CREATE SCHEMA vk AUTHORIZATION thppgvct;

-- Creation DDL (Tables and Constraints)

create table vk.currencies(
	id_currency varchar(10) not null, --PK
	name varchar(30) not null
);

alter table vk.currencies
	add constraint currencies_PK primary key(id_currency);

create table vk.insurances(
	id_insurance varchar(10) not null, --PK
	name varchar(50) not null
);

alter table vk.insurances
	add constraint insurances_PK primary key(id_insurance);

create table vk.colors(
	id_color varchar(10) not null, --PK
	name varchar(30) not null
);

alter table vk.colors
	add constraint colors_PK primary key(id_color);

create table vk.company_groups(
	id_company_group varchar(10) not null, --PK
	name varchar(50) not null
);

alter table vk.company_groups
	add constraint company_groups_PK primary key(id_company_group);

create table vk.brands(
	id_brand varchar(10) not null, --PK
	name varchar(50) not null,
	id_company_group varchar(10) not null --FK
);


alter table vk.brands
	add constraint brands_PK primary key(id_brand);


alter table vk.brands
	add constraint brands_company_groups_FK 
		foreign key(id_company_group) 
		references vk.company_groups(id_company_group);



create table vk.models(
	id_model varchar(10) not null, --PK
	name varchar(50) not null,
	id_brand varchar(10) not null --FK
);

alter table vk.models
	add constraint models_PK primary key(id_model);

alter table vk.models
	add constraint models_brands_FK 
		foreign key(id_brand) 
		references vk.brands(id_brand);

	
create table vk.vehicles(
	id_vehicle varchar(10) not null, --PK
	id_model varchar(10) not null, --FK
	id_color varchar(10) not null, --FK
	registration_number varchar(10) not null,
	kms integer not null,
	id_insurance varchar(10) not null, --FK
	insurance_number varchar(100) not null,
	purchase_date date not null
);

alter table vk.vehicles
	add constraint vehicles_PK primary key(id_vehicle);

alter table vk.vehicles
	add constraint vehicles_models_FK 
		foreign key(id_model) 
		references vk.models(id_model);	
	
alter table vk.vehicles
	add constraint vehicles_colors_FK 
		foreign key(id_color) 
		references vk.colors(id_color);

alter table vk.vehicles
	add constraint vehicles_insurances_FK 
		foreign key(id_insurance) 
		references vk.insurances(id_insurance);
	
	
create table vk.hist_vehicles_reviews(
	id_vehicle varchar(10) not null, --PK, FK
	review_date date not null, --PK
	kms integer not null,
	amount decimal not null,
	id_currency varchar(10) not null --FK
);
	

alter table vk.hist_vehicles_reviews
	add constraint hist_vehicles_reviews_PK primary key(id_vehicle, review_date);


alter table vk.hist_vehicles_reviews
	add constraint hist_vehicles_reviews_currencies_FK 
		foreign key(id_currency) 
		references vk.currencies(id_currency);
		
	
-- Data Load with Inserts
	
INSERT INTO vk.currencies(id_currency, name) VALUES('0001', 'EUR');
INSERT INTO vk.currencies(id_currency, name) VALUES('0002', 'USD');
INSERT INTO vk.currencies(id_currency, name) VALUES('0003', 'GBP');

INSERT INTO vk.insurances(id_insurance, name) VALUES('0001', 'MAPFRE');
INSERT INTO vk.insurances(id_insurance, name) VALUES('0002', 'RACC');
INSERT INTO vk.insurances(id_insurance, name) VALUES('0003', 'RACE');
INSERT INTO vk.insurances(id_insurance, name) VALUES('0004', 'LIBERTY SEGUROS');
INSERT INTO vk.insurances(id_insurance, name) VALUES('0005', 'LINEA DIRECTA');

INSERT INTO vk.colors(id_color, name) VALUES('0001', 'BLANCO');
INSERT INTO vk.colors(id_color, name) VALUES('0002', 'AZUL');
INSERT INTO vk.colors(id_color, name) VALUES('0003', 'ROJO');
INSERT INTO vk.colors(id_color, name) VALUES('0004', 'AMARILLO');
INSERT INTO vk.colors(id_color, name) VALUES('0005', 'VERDE');
INSERT INTO vk.colors(id_color, name) VALUES('0006', 'NEGRO');

INSERT INTO vk.company_groups (id_company_group, name) VALUES('0001', 'Volkswagen');
INSERT INTO vk.company_groups (id_company_group, name) VALUES('0002', 'General Motors');
INSERT INTO vk.company_groups (id_company_group, name) VALUES('0003', 'BMW Group');
INSERT INTO vk.company_groups (id_company_group, name) VALUES('0004', 'Alianza Renault-Nissan-Mitsubishi');
INSERT INTO vk.company_groups (id_company_group, name) VALUES('0005', 'Toyota Motor Corporation');

INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0001', 'Seat', '0001');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0002', 'Chevrolet', '0002');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0003', 'BMW', '0003');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0004', 'Renault', '0004');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0005', 'Nissan', '0004');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0006', 'Mitsubishi', '0004');
INSERT INTO vk.brands (id_brand, name, id_company_group) VALUES('0007', 'Toyota', '0005');

INSERT INTO vk.models (id_model, name, id_brand) VALUES('0001', 'Ibiza', '0001');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0002', 'Leon', '0001');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0003', 'Corvette', '0002');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0004', 'Serie 1', '0003');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0005', 'Megane', '0004');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0006', 'Clio', '0004');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0007', 'Qashqai', '0005');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0008', 'Outlander', '0006');
INSERT INTO vk.models (id_model, name, id_brand) VALUES('0009', 'Corola', '0007');

INSERT into vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0001', '0008', '0001', 'GBN2200', 10000, '0002', '7658970868574', '2020-02-15');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0002', '0008', '0001', 'GPK2310', 20000, '0002', '1234166123512', '2020-03-16');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0003', '0001', '0001', 'GLL2760', 30000, '0001', '8769670685623', '2020-03-16');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0004', '0001', '0006', 'GHN2090', 40000, '0001', '3245678889222', '2020-05-05');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0005', '0002', '0006', 'GGG9201', 50000, '0003', '9871287412482', '2020-07-05');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0006', '0003', '0004', 'FFX3475', 60000, '0003', '7651243699222', '2020-01-05');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0007', '0003', '0004', 'KLL1100', 2000, '0003', '2398741191998', '2021-02-15');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0008', '0005', '0003', 'GDN2200', 10020, '0003', '8762435678762', '2020-02-15');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0009', '0005', '0002', 'MFN3300', 500, '0001', '765283416572', '2022-02-15');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0010', '0002', '0005', 'FYN4400', 34000, '0004', '0987651111441', '2020-04-12');
INSERT INTO vk.vehicles (id_vehicle, id_model, id_color, registration_number, kms, id_insurance, insurance_number, purchase_date) 
VALUES('0011', '0004', '0001', 'GHN2200', 10000, '0005', '5768190894621', '2020-06-22');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0001', '2021-01-10', 8000, 100, '0001');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0001', '2021-02-10', 9000, 80, '0001');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0001', '2021-03-10', 10000, 200, '0001');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0002', '2021-01-10', 10000, 100, '0002');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0002', '2021-02-10', 20000, 100, '0002');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0003', '2021-05-10', 20000, 98, '0003');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0003', '2021-06-10', 30000, 90, '0003');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0004', '2021-01-10', 10000, 100, '0001');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0005', '2022-01-10', 10000, 120, '0002');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0005', '2022-02-10', 20000, 120, '0002');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0005', '2022-03-10', 30000, 120, '0002');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0005', '2022-04-10', 50000, 120, '0002');

INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0007', '2022-05-10', 2000, 100, '0001');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0009', '2022-11-10', 500, 400, '0001');
INSERT INTO vk.hist_vehicles_reviews (id_vehicle, review_date, kms, amount, id_currency)
VALUES('0011', '2022-01-10', 10000, 100, '0001');
