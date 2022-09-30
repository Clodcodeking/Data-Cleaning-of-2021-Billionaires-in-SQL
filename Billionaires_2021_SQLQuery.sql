/*
Cleaning Data and Data Exploration in SQL Queries
*/


select *
from Billionaire$
--------------------------------------------------------------------------------------------------------------------------

-- Trim B and $ from the Networth column and update the table

select *, Cast(TRIM('B$' FROM Networth) as float) as Networth_
from Billionaire$


-- Create a new table with the newly introduced column

DROP TABLE if exists Billionaire
CREATE Table Billionaire
(name nvarchar(255), 
NetWorth float,
Country nvarchar(255), 
Source nvarchar(255),
Rank numeric,
Age numeric,
Industry nvarchar(255)
)

insert into Billionaire
select Name, Cast(TRIM('B$' FROM Networth) as float) as Networth_, Country, Source, Rank, Age, Industry
from Billionaire$

-- View new table
select *
from Billionaire
 --------------------------------------------------------------------------------------------------------------------------
 /* data exploration */
 
select distinct Industry, SUM(NetWorth) as SUM_per_Industry, count(*) as Billionaires
from Billionaire
group by Industry
order by Billionaires desc

-- Totol number of Billionaires in 2021 and their summed up networth
select Count(*) as Billionaires, Sum(networth) Total_Networth
from Billionaire

-- Let's calculate the percentage of billions in each and every industry

Select distinct Industry, Round((Cast(count(*) as float)/
(
select Cast(count(*) as float)
from Billionaire
) 
) * 100, 0) as Percentages, Round(sum(networth), 0) as Total_sum, count(*) as Billionaires

from Billionaire
group by Industry
order by Percentages desc
-- The RESULTS tells us that there is 13% of billionaires in Finance & Investments 

--------------------------------------------------------------------------------------------------------------------------

-- Let's find out many billionaries are below the age of 40
Select *
from Billionaire
where age < 40 
order by NetWorth desc
-- There is total of number of 106 billionaires below the age of 40

-- Networth Vs Age distributions

Select Networth, Age
from Billionaire
order by NetWorth
-- The data is well visualized on a scatter plot

--------------------------------------------------------------------------------------------------------------------------

--Let's group the number of billionaires according to the age IN A TABLE

Select
(
select count(*)
from Billionaire
where age <20
) as Below_20s, 
(
select count(*)
from Billionaire
where age between 20 and 29
) as '20s',
(
select count(*)
from Billionaire
where age between 30 and 39
) as '30s',
(
select count(*)
from Billionaire
where age between 40 and 49
) as '40s',
(
select count(*)
from Billionaire
where age between 50 and 59
) as '50s',
(
select count(*)
from Billionaire
where age between 60 and 69
) as '60s',
(
select count(*)
from Billionaire
where age between 70 and 79
) as '70s',
(
select count(*)
from Billionaire
where age >79
) as '80s_and_above', Count(*) as Total

from Billionaire 

---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From Billionaire

ALTER TABLE Billionaire
DROP COLUMN Source

-- Let's check it has been 
select *
from Billionaire

-- Billionaires by country 

Select distinct Country, Round(Sum(networth), 0) as TOTAL, Count(*) as Billionaires
from Billionaire
group by Country 
order by Billionaires desc