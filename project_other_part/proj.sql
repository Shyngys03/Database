-- 2

-- Relational Model

create table company(
    id char(10) primary key,
    name varchar(30),
    num_of_employee int
);

create table brands(
    id char(10) primary key,
    name varchar(30),
    location varchar(30)
);

create table brands_of_companies(
    company_id char(10) references company(id),
    brand_id char(10) references brands(id)
);

create table models(
    id char(10) primary key,
    name varchar(30),
    year int,
    plant_id char(10) references plants_of_parts(id),
    full_plant_id char(10) references full_car_plants(id)
);

create table model_brands(
    brand_id char(10) references brands(id),
    model_id char(10) references models(id)
);

create table suppliers(
    id char(10) primary key,
    name varchar(30),
    income double precision,
    phone_number char(12)
);

create table supply_models(
    sup_id char(10) references suppliers(id),
    model_id char(10) references models(id)
);

create table full_car_plants(
    id char(10) primary key references models(id),
    num_of_cars int,
    num_of_employees int,
    address varchar(30)
);

create table parts_of_car(
    id char(10) primary key,
    name varchar(30),
    made_time date,
    vin char(10) references vehicle(vin)
);

alter table full_car_plants
add column sup_id char(10) references suppliers(id);

create table plants_of_parts(
    id char(10) primary key,
    supplied_part char(10) references parts_of_car(id),
    num_of_parts int,
    num_of_employees int
);

create table employee(
    id char(10) primary key,
    company_id char(10) references company(id),
    salary int
);

create table operator(
    id char(10) primary key references employee(id),
    calls_per_day int
);

create table data_scientist(
    id char(10) primary key references employee(id),
    room int
);

create table engineer(
    id char(10) primary key references employee(id),
    garage_number int
);

create type p_name as(
    first_name varchar(30),
    last_name varchar(30)
                   );

create type address as(
    city varchar,
    disrict varchar,
    zip char(6)
                      );

create table person(
    id char(10) primary key,
    per_name varchar,
    phone_number char(12),
    age int,
    gender char(1),
    p_address varchar
);

create table customer(
    id char(10) primary key,
    c_name varchar,
    phone_number char(12),
    c_address varchar
);

create table dealer(
    id char(10) primary key,
    d_name varchar,
    phone_number char(12),
    d_address varchar
);

create table sales(
    d_id char(10) references dealer(id),
    date timestamp,
    brand_id char(10) references brands(id),
    model_id char(10) references models(id),
    c_id char(10) references customer(id),
    primary key (d_id, c_id)
);

create table warehouse(
    id char(5) primary key,
    d_id char(10),
    w_address varchar,
    num_of_vehicles int
);

create table vehicle(
    vin char(14) primary key,
    w_id char(5) references warehouse(id)
);

create table car(
    vin char(14) primary key references vehicle(vin),
    door_num int
);

create table wagon(
    vin char(14) primary key references vehicle(vin),
    mass double precision
);

create table motocycle(
    vin char(14) primary key references vehicle(vin),
    cube double precision
);

create table options(
    vin char(14) primary key references vehicle(vin),
    color varchar,
    engine double precision,
    transmission text
);


alter table customer
alter column vin type char(14);

-- 4(2)
select v.vin
from customer
right join vehicle v on customer.vin = v.vin
right join options o on v.vin = o.vin
right join parts_of_car poc on v.vin = poc.vin
right join plants_of_parts pop on poc.id = pop.supplied_part
right join suppliers s on s.id = pop.sup_id
where s.name = 'Getrag' and poc.name = 'transmission' and made_time between x and y;

-- 4(3)
select max(*)
from (select sum(models.cost)
      from brands
               right join model_brands mb on brands.id = mb.brand_id
               right join models m on m.id = mb.model_id
               right join sales s on m.id = s.model_id
      where sales.date + interval 1 year < getdate()
group by brands.id
) as ans;

-- 4(4)
select max(*)
from (select cnt(models.id)
      from brands
               right join model_brands mb on brands.id = mb.brand_id
               right join models m on m.id = mb.model_id
               right join sales s on m.id = s.model_id
      where sales.date + interval 1 year < now()
group by brands.id
) as res;

-- 4(5)




-- 4(6)
select id, max(av)
from (
         select d.id as id, d_name as name, avg(now() - o.w_time) as av
         from warehouse
                  right join vehicle v on warehouse.id = v.w_id
                  right join options o on v.vin = o.vin
                  right join dealer d on d.id = warehouse.d_id
         group by d.id, d_name
) as foo
group by id;



-- Вначале данные, те что писал в create table и те, что в запросах отличаются.
-- Так как походу процесса добавлял и удалял атрибуты и удалял alter-ы
-- Извинияюсь за неудобство;