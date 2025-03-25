--                       Types of SQL Commands
--  (DDL) DML
--  Data Definition Language Data Manipulation Language
--  CREATE       INSERT
--  ALTER        UPDATE
--  DROP           DELETE
--  TRUNCATE

-----------------------------------------------------------------------------------------------

use master ;
create database test;
drop database test;

-----------------------------------------------------------------------------------------------

USE MASTER ;
Go
CREATE DATABASE ltest ON (
 NAME= ltest_data,
 FILENAME='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ltestdata.mdf',
 SIZE=10,
 MAXSIZE=12,
 FILEGROWTH=2) 
 log on (
 name= ltest_log,
 filename='C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\ltestlog.ldf',
 size=10,
 maxsize=12,
 filegrowth=2);
 go

-----------------------------------------------------------------------------------------------

use sales;
go 

create schema sales_schema;

create schema production;

drop schema production;

-----------------------------------------------------------------------------------------------

use sales;

GO

create table sales_schema.customers(
customer_id int not null,
first_name  varchar (15) not null,
last_name varchar (15) not null,
email varchar (50) not null,
phone varchar (15) ,
state varchar (15),
city varchar (15) not null ,
street varchar (30) not null,
zip_code varchar (5)
);

create table categories(
category_id int primary key,
category_name varchar (20)
);

drop table brands;

create table brands (
brand_id int ,
brand_name varchar (20),
constraint brands_pk primary key (brand_id)
);



drop table sales_schema.customers;

create table sales_schema.customers(
customer_id int not null,
first_name  varchar (15) not null,
last_name varchar (15) not null,
email varchar (50) not null,
phone varchar (15) ,
state varchar (15),
city varchar (15) not null ,
street varchar (30) not null,
zip_code varchar (5),

constraint customers_un unique (phone)
);


create table staff(
staff_id int primary key ,
first_name varchar (20) not null,
last_name varchar (20) not null,
salary numeric (7,2) check (salary between 300 and 15000 ),
hire_date date,
);


drop table staff ;

create table staff(
staff_id int primary key ,
first_name varchar (20) not null,
last_name varchar (20) not null,
salary numeric (7,2),
hire_date date,
constraint staff_ck check  (salary between 300 and 15000 )
);

create table store (
store_id int primary key,
stroe_name varchar (30),
 city varchar (30) not null,
 phone varchar (10)
 );

drop table staff ;

create table staff(
staff_id int primary key ,
first_name varchar (20) not null,
last_name varchar (20) not null,
salary numeric (7,2),
hire_date date,
store_no int ,
constraint store_staff_fk foreign key (store_no) references store (store_id)
);

create table orders (
order_id int primary key ,
order_date date ,
order_status varchar (10),
customer_id int references sales_schema.customers (customer_id)
);

-----------------------------------------------------------------------------------------------

use sales;

go

alter table store
add street varchar (20);


alter table store 
add zip_code int ,
fax varchar(10);


alter table store
alter column stroe_name varchar(50);


alter table store
alter column city varchar(25) null;

alter table store
drop column fax;


alter table store 
add constraint store_name_uq unique (stroe_name);

create table products (
product_id int not null,
product_name varchar(20),
model int,
brand_id int );


alter table products
add constraint products_pk primary key (product_id);


alter table products
add constraint brands_products_fk foreign key (brand_id) references brands (brand_id);


alter table store 
drop constraint store_name_uq;

alter table products
drop constraint brands_products_fk;


EXEC sp_rename 'staff' , 'workers';

EXEC sp_rename 'store' , 'stores';

exec sp_rename 'stores.stroe_name' ,'store_name' ,'COLUMN';

drop table workers;

create table staff(
staff_id int identity (1,2),
store_no int  ,
order_status tinyint ,
city varchar (10) check (city  in ('Riyadh','Macca' ,'Madina')),
constraint store_staff_fk foreign key (store_no) references stores (store_id),
constraint staff_pk  primary key (staff_id)
); 

use sales;

go

insert into brands(
	brand_id
)
values(
   12
   );

insert into sales_schema.customers(
    customer_id,first_name,last_name,email,city,street
)
values(
    13,'ahmed','said','ahmedsaid@hotmail','alex','12'
	);

insert into sales_schema.customers(
    customer_id,first_name,last_name,email,city,street,phone
)
values
(1400,'sameh','morad','sameh@hotmail','portsaid','45','90'),
(1053,'hamed','maged','hamed@hotmail','aswan','119','78');

insert into brands(
	brand_id
)
output inserted.brand_id,inserted.brand_name
values
(140),
(120);

update sales_schema.customers
set email='hamd@gmail.com',first_name='hamd'
where customer_id=1053;

delete from sales_schema.customers
where customer_id=1053;

delete from sales_schema.customers
where customer_id between 1 and 3;

delete top(4)from sales_schema.customers;

delete top(10)percent from sales_schema.customers;

select * from sales_schema.customers;

select customer_id,last_name 
from sales_schema.customers;


select customer_id,first_name+''+last_name 
from sales_schema.customers;

select customer_id,first_name+''+last_name as 'Customer Name'
from sales_schema.customers;

select * from sales_schema.customers
where city='alex';

select product_id ,model 
from products
where product_id > 12 and model >= 2018;

select product_id ,model 
from products
where product_id > 12 or model >= 2018;

select product_id ,model 
from products
where product_id <> 12 ;

select * from sales_schema.customers
where phone is null;

select * from sales_schema.customers
where city is not null;

select * from sales_schema.customers
where city in ('alex','cairo','aswan');

select * from sales_schema.customers
where city not in ('alex','cairo','aswan');

select * from sales_schema.customers
where customer_id between 12 and 100;

select * from sales_schema.customers
where customer_id not between 12 and 100;

select  distinct city
from sales_schema.customers;

select  distinct city,last_name 
from sales_schema.customers;

select customer_id,last_name 
from sales_schema.customers
where email like '%@hotmail.com';

select customer_id,last_name 
from sales_schema.customers
where first_name like 'A%';

select customer_id,last_name 
from sales_schema.customers
where first_name like '%R%';

select customer_id,last_name 
from sales_schema.customers
where first_name like '___';

select customer_id,last_name 
from sales_schema.customers
where first_name like '_A__e';

select customer_id,last_name 
from sales_schema.customers
where email like '[ae]%';

select customer_id,last_name 
from sales_schema.customers
where email like '[a-x]%';

select customer_id,last_name 
from sales_schema.customers
where email not like '[a-c]%';

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2';

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2'
order by last_name;

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2'
order by last_name asc;

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2'
order by last_name desc;

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2'
order by last_name , customer_id;

select customer_id,last_name 
from sales_schema.customers
where customer_id like '3__.2'
order by last_name asc, customer_id desc;

select staff_id,store_id,store_no 
from staff,stores
where store_id=store_no;

select staff_id,store_id,store_no 
from staff f,stores o
where o.store_id=f.store_no;

select staff_id,store_id,store_no 
from staff join stores
on store_id=store_no;

select staff_id,store_id,store_no 
from staff inner join stores
on store_id=store_no;

select staff_id,store_id,store_no 
from staff left outer join stores
on store_id=store_no;

select staff_id,store_id,store_no 
from staff right outer join stores
on store_id=store_no;

select staff_id,store_id,store_no 
from staff full outer join stores
on store_id=store_no;


select staff_id,store_id,store_no ,c.city
from staff ,stores s,sales_schema.customers c
where store_id=store_no and s.city=c.city;

select staff_id,store_id,store_no ,c.city
from staff join stores s 
on store_id=store_no 
join sales_schema.customers c on s.city=c.city;
-- 28th video --