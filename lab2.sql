create database lab2
    with owner postgres;


-- 1

-- DDL
create database db_name;

drop database db_name;

alter table table_name
add column column_name;

alter table table_name
drop column column_name;

alter table table_name
rename column column_name
to new_name;

alter table table_name
rename to new_table_name;


-- DML

insert into table_name (column1, column3)
values (val1, val3);

insert into table_name
values (val1, val2, val3);

update table_name
set  col1 = new_val1, col2 = new_val2
where col3 = new_val3;

delete from table_name
where col1 = val1;


-- 2
create table customers(
    id int not null primary key,
    full_name varchar(50) not null,
    timestamp timestamp not null,
    delivery_address text not null,
    constraint unique_values unique (id)
);

create table products(
    id varchar not null primary key,
    name varchar not null,
    description text,
    price double precision not null check (price > 0),
    constraint unique_values unique (id, name)
);

create table orders(
    code int not null primary key,
    customer_id int references customers (id),
    total_sum double precision not null check (total_sum > 0),
    is_paid boolean not null,
    constraint unique_values unique (code)
);

create table order_items(
    order_code int not null references orders (code),
    product_id varchar not null references products (id),
    quantity int not null check (quantity > 0),
    constraint unique_values unique (order_code, product_id)
);

-- 3

-- a
create table students(
    full_name varchar(50) not null,
    age int,
    birth_date char(10),
    gender varchar,
    average_grade double precision,
    info_student text not null,
    need_dormitory boolean,
    additional_info text
);

-- b
create table instructors(
    full_name varchar(50) not null,
    speaking_languages text,
    work_experience text,
    remote_lessons boolean
);

-- c
create table lesson_participants(
    lesson_title varchar,
    instructor varchar,
    students text,
    room int
);


-- 4

insert into customers
values (3842, 'Zhekebaev Shyngys', '2021-09-23 16:25:11-06', 'city Almaty, street Nazarbayev 29');

insert into orders
values (2415, 3842, 241.85, true);

insert into products
values ('34711', 'Iphone 13 Pro 512 GB', 'color - ocean blue, 5G, Wi-Fi 6, 13', 2000.0);

insert into order_items
values (2415, '34711', 5);


update customers
set delivery_address = 'city Almaty, street Pushkin 52'
where id = 3842;

update orders
set is_paid = false
where customer_id = 3842;

update products
set price = 1500.0
where id = '34711';

update order_items
set quantity = 3
where order_code = 2415;

delete from customers
where id = 3842;

delete from orders
where code = 2415;

delete
from products
where id = '34711';

delete
from order_items
where product_id = '34711';