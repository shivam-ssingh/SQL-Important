Create table Employees
(
     EmployeeID int primary key identity,
     EmployeeName nvarchar(50),
     ManagerID int foreign key references Employees(EmployeeID)
)
GO

Insert into Employees values ('John', NULL)
Insert into Employees values ('Mark', NULL)
Insert into Employees values ('Steve', NULL)
Insert into Employees values ('Tom', NULL)
Insert into Employees values ('Lara', NULL)
Insert into Employees values ('Simon', NULL)
Insert into Employees values ('David', NULL)
Insert into Employees values ('Ben', NULL)
Insert into Employees values ('Stacy', NULL)
Insert into Employees values ('Sam', NULL)
GO

Update Employees Set ManagerID = 8 Where EmployeeName IN ('Mark', 'Steve', 'Lara')
Update Employees Set ManagerID = 2 Where EmployeeName IN ('Stacy', 'Simon')
Update Employees Set ManagerID = 3 Where EmployeeName IN ('Tom')
Update Employees Set ManagerID = 5 Where EmployeeName IN ('John', 'Sam')
Update Employees Set ManagerID = 4 Where EmployeeName IN ('David')
GO
--TABLE STRUCTURE
--EmployeeID	EmployeeName	ManagerID
--1	John	5
--2	Mark	8
--3	Steve	8
--4	Tom	3
--5	Lara	8
--6	Simon	2
--7	David	4
--8	Ben	NULL
--9	Stacy	2
--10	Sam	5



CREATE PROCEDURE USP_EMPLOYEEHIERARCHY
@Employeeid int
as
BEGIN
with EmployeesCTE
as 
(
	select EMPLOYEEID, EMPLOYEENAME, MANAGERID
	FROM Employees
	WHERE EmployeeID = @Employeeid

	UNION ALL

	SELECT e.EmployeeID,  e.EmployeeName as EmployeeName , e.ManagerID
	FROM Employees e
	JOIN EmployeesCTE m
	ON e.EmployeeID = m.ManagerID
)
select  e.EmployeeName as EmployeeName, ISNULL(m.EmployeeName,'SUPERBOSS') as ManagerName
from EmployeesCTE e
left join EmployeesCTE m
on e.ManagerID = m.EmployeeID
END

--EXAMPLE 
--EXEC USP_EMPLOYEEHIERARCHY 7
--EmployeeName	ManagerName
--David	Tom
--Tom	Steve
--Steve	Ben
--Ben	SUPERBOSS