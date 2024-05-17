Create database Crowdfund;
use crowdfund;

select * from projects;
drop table projects;

desc projects;

SELECT 
    SUM(CASE WHEN ProjectID IS NULL THEN 1 ELSE 0 END) AS ProjectID_Null,
    SUM(CASE WHEN state IS NULL THEN 1 ELSE 0 END) AS state_Null,
    SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS name_Null,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_Null,
    SUM(CASE WHEN creator_id IS NULL THEN 1 ELSE 0 END) AS creator_id_Null,
    SUM(CASE WHEN location_id IS NULL THEN 1 ELSE 0 END) AS location_id_Null,
    SUM(CASE WHEN category_id IS NULL THEN 1 ELSE 0 END) AS category_id_Null,
    SUM(CASE WHEN created_at IS NULL THEN 1 ELSE 0 END) AS created_at_Null,
    SUM(CASE WHEN deadline IS NULL THEN 1 ELSE 0 END) AS deadline_Null,
    SUM(CASE WHEN updated_at IS NULL THEN 1 ELSE 0 END) AS updated_at_Null,
    SUM(CASE WHEN state_changed_at IS NULL THEN 1 ELSE 0 END) AS state_changed_at_Null,
    SUM(CASE WHEN successful_at IS NULL THEN 1 ELSE 0 END) AS successful_at_Null,
    SUM(CASE WHEN launched_at IS NULL THEN 1 ELSE 0 END) AS launched_at_Null,
    SUM(CASE WHEN goal IS NULL THEN 1 ELSE 0 END) AS goal_Null,
    SUM(CASE WHEN pledged IS NULL THEN 1 ELSE 0 END) AS pledged_Null,
    SUM(CASE WHEN currency IS NULL THEN 1 ELSE 0 END) AS currency_Null,
    SUM(CASE WHEN currency_symbol IS NULL THEN 1 ELSE 0 END) AS currency_symbol_Null,
    SUM(CASE WHEN usd_pledged IS NULL THEN 1 ELSE 0 END) AS usd_pledged_Null,
    SUM(CASE WHEN static_usd_rate IS NULL THEN 1 ELSE 0 END) AS static_usd_rate_Null,
    SUM(CASE WHEN backers_count IS NULL THEN 1 ELSE 0 END) AS backers_count_Null,
    SUM(CASE WHEN spotlight IS NULL THEN 1 ELSE 0 END) AS spotlight_Null,
    SUM(CASE WHEN staff_pick IS NULL THEN 1 ELSE 0 END) AS staff_pick_Null,
    SUM(CASE WHEN blurb IS NULL THEN 1 ELSE 0 END) AS blurb_Null,
    SUM(CASE WHEN currency_trailing_code IS NULL THEN 1 ELSE 0 END) AS currency_trailing_code_Null,
    SUM(CASE WHEN disable_communication IS NULL THEN 1 ELSE 0 END) AS disable_communication_Null
FROM projects;

select * from projects limit 5 ;



alter table projects add column createddate date, add column	successfuldate date;
SET SQL_SAFE_UPDATES = 0;

update projects set createddate=date(from_unixtime(created_at)),successfuldate=date(from_unixtime(launched_at));


UPDATE projects
SET successfuldate = CASE 
                        WHEN successful_at IS NULL OR successful_at = 0 THEN '1970-01-01' 
                        ELSE DATE(FROM_UNIXTIME(successful_at)) 
                    END;


create table Calendar as select distinctrow(createddate) from projects;

select * from calendar;

alter table calendar add column years int,add column monthNo int, add column monthname varchar(50), 
add column quarters varchar(20), add column Yearmonth varchar(50), add column weekday int, 
add column weekdayName varchar(50), add column Fincialmonth varchar(50), add column FinancialQuarter varchar(50);


update calendar set years=year(createddate);
update calendar set monthNo=month(createddate);
update calendar set monthname=monthname(createddate);
update calendar set quarters=concat("Q",quarter(createddate));
update calendar set yearmonth=concat(years,"-",monthname);
update calendar set weekday=week(createddate),weekdayName=dayname(createddate);
update calendar set Fincialmonth=
    CASE 
        WHEN monthname = 'January' THEN 'FM10'
        WHEN monthname = 'February' THEN 'FM11'
        WHEN monthname = 'March' THEN 'FM12'
        WHEN monthname = 'April' THEN 'FM01'
        WHEN monthname = 'May' THEN 'FM02'
        WHEN monthname = 'June' THEN 'FM03'
        WHEN monthname = 'July' THEN 'FM04'
        WHEN monthname = 'August' THEN 'FM05'
        WHEN monthname = 'September' THEN 'FM06'
        WHEN monthname = 'October' THEN 'FM07'
        WHEN monthname = 'November' THEN 'FM08'
        WHEN monthname = 'December' THEN 'FM09'
        ELSE 'Default Result'
    END ;

										
UPDATE CALENDAR SET FinancialQuarter=    CASE 
        WHEN Fincialmonth = 'FM10' THEN "FQ-4"
        WHEN Fincialmonth =  'FM11' THEN "FQ-4"
        WHEN Fincialmonth = 'FM12' THEN "FQ-4"
        WHEN Fincialmonth ='FM01' THEN "FQ-1"
        WHEN Fincialmonth = 'FM02' THEN "FQ-1"
        WHEN Fincialmonth = 'FM03'THEN "FQ-1"
        WHEN Fincialmonth = 'FM04'THEN "FQ-2"
        WHEN Fincialmonth = 'FM05' THEN "FQ-2"
        WHEN Fincialmonth = 'FM06' THEN "FQ-2"
        WHEN Fincialmonth = 'FM07' THEN "FQ-3"
        WHEN Fincialmonth = 'FM08' THEN "FQ-3"
        WHEN Fincialmonth = 'FM09'THEN "FQ-3"
        ELSE 'Default Result'
    END ;
    
 -- ############   TABLE CREATOR #############################   
 drop table book1;
 SET SQL_SAFE_UPDATES = 0;
drop table creator;
create table creator( id int default 0 , name longtext default null,sln int default 0);
select * from creator;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Creator.csv' INTO TABLE creator FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

alter table creator drop column sln ;
select count(id) from creator;
-- ###### Category #################
drop table category;
create table category(id	int default null ,name longtext default null,parent_id longtext	default null,position int default null);
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/category.csv' INTO TABLE category FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

select * from category;


-- ########## Location #########
drop table location;
create table Location (id int primary key, displayable_name longtext default null,type longtext default null,	name longtext default null,	state longtext default null,	short_name longtext default null,	is_root	longtext default null,country longtext default null);
select * from location;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/location.csv' INTO TABLE location FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

alter table location add column locname text;
alter table location drop column locname;
update location set locname=country ;

set SQL_Safe_updates=0;



-- ### Country Name ###
drop table cname;
create table cname(name longtext,code2 longtext, code3 longtext);
select * from cname;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/countrynam.csv' INTO TABLE country FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;


select * from location;
select * from country;


update location join country on location.country=country.ï»¿code set locname=if(location.country=country.ï»¿code,countryname,"Other");

select location.country,country.ï»¿code from location join country on location.country=country.ï»¿code;

UPDATE location
left JOIN country ON location.country = country.ï»¿code
SET location.locname = country.countryname;


-- KPI's -----------------------------------------------------------------------------------------------------------
-- 5. Projects Overview KPI :
-- 1)  Total Number of Projects based on outcome 

select state,count(projectid) As Total_Projects, concat(round((count(projectid)/(select count(projectid) from projects)*100),2),"%") as "%" from projects  group by state;


-- 2) Total Number of Projects based on Locations

select country.countryname,count(projects.projectid) Total_projects from country  join projects on projects.country=country.code where ProjectID is not null group by country.countryname order by Total_projects  desc;

select country.countryname,count(projects.projectid) Total_projects from projects 
 join location on location.id=projects.location_id
 join country on country.code=location.country group by country.countryname;

-- 3)Total Number of Projects based on  Category

select category.name, count(projects.projectid) Total_projects from projects
join category on category.id=projects.category_id group by category.name order by total_projects desc;

-- 4) Total Number of Projects created by Year , Quarter , Month
select calendar.years,calendar.quarters,calendar.monthname,count(projects.projectid) Total_projects from projects
join calendar on projects.createddate=calendar.createddate group by calendar.years,calendar.quarters,calendar.monthname  ;

select calendar.years,count(projects.projectid) Total_projects from projects
join calendar on projects.createddate=calendar.createddate group by calendar.years order by years ;

select year(createddate) years,count(projects.projectid) Total_projects from projects group by years order by years;


-- 6.  Successful Projects
--   1) Amount Raised 

select sum(usd_pledged) Total_amount_rasied from projects where state="successful";

-- 2)Number of Backers
select sum(backers_count) Total_backerscount from projects where state="successful";

-- 3) Avg NUmber of Days for successful projects

select concat(round(avg(datediff(successfuldate,createddate))),"-Days") Average_Day from projects  where state="successful";

-- 7 . Top Successful Projects :
--  1)  Based on Number of Backers
    select name,CONCAT(SUM(backers_count) DIV 1000, 'K') Total_Count from projects where state="successful" group by name order by sum(backers_count) desc limit 10;
    
 -- 2) Based on Amount Raised.
 select name,CONCAT(SUM(usd_pledged) DIV 1000000, 'M')Total_amount from projects where state="successful" group by name order by sum(usd_pledged)  desc limit 10 ;
 
 -- 8.1 Percentage of Successful Projects overall
select state as Project_state,concat(round((count(projectid)/(select count(projectid) from projects)*100),2),"%") as "Succssful_%" from projects  where state="successful" group by state;

-- 8.2 Percentage of Successful Projects  by Category
select category.name namess,concat(round((count(projectid)/(select count(projectid) from projects where state="successful")*100 ),2),"%") "Total_%" from projects  join
category on projects.category_id=category.id where projects.state="successful" group by namess order by round((count(projectid)/(select count(projectid) from projects where state="successful")*100 ),2) desc;

-- 8.3    Percentage of Successful Projects by Year , Month etc..
select calendar.years,calendar.monthname,concat(round((count(projectid)/(select count(projectid) from projects where state="successful")*100 ),2),"%") "Total_%" from projects  join
calendar on projects.createddate=calendar.createddate where projects.state="successful" group by years,monthname order by years desc;

-- 8.4 Percentage of Successful projects by Goal Range ( decide the range as per your need )

select if(goal<=10000,"0-10K",if(goal>=10000 and goal<=50000,"10-50K",if(goal>=50000 and goal<=100000,"50-100k","100k Above"))) Goal_Amount, concat(round((count(projectid)/(select count(projectid) from projects where state="successful")*100),2),"%") Total_projects from projects where state="sucessful" group by goal_amount; 

SELECT 
    CASE 
        WHEN goal > 0 AND goal <= 10000 THEN '0-10K'
        WHEN goal > 10000 AND goal <= 50000 THEN '10-50K'
        WHEN goal > 50000 AND goal <= 100000 THEN '50-100K'
        ELSE '100K Above'
    END AS Goal_Range,
    concat(round(COUNT(ProjectID)/( select COUNT(ProjectID) from projects where state="successful")*100),"%")  AS Total_Projects
FROM 
    projects where state="successful"
GROUP BY 
    Goal_Range;

