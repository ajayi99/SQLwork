
CREATE DATABASE Work

USE Work
GO

CREATE TABLE Employee (
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_day DATE, 
sex VARCHAR(1),
salary INT,
super_id INT,
branch_id INT
);

CREATE TABLE Branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
mgr_id INT,
mgr_start_date DATE,
FOREIGN KEY(mgr_id) REFERENCES Employee(emp_id) ON DELETE SET NULL -- this converts the foreign key to null when it is removed in the parent table
);

ALTER TABLE Employee
ADD FOREIGN KEY(branch_id)
REFERENCES branch(branch_id)
ON DELETE SET NULL;

ALTER TABLE Employee
ADD FOREIGN KEY(super_id)
REFERENCES employee(emp_id)
ON DELETE SET NULL;

CREATE TABLE client(
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL
);

CREATE TABLE works_with(
emp_id INT,
client_id INT,
total_sales INT,
PRIMARY KEY(emp_id, client_id),
FOREIGN KEY(emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
FOREIGN KEY(client_id) REFERENCES client(client_id)ON DELETE CASCADE,-- when a row in the parent table is deleted the row in the child table will be deleted
);

CREATE TABLE branch_supplier(
branch_id INT,
supplier_name VARCHAR(40),
supply_type VARCHAR(40),
PRIMARY KEY(branch_id, supplier_name),
FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE -- USED CASCADE AS THE BRANCH ID IS A PRIMARY KEY IN THIS TABLE BUT IT ALSO A FORIEGN KEY AS IT USES THE ID FROM THE BRANCH TABLE
);



INSERT INTO Employee VALUES(100, 'David','Wallace','1967-11-17','M','250000',NULL,NULL);

INSERT INTO Branch VALUES(1, 'Corporate',100,'2006-02-09');

UPDATE Employee
SET branch_id = 1
WHERE emp_id =100

INSERT INTO Employee VALUES(101, 'Jan','Levinson','1961-05-11','F',110000,100,1);

INSERT INTO Employee VALUES(102, 'Michael', 'Scott','1964-03-15','M',75000,NULL,NULL);
INSERT INTO Branch VALUES(2,'Scranton',102,'1992-04-06');
UPDATE Employee
SET branch_id = 2
WHERE emp_id=102

INSERT INTO Employee VALUES(103,'Angela','Martin','1971-06-25','F',63000,102,2);
INSERT INTO Employee VALUES(104,'Kelly','Kapoor','1980-02-05','F',55000,102,2);
INSERT INTO Employee VALUES(105,'Stanley','Hudson','1958-02-19','m',69000,102,2);

INSERT INTO Employee VALUES(106,'Josh','Porter','1969-09-05','M',78000,100,NULL);
INSERT INTO Branch VALUES(3,'Stamford',106,'1998-02-13');

INSERT INTO Employee VALUES(107,'Andy','Bernard','1973-07-22','M',65000,106,3);
INSERT INTO Employee VALUES(108,'Jim','Halpert','1978-10-01','M',71000,106,3);

INSERT INTO branch_supplier VALUES(2,'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(2,'Uni-ball', 'Writing Utensils');
INSERT INTO branch_supplier VALUES(3,'Patriot Paper','Paper');
INSERT INTO branch_supplier VALUES(2, 'J.T. Forms & Labels','Customs Forms');
INSERT INTO branch_supplier VALUES(3,'Uni-ball','Writing Utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill','Paper');
INSERT INTO branch_supplier VALUES(3,'Stamford Labels','Custom Forms');

INSERT INTO client VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO client VALUES(401, 'Lackawana Country',2);
INSERT INTO client VALUES(402, 'FedEx',3);
INSERT INTO client VALUES(403, 'John Daly Law, LLC', 3)
INSERT INTO client VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO client VALUES(405, 'Times Newspaper', 3);
INSERT INTO client VALUES(406, 'FedEx', 2);


INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 267000);
INSERT INTO works_with VALUES(108, 402, 25500);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(108, 403, 12000);
INSERT INTO works_with VALUES(105, 404, 33000);
INSERT INTO works_with VALUES(107, 405, 26000);
INSERT INTO works_with VALUES(102, 406, 15000);
INSERT INTO works_with VALUES(105, 406, 130000);



-- FIND ALL CLIENTS
SELECT * 
FROM client

-- FIND ALL EMPLOYEES ORDERED BY SALARY
SELECT *
FROM Employee
ORDER BY salary DESC;

-- FIND ALL EMPLOYEES ORDERED BY SEX THEN NAME
SELECT * 
FROM Employee
ORDER BY sex, first_name, last_name;

-- FIND THE FIRST 5 EMPLOYEES IN THE TABLE
SELECT 
TOP 5 * 
FROM Employee

-- FIND THE FIRST AND LAST NAMES OF ALL EMPLOYEES
SELECT first_name, last_name
FROM Employee

-- FIND THE FORENAME AND SURNAMES OF ALL EMPLOYEES
SELECT first_name AS forename, last_name AS surname
FROM Employee

-- FIND OUT ALL THE DIFFERENT GENDERS
SELECT DISTINCT sex
FROM Employee

-- FIND THE NUMBER OF EMPLOYEES
SELECT COUNT(emp_id)
FROM Employee

-- FIND THE NUMBER OF FEMALE EMPLOYEES BORN AFTER 1970
SELECT COUNT(emp_id)
FROM Employee
WHERE sex ='F' AND birth_day > '1970-01-01'

-- FIND THE AVERAGE OF ALL EMPLOYEES SALARIES
SELECT AVG(salary)
FROM Employee
WHERE sex ='M'

-- FIND THE SUM OF ALL EMPLOYEE SALARIES
SELECT SUM(salary)
FROM Employee

-- FIND OUT HOW MANY MALES AND FEMALES THERE ARE
SELECT COUNT(sex), sex 
FROM Employee
GROUP BY sex

--FIND THE TOTAL SALES OF EACH SALESMAN
SELECT SUM(total_Sales), emp_id
FROM works_with
GROUP BY emp_id

--FIND OUT HOW MUCH EACH CLIENT SPENT
SELECT SUM(total_Sales), client_id
FROM works_with
GROUP BY client_id

--WILDCARDS
SELECT *
FROM client
WHERE client_name LIKE '%LLC'; --% STANDS FOR ANY NUMBER OF CHARACTERS BEFORE THE PERCENT SIGN 

--FIND ANY BRANCH SUPPLIERS WHO AREIN THE LABEL BUSINESS 

SELECT *
FROM branch_supplier
WHERE supplier_name LIKE '%Label%'

--FIND ANY EMPLOYEE BORN IN OCTOBER
SELECT *
FROM Employee
WHERE birth_day LIKE '____-10%' -- THE UNDERSCORE STANDS FOR ONE CHARACTER


--FIND ANY CLIENTS WHO ARE SCHOOLS
SELECT *
FROM client
WHERE client_name LIKE '%school%' 


--FIND A LIST OF EMPLOYEE AND BRANCH NAMES
SELECT first_name -- TO DO UNIONS YOU MUST HAVE THE SAME NUMBER COLUMNS IN THE SELECT STATEMENT
FROM Employee	-- THERE ALSO HAVE TO HAVE A SIMILAR DATA TYPE
UNION
SELECT branch_name
FROM Branch
UNION
SELECT client_name
FROM client


-- FINA A LIST OF ALL CLIENTS AND BRANCH SUPPLIERS' NAME
SELECT client_name, branch_id
FROM client
UNION 
SELECT supplier_name, branch_id
FROM branch_supplier;

--FIND A LIST OF ALL MONEY SPENT OR EARNED BY THE COMPANY
SELECT salary
FROM Employee
UNION
SELECT total_sales
FROM works_with

-- FIND ALL BRANCHES AND THE NAMES OF THEIR MANAGERS
SELECT Employee.emp_id, Employee.first_name,Branch.branch_name 
FROM Employee
JOIN Branch
ON Employee.emp_id= Branch.mgr_id; -- A JOIN IS USED TO COMBINE ROWS FROM 2 OR MORE TABLES BASED ON THE RELATED COLUMN ON INDICATES THE COLUMN THAT ARE COMMON


-- LEFT JOIN EXAMPLE
SELECT Employee.emp_id, Employee.first_name,Branch.branch_name 
FROM Employee
LEFT JOIN Branch
ON Employee.emp_id= Branch.mgr_id; -- WITH A LEFT JOIN WE INCLUDE ALLL THE ROWS FROM THE LEFT TABLE- WHICH IS THE TABLE IN THE FROM CLAUSE


-- RIGHT JOIN EXAMPLE
SELECT Employee.emp_id, Employee.first_name,Branch.branch_name 
FROM Employee
RIGHT JOIN Branch
ON Employee.emp_id= Branch.mgr_id; -- THIS DOES THE OPPOSITE OF THE LEFT JOIN

-- FULL OUTER JOIN EXAMPLE
SELECT Employee.emp_id, Employee.first_name,Branch.branch_name 
FROM Employee
FULL OUTER JOIN Branch
ON Employee.emp_id= Branch.mgr_id; -- COMBINES BOTH RESUTLS FROM THE LEFT JOIN AND THE RIGHT JOIN


-- FIND NAMES OF ALL EMPLOYEES WHO HAVE SOLD OVER 30,000 TO A SINGLE CLIENT NESTED QUERY
SELECT Employee.first_name, Employee.last_name
FROM Employee
WHERE Employee.emp_id IN(

	SELECT works_with.emp_id
	FROM works_with
	WHERE works_with.total_sales > 30000
);

-- FIND ALL CLIENTS WHO ARE HANDLED BY THE BRANCH
-- THAT MICHAEL SCOTT MANAGES
--ASSUME YOU KNOW MICHAELS ID
SELECT client.client_name
FROM client
WHERE client.branch_id =(
	SELECT Branch.branch_id
	FROM BRANCH
	WHERE Branch.mgr_id = 102
	
);

