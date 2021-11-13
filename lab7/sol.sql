-- 1
-- Large objects (photos, videos, CAD files, etc.) are stored as
-- a large object:
--  • blob: binary large object -- object is a large collection of
--      uninterpreted binary data (whose interpretation is left to
--      an application outside of the database system)
--  • clob: character large object -- object is a large collection
--      of character data
-- When a query returns a large object, a pointer is returned
-- rather than the large object itself.


-- 2

-- a
create role accountant;
create role administrator;
create role support;

grant select, insert, delete on accounts to accountant;
grant select, insert on transactions to administrator;
grant all privileges on customers to support;

-- b
create user u1;
create user u2;
create user u3;

grant accountant to u1;
grant administrator to u2;
grant support to u3;

-- c
alter role accountant createrole;

-- d
revoke all privileges on accounts from accountant;
revoke all privileges on customers from support;
revoke all privileges on transactions from administrator;


drop role accountant;
drop role administrator;
drop role support;

-- 3


-- NO SOLUTION

-- b
alter table customers
alter column name set not null;

alter table transactions
alter column status set not null;

alter table accounts
alter column limit set not null;

-- 5

-- a
create index index1 on accounts(customer_id, currency);

-- b
create index index2 on accounts(balance, currency);

-- 6
create or replace procedure proc6(id_name int, data timestamp, sr_a varchar(40), ds_a varchar(40), amo double precision)
as
 $$
    declare
        bal int;
        lim int;
    begin
        insert into transactions values (id_name, data, sr_a, ds_a, amo, 'init');

        update accounts
        set balance = balance - 10
        where account_id = sr_a;

        update accounts
        set balance = balance + 10
        where account_id = ds_a;

        if bal < lim then
            update transactions set status = 'rollback' where id = 1;
            rollback;
        else
            update transactions set status = 'commit' where id = 2;
            commit;
        end if;
    end;
    $$;