
-- 1

-- a
select *
from course
where credits > 3;

-- b
select *
from classroom
where building = 'Watson' or building = 'Packard';

-- c
select *
from course
where dept_name = 'Comp. Sci.';

-- d
select course.course_id, title
from course
inner join section s
    on course.course_id = s.course_id
where semester = 'Fall';

-- e
select *
from student
where tot_cred > 45 and tot_cred < 90;

-- f
select *
from student
where name similar to '%(a|e|i|o|u|y)';

-- g
select course.course_id, course.title
from course
inner join prereq p
    on course.course_id = p.course_id
where p.prereq_id = 'CS-101';


-- 2

-- a
select dept_name, avg(salary)
from instructor
group by dept_name;

-- b
select building
from (select building, count(course_id)
    from section
    group by building) as foo
where foo.count = (select max(cnt.count)
    from (select building, count(course_id)
        from section
        group by building) as cnt);

-- c
select dept_name
from (select dept_name, count(course_id) as count_courses
from course
group by dept_name) as foo
where count_courses = (select min(cnt.count_courses)
    from (select course.dept_name, count(course_id) as count_courses
        from course
        group by course.dept_name) as cnt);

-- d
select foo.ID, foo.name
from (select student.ID, name, count(c.course_id)
    from student
    inner join takes t
        on student.ID = t.ID
    inner join course c
        on t.course_id = c.course_id
    where c.dept_name = 'Comp. Sci.'
    group by student.ID, name)
    as foo
where foo.count > 3;

-- e
select id, name, dept_name
from instructor
where dept_name = 'Biology' or dept_name = 'Philosophy' or dept_name = 'Music';

-- f
select instructor.ID, name, year
from instructor
inner join teaches t
    on instructor.ID = t.ID
where year = 2018;

-- 3

-- a
select name, s.ID, course_id
from takes
left join student s
    on takes.ID = s.ID
where grade = 'A' or grade = 'A-'
order by name;

-- b
select i_ID, s_ID, course_id, grade
from advisor
inner join student s
    on s.ID = advisor.s_ID
inner join takes t
    on s.ID = t.ID
where grade != 'A' and grade != 'A-' and grade is not null;

-- c
select distinct dept_name
from takes
inner join course c
    on takes.course_id = c.course_id
where grade != 'F' and grade != 'C-' and grade != 'C' and grade != 'C+';

-- d
select distinct instructor.ID, instructor.name
from instructor
inner join advisor a
    on instructor.ID = a.i_ID
inner join student s
    on s.ID = a.s_ID
inner join takes t
    on s.ID = t.ID
where grade != 'A' and grade != 'A-';


-- e
select distinct c.course_id, title
from section
inner join public.time_slot ts
    on section.time_slot_id = ts.time_slot_id
inner join public.course c
    on section.course_id = c.course_id
where end_hr < 13;
