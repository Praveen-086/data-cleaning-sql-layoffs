# Data cleaning for eda project 

--  1. Remove duplicates
--  2. Standardize the data
--  3. Remove Null values and Blank Values
--  4. Remove any coulumns

create table layoffs_group
like layoffs;

select * from
layoffs_group;

insert layoffs_group
select * from 
layoffs;

select * from
layoffs_group;


with duplicate_cte as
(
select * ,
row_number() over(
partition by company, location , total_laid_off, 
percentage_laid_off, `date`,stage,country,
funds_raised_millions)
as row_num 
from layoffs_group
)
select * 
from duplicate_cte
where row_num > 1;

select * 
from layoffs_group
where company = 'casper';


with duplicate_cte as
(
select * ,
row_number() over(
partition by company, location , total_laid_off, 
percentage_laid_off, `date`,stage,country,
funds_raised_millions)
as row_num 
from layoffs_group
)
delete					#it will through error cuz it cannot 
from duplicate_cte
where row_num > 1;

select * ,
row_number() over(
partition by company, location , total_laid_off, 
percentage_laid_off, `date`,stage,country,
funds_raised_millions)
as row_num 
from layoffs_group;

#for this select schema - world_layoffs - layoffs_group_2 - right click - copy to clipboard - create statement and it will copy automaticall and paste it where you want 
CREATE TABLE `layoffs_group_2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from
layoffs_group_2;

insert into layoffs_group_2
select *,
row_number() over(
partition by company, location , total_laid_off, 
percentage_laid_off, `date`,stage,country,
funds_raised_millions)
as row_num_ 
from layoffs_group;

select * from
layoffs_group_2;

select * from
layoffs_group_2
where row_num_ > 1;


delete
from
layoffs_group_2
where row_num_ > 1;

select * from
layoffs_group_2
where row_num_ > 1;

select * from
layoffs_group_2;



#standardizing data

select company , trim(company)
from 
layoffs_group_2;

update layoffs_group_2
set company = trim(company);

select * from layoffs_group_2;   #trim has been updated to the actual table layoffs_group_2

select distinct industry 
from layoffs_group_2;

select distinct industry 
from layoffs_group_2
order by 1;

select *
from layoffs_group_2
where industry like 'crypto%';


update layoffs_group_2
set industry = 'Crypto'
where industry like 'Crypto%';

select *
from layoffs_group_2
where industry like 'crypto%';

select distinct industry
from layoffs_group_2;

select * from
layoffs_group_2;

select distinct location 
from layoffs_group_2;

select distinct location 
from layoffs_group_2
order by 1;

select distinct country 
from layoffs_group_2
order by 1;

select * 
from layoffs_group_2
where country like 'United states%'
order by 1;

select distinct country, trim(country)
from layoffs_group_2
order by 1;


select distinct country, trim(trailing '.' from country)  # it was one of the advanced type of removing or trim
from layoffs_group_2
order by 1;

update layoffs_group_2
set country = trim(trailing '.' from country)
where country like 'United states%';

select distinct country, trim(country)
from layoffs_group_2
order by 1;            #the dot in the united states. were removed and it appears in one row not two us & us.

select * from 
layoffs_group_2;

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoffs_group_2;

update layoffs_group_2
set `date` = str_to_date(`date`, '%m/%d/%Y');


select * from
layoffs_group_2;

select `date`
from layoffs_group_2;

alter table layoffs_group_2
modify column `date` date;		 # it will change or modify the data type of a column , do this only on another table not the raw table

select * from
layoffs_group_2;

select * from
layoffs_group_2
where total_laid_off is null
and percentage_laid_off is null;


select * from
layoffs_group_2
where industry is null
or industry = '';

select * from
layoffs_group_2
where company = 'Airbnb';

select * from
layoffs_group_2 as t1
join layoffs_group_2 as t2
	on t1.company = t2.company
where ( t1.industry is null or t1.industry = '')
and t2.industry is not null;

select t1.industry , t2.industry
from
layoffs_group_2 as t1
join layoffs_group_2 as t2
	on t1.company = t2.company
where ( t1.industry is null or t1.industry = '')
and t2.industry is not null; 


update layoffs_group_2
set industry = null
where industry = '';

update layoffs_group_2 as t1
join layoffs_group_2 as t2 
	on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null 
and t2.industry is not null; 

select * from
layoffs_group_2
where company = 'Airbnb';


select * from
layoffs_group_2
where industry is null
or industry = '';

select * from
layoffs_group_2
where company like 'Bally%';


select * from
layoffs_group_2
where total_laid_off is null
and percentage_laid_off is null;


delete 
from
layoffs_group_2
where total_laid_off is null
and percentage_laid_off is null;

select * from
layoffs_group_2;


alter table layoffs_group_2
drop column row_num_;

select * from
layoffs_group_2;



