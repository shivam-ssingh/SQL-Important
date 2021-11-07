--Dummy data
Create table Employees
(
     ID int primary key identity,
     FirstName nvarchar(50),
     LastName nvarchar(50),
     Gender nvarchar(50),
     Salary int
)
GO

Insert into Employees values ('Ben', 'Hoskins', 'Male', 70000)
Insert into Employees values ('Mark', 'Hastings', 'Male', 60000)
Insert into Employees values ('Steve', 'Pound', 'Male', 45000)
Insert into Employees values ('Shivam', 'Singh', 'Male', 70000)
Insert into Employees values ('Philip', 'Hastings', 'Male', 45000)
Insert into Employees values ('Mary', 'Lambeth', 'Female', 30000)
Insert into Employees values ('Valarie', 'Vikings', 'Female', 35000)
Insert into Employees values ('John', 'Stanmore', 'Male', 80000)
GO

--Table Structure
--ID	FirstName	LastName	Gender	Salary
--1	Ben	Hoskins	Male	70000
--2	Mark	Hastings	Male	60000
--3	Steve	Pound	Male	45000
--4	Ben	Hoskins	Male	70000
--5	Philip	Hastings	Male	45000
--6	Mary	Lambeth	Female	30000
--7	Valarie	Vikings	Female	35000
--8	John	Stanmore	Male	80000



--Solution

with cte_Rank
as (
SELECT FirstName, LastName, Salary, DENSE_RANK() OVER (Order By Salary desc) as [Rank]
from Employees)
select *
from cte_Rank where [RANK] = 2