create database classicmodels;
use classicmodels;
show tables;


-- ASSIGNMENT QUESTION 1(A)
select employeeNumber,firstname,lastname from employees where jobTitle="Sales Rep" and reportsTo=1102;
-- ASSIGNMENT QUESTION 1(B)
SELECT DISTINCT productLine FROM products WHERE productLine LIKE '%cars';


-- ASSIGNMENT QUESTION 2
SELECT customerNumber, customerName,
       CASE 
           WHEN country IN ('USA', 'Canada') THEN 'North America'
           WHEN country IN ('UK', 'France', 'Germany') THEN 'Europe'
           ELSE 'Other'
       END AS CustomerSegment
FROM customers;


-- ASSIGNMENT QUESTION 3(A)
SELECT productCode, SUM(quantityOrdered) AS total_quantity FROM orderdetails 
GROUP BY productCode ORDER BY total_quantity DESC LIMIT 10;
-- ASSIGNMENT QUESTION 3(B)
SELECT MONTHNAME(paymentDate) AS Payment_Month, COUNT(*) AS num_payments 
FROM payments GROUP BY Payment_Month HAVING num_payments > 20 ORDER BY num_payments DESC;


-- ASSIGNMENT QUESTION 4(A)
create database customers_orders;
use customers_orders;
create table customers(customer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,last_name VARCHAR(50) NOT NULL,
    email VARCHAR(255) UNIQUE,phone_number VARCHAR(20));
    select * from customers;
-- ASSIGNMENT QUESTION 4(B)
create table orders(order_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,order_date DATE,total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    CONSTRAINT chk_total_amount CHECK (total_amount > 0));
    select * from orders;
    
    
-- ASSIGNMENT QUESTION 5
use classicmodels;
SELECT c.country, COUNT(o.orderNumber) AS order_count 
FROM Customers c JOIN Orders o ON c.customerNumber = o.customerNumber 
GROUP BY c.country ORDER BY order_count DESC LIMIT 5;


-- ASSIGNMENT QUESTION 6
create table project(EmployeeID Int primary key auto_increment, FullName varchar(50) not null,
 Gender enum("Male","Female"),ManagerID Int);
 desc project;
 insert into project values(1,"Pranaya","Male",3),(2,"Priyanka","Female",1),(3,"Preety","Female",NULL),
 (4,"Anurag","Male",1),(5,"Sambit","Male",1),(6,"Rajesh","Male",3),(7,"Hina","Female",3);
select * from project;
select mgr.FullName as ManagerName,emp.FullName as EmpName from project as emp
inner join project as mgr on emp.ManagerID=mgr.EmployeeID;


-- ASSIGNMENT QUESTION 7
create table facility(Facility_ID int,Name varchar(100),State varchar(100),Country varchar(100));
desc facility;
alter table facility modify column Facility_ID int primary key auto_increment;
alter table facility add column(City varchar(100) not null);
desc facility;


-- ASSIGNMENT QUESTION 8
create view Product_Category_Sales as
SELECT pl.productLine,SUM(od.quantityOrdered * od.priceEach) AS total_sales,
COUNT(DISTINCT o.orderNumber) AS number_of_orders
FROM productlines pl JOIN products p ON pl.productLine = p.productLine
JOIN orderdetails od ON p.productCode = od.productCode JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY pl.productLine;
select * from Product_Category_Sales;


-- ASSIGNMENT QUESTION 9
DELIMITER $$
CREATE PROCEDURE Get_country_payments(
    IN input_year INT, IN input_country VARCHAR(50))
BEGIN
    SELECT YEAR(p.paymentDate) AS `Year`,
        c.country AS `Country`, CONCAT(ROUND(SUM(p.amount) / 1000, 0), 'K') AS `Total_amount`
    FROM payments AS p INNER JOIN customers AS c ON p.customerNumber = c.customerNumber
    WHERE YEAR(p.paymentDate) = input_year AND c.country = input_country
    GROUP BY `Year`, `Country`;
END $$
DELIMITER ;
call Get_country_payments(2003,"France");


-- ASSIGNMENT QUESTION 10(A)
SELECT CS.CustomerName as CustomerName, count(OD.OrderNumber) as Order_Count,
dense_rank() over(order by count(OD.OrderNumber)desc) as Order_Frequency_rnk from customers as CS
join orders as OD on OD.customerNumber=CS.CustomerNumber group by CS.CustomerName;
-- ASSIGNMENT QUESTION 10(B)
SELECT YEAR(OrderDate) AS Year,MONTHNAME(OrderDate) AS Month,COUNT(OrderDate) AS Total_Sales,
CONCAT(ROUND(((COUNT(OrderDate) -LAG(COUNT(OrderDate), 1) OVER())/Lag(count(OrderDate),1) 
over())*100),"%") as "% YOY Change" from orders group by Year,Month;


-- ASSIGNMENT QUESTION 11
select productline, count(*) as total from products
where buyprice> (select avg(buyprice) from products) 
group by productline order by total desc;


-- ASSIGNMENT QUESTION 12
CREATE TABLE Emp_EH (EmpID INT PRIMARY KEY,EmpName VARCHAR(100),EmailAddress VARCHAR(100));
DELIMITER $$
CREATE PROCEDURE Emp_EH(IN EmpID INT,IN EmpName VARCHAR(100),IN EmailAddress VARCHAR(100))
BEGIN
-- Exception handler for any SQL error
DECLARE EXIT HANDLER FOR SQLEXCEPTION
BEGIN
SELECT 'Error occurred' AS Message;
END;
-- Insert employee details
INSERT INTO Emp_EH (EmpID,EmpName,EmailAddress)VALUES (EmpID,EmpName,EmailAddress);
-- Success message
SELECT 'Employee inserted successfully' AS Message;
END $$
DELIMITER ;


-- ASSIGNMENT QUESTION 13 
CREATE TABLE Emp_BIT (Name VARCHAR(50),Occupation VARCHAR(50),Working_date DATE,Working_hours INT);
INSERT INTO Emp_BIT VALUES
('Robin', 'Scientist', '2020-10-04', 12),
('Warner', 'Engineer', '2020-10-04', 10),
('Peter', 'Actor', '2020-10-04', 13),
('Marco', 'Doctor', '2020-10-04', 14),
('Brayden', 'Teacher', '2020-10-04', 12),
('Antonio', 'Business', '2020-10-04', 11);
DELIMITER $$
CREATE TRIGGER before_insert_emp_bit
BEFORE INSERT ON Emp_BIT FOR EACH ROW
BEGIN
IF NEW.Working_hours < 0 THEN
SET NEW.Working_hours = ABS(NEW.Working_hours);
END IF;
END $$
DELIMITER ;
insert into emp_bit values('Akarsh','Data Analyst','2020-10-04',-8);
select * from emp_bit;