create database project4;

# DATA CLEANING PROCESS IN SQL
use project4;
rename table `hr-data` to hr_data;

desc hr_data;

alter table hr_data
modify column date_of_joining date;

update hr_data
set salary = replace(salary, '$', '');

update hr_data
set salary = replace(salary, ',','');

alter table hr_data
modify column salary int;

alter table hr_data
modify column age int;

alter table hr_data
rename column `Emp ID` to emp_id;

alter table hr_data
drop column `Date of Join`;

alter table hr_data
rename column `Leave Balance` to leave_balance;

# KPI cards
-- 1.
select
	count(*) as people_count
from
	hr_data
;

-- 2.
select
	concat(round(avg(salary)/1000,2), ' ', 'K') as avg_salary
from
	hr_data;
    
-- 3.
select
	round(avg(leave_balance),0) as avg_leave_balance
from
	hr_data;
    
-- 4.
select
	count(*) as `leave balance >= 20`
from
	hr_data
where
	leave_balance >= 20;
    
# DASHBOARD VISUALS
-- 1.
select
	job_title,
    count(*) as count_of_employees
from
	hr_data
group by
	job_title
order by
	count_of_employees desc;
    
-- 2.
select
	gender,
    count(*) as count_of_employees
from
	hr_data
group by
	1;
    
SELECT
    gender,
    COUNT(*) AS count_of_employees,
    round(count(*)/sum(count(*)) over (),2)*100 as percentages
FROM
    hr_data
GROUP BY
    gender;
    
select
	gender,
    count(*) as count_of_employees,
    round(count(*)/ (select count(*) from hr_data) * 100,2)  as percentage_distribution
from
	hr_data
group by 
	gender;
    
-- 3.
SELECT
    age,
    count(case when gender = 'female' then 1 end) as females_count,
    count(case when gender = 'male' then 1 end) as males_count
from
	hr_data
group by
	age
order by
	age;
    
-- 4. 
select
	Education_Qualification,
    concat('$',round(sum(salary)/100000,2),' ', 'M') as total_salary
from
	hr_data
group by
	education_qualification;
    
-- 5.
select
	date_of_joining,
	count(emp_id) over(order by date_of_joining rows between unbounded preceding and current row) as cumulative_count
from
	hr_data
order by
	date_of_joining;
    
        
SELECT
    year(date_of_joining),
    COUNT( emp_id) OVER (ORDER BY year(date_of_joining) ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_distinct_count
FROM
    hr_data
ORDER BY
    date_of_joining;


# extra analytics
select
	job_title,
    round(avg(salary),2) as avg_salary,
    min(salary) as min_salary,
    max(salary) as max_salary,
    count(*) as employee_count
from
	hr_data
group by
	job_title
order by
	avg_salary desc;
    

select
	emp_id,
    name,
    job_title,
    sum(salary) as total_salary
from
	hr_data
where
	substring(name, 1,1) = 'a'
group by
	emp_id,
    name,
    job_title;
    
    
select
	job_title,
    round(avg(leave_balance),0) as avg_leavebalance
from
	hr_data
group by
	job_title
order by
	avg_leavebalance desc;
    
select
	job_title,
    round(avg(leave_balance),0) as avg_leavebalance,
    count(case when leave_balance >=20 then true end) as count_20_plus
from
	hr_data
group by
	job_title
order by
	3 desc;

