CREATE TABLE Customers(
ID INT NOT NULL PRIMARY KEY,
Gender VARCHAR(20),
FirstName VARCHAR(50),
LastName VARCHAR(50),
EyeColor VARCHAR(20),
IDNumber VARCHAR(20),
MotherIDNumber VARCHAR(20),
FatherIDNumber VARCHAR(20)
);

CREATE TABLE Address(
ID INT NOT NULL PRIMARY KEY,
Country VARCHAR(50),
City VARCHAR(50)
);

CREATE TABLE Sales(
ID INT NOT NULL PRIMARY KEY,
CustomerID INT,
CityID INT,
Amount DECIMAL(10,2),
FOREIGN KEY (CustomerID) REFERENCES Customers(ID),
FOREIGN KEY (CityID) REFERENCES Address(ID)
);

SELECT * FROM Customers;
SELECT * FROM Address;
SELECT * FROM Sales;

--1. Write SQL statement select to display customer Full Name in one column, their City and Amount of sales. 
--We need data only for customers whose mother has brown eyes.
SELECT CONCAT(c.FirstName,' ',c.Lastname) as FullName, City, Amount
FROM Customers c JOIN Sales s ON c.ID=s.CustomerID
JOIN Address a ON s.CityID=a.ID 
JOIN Customers m ON c.MotherIDNumber = m.IDNumber 
WHERE c.MotherIDNumber is not null and m.EyeColor='Brown'
ORDER BY Amount DESC;

--2. Write SQL statement select to display First Name and Last Name of users which ordered 3 and more courses. Use tables from below.
CREATE TABLE Course(
ID INT PRIMARY KEY,
Name VARCHAR(50)
);

CREATE TABLE Users(
ID INT PRIMARY KEY,
FirstName VARCHAR(50),
LastName VARCHAR(50)
);

CREATE TABLE UOrder(
ID INT PRIMARY KEY,
UserID INT,
CourseID INT,
FOREIGN KEY (UserID) REFERENCES Users(ID),
FOREIGN KEY (CourseID) REFERENCES Course(ID)
);

SELECT * FROM Course;
SELECT * FROM Users;
SELECT * FROM UOrder;

--Solution:
SELECT u.FirstName,u.LastName
FROM Users u
JOIN UOrder o ON u.ID=o.UserID
GROUP BY u.FirstName,u.LastName
HAVING COUNT(o.CourseID)>=3;

--3.What will be the output of the below:
--Answer: Amount 1000.00

CREATE TABLE Clients(
ID INT PRIMARY KEY,
Name VARCHAR(50),
Age INT
);

CREATE TABLE Payments(
ID INT PRIMARY KEY,
DueDate DATE,
Amount DECIMAL(10,2),
ClientId INT,
FOREIGN KEY (ClientId) REFERENCES Clients(ID)
);

CREATE TABLE CAddress(
ID INT PRIMARY KEY,
Line1 VARCHAR(100),
City VARCHAR(50),
IsPrimary BIT,
ClientId INT,
FOREIGN KEY (ClientId) REFERENCES Clients(ID)
);

SELECT * FROM Clients;
SELECT * FROM Payments;
SELECT * FROM CAddress;

SELECT
SUM(p.Amount) AS Amount
FROM
Payments p
INNER JOIN Clients c ON p.ClientId = c.Id
INNER JOIN CAddress a ON c.Id = a.ClientId
WHERE
c.Name LIKE '%iro'



