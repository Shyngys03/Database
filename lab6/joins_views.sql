-- 1

-- a
select *
from dealer
right join client c on dealer.id = c.dealer_id;

-- b
select dealer.name, c.name, c.city, c.priority, s.id, s.date, s.amount
from dealer
right join client c
    on dealer.id = c.dealer_id
left join sell s
    on c.id = s.client_id;

-- c
select dealer.id, dealer.name, c.id, c.name, location
from dealer
right join client c
    on location = city
where dealer.id is not null and c.id is not null;

-- d
select sell.id, amount, name, city
from sell
inner join client c
    on sell.client_id = c.id
where amount between 100 and 500;

-- e
select dealer.id, dealer.name, count(c.id)
from dealer
left join client c on dealer.id = c.dealer_id
group by dealer.id, dealer.name;

-- f
select d.name, city, client.name, charge
from client
left join dealer d
    on d.id = client.dealer_id;

-- g
select d.name, city, client.name, charge
from client
left join dealer d
    on d.id = client.dealer_id
where charge > 0.12;

-- h
select client.name, city, s.id, date, amount, d.name, charge
from client
left join sell s on client.id = s.client_id
left join dealer d on client.dealer_id = d.id;


-- i
select c.name, priority, dealer.name, s.id, amount
from dealer
left join client c on dealer.id = c.dealer_id
right join sell s on dealer.id = s.dealer_id
where amount > 2000  and priority is not null;


-- 2

-- a
create view view_1 as
    select date, count(id), avg(amount), sum(amount) as total
    from sell
    group by date;

select *
from view_1;

drop view view_1;

-- b
create view view_2 as
    select *
    from view_1
    order by total desc
    limit 5;

select *
from view_2;

drop view view_2;

-- c
create view view_3 as
    select dealer.id, avg(s.amount), sum(s.amount) as total
    from dealer
    left join sell s on dealer.id = s.dealer_id
    group by dealer.id;

select *
from view_3;

drop view view_3;

-- d
create view view_4 as
    select view_3.id, total * charge as earn_dealer
    from view_3, dealer
    where view_3.id = dealer.id;

select *
from view_4;

drop view view_4;

-- e
create view view_5 as
    select location, count(sell.id), avg(amount) as avg, sum(amount) as total
    from sell
    left join dealer d on d.id = sell.dealer_id
    group by location;

select *
from view_5;

drop view view_5;

-- f
create view view_6 as
    select city, avg(amount) as avg, sum(amount) as total
    from client
    left join sell s on client.id = s.client_id
    group by city;

select *
from view_6;

drop view view_6;

-- g
create view view_7 as
    select city
    from view_5
    left join view_6 on location = city
        where view_5.total < view_6.total;

select *
from view_7;

drop view view_7;