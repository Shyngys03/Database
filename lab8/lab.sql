-- 1
-- a
create function f1(x integer) returns integer as $$
    begin
        return x + 1;
    end;$$
language plpgsql;

select f1(24);


-- b
create function f2(x integer, y integer) returns integer as $$
    begin
        return x + y;
    end;$$
language plpgsql;

select f2(4, 2);

-- c
create function f3(x integer) returns bool as $$
    begin
        return x % 2 = 0;
    end;$$
language plpgsql;

select f3(105);

-- d
create function f4(x varchar) returns bool as $$
    begin
        return length(x) >= 8;
    end;$$
language plpgsql;

select f4('dwaddawcasva');

-- e
create or replace function f5(s varchar) returns void as $$
    begin
        select s, length(s);
    end;$$
language plpgsql;



-- 4

create table task(
    id int primary key,
    name varchar,
    date_of_birth date,
    age int,
    salary int,
    workexperience int,
    discount int
);

-- a
create procedure p1(in sal integer, in wo integer, in disc integer, out new_sal integer, out new_disc integer) as $$
    begin
        new_sal := sal * 1.1^(wo / 2);
        new_disc := disc * 1.1^(wo / 2);
        new_disc = new_disc * 1.01^(wo / 5);

        update task
        set salary = new_sal and discount = new_disc
        where salary = sal and workexperience = wo and discount = disc;

        commit;

end;$$
language plpgsql;

-- b
create procedure p2(in ag integer, in sal integer, in wo integer, in disc integer, out new_sal integer, out new_disc integer) as $$
    begin
        new_sal := sal;
        new_disc := disc;
        if ag == 40 then
            new_sal := sal * 1.15;
        end if;
        if wo > 8 then
            new_disc := 20;
            new_sal := new_sal * 1.15;
        end if;

        update task
        set salary = new_sal and discount = new_disc
        where age = ag and salary = sal and workexperience = wo;

        commit;
    end;
    $$
language plpgsql;