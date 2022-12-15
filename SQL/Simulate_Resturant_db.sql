-- Simulate Resturant database
-- 5 table
-- 1fact,4 dimension
-- Practice sql by
-- write SQL 3-5 Queries analyze data
-- 1 sub queries / with clause


-- Create Fact Table -- 
CREATE TABLE orders ( 
  orderId numeric NOT NULL,
  customerId CHAR(5),
  menuId numeric,
  EmployeeId CHAR(5),
  Date date,
  OrderingTime time,
  DeliverTime time,
  satisficationScore real,
  FOREIGN KEY (customerId) REFERENCES customer(customerId),
  FOREIGN KEY (menuId) REFERENCES menu(menuId),
  FOREIGN KEY (EmployeeId) REFERENCES employee(employeeId)
  );

INSERT INTO orders values 
  ('1','00001','F01','00001','2022-08-28','11:30','12:05',7.5),
  ('2','00002','F03','00006','2022-08-28','11:35','12:00',8),
  ('3','00003','F02','00001','2022-08-28','12:15','12:40',8.25),
  ('4','00005','F02','00006','2022-08-28','11:00','12:13',7),
  ('5','00005','F01','00001','2022-08-28','11:45','12:30',6.5),
  ('6','00005','D01','00006','2022-08-28','08:30','08:40',9),
  ('7','00005','D01','00003','2022-08-28','07:50','08:00',9),
  ('8','00005','D01','00001','2022-08-28','09:10','09:20',9),
  ('9','00005','D01','00006','2022-08-28','11:05','11:30',8),
  ('10','00005','S01','00002','2022-08-28','18:00','18:13',9.5),
  ('11','00005','S01','00002','2022-08-28','18:00','18:13',9.6),
  ('12','00005','S01','00005','2022-08-28','18:00','18:13',9),
  ('13','00005','S02','00005','2022-08-28','18:00','19:13',9),
  ('14','00005','S02','00005','2022-08-28','19:00','19:13',7.5),
  ('15','00004','S03','00005','2022-08-28','19:00','19:13',8.5),
  ('16','00003','S01','00005','2022-08-28','19:00','19:13',9.8),
  ('17','00004','S01','00005','2022-08-28','20:00','21:13',9.8),
  ('18','00003','S01','00005','2022-08-28','21:00','21:13',9.9),
  ('19','00004','S01','00005','2022-08-28','21:00','22:13',9.9),
  ('20','00003','S03','00002','2022-08-28','22:00','22:13',10);
-- Create Dimension table #1 customer 
CREATE TABLE customer (
  customerId CHAR(5),
  customerName VARCHAR,
  customerAddress  VARCHAR,
  sex_male BOOLEAN,
  PRIMARY KEY (customerID)
);

INSERT INTO customer values 
  ('00001','Addy','Chonburi',TRUE),
  ('00002','Tommy','Pattaya',TRUE),
  ('00003','Lucas','Sriracha',TRUE),
  ('00004','Brian','Bangsaen',TRUE),
  ('00005','Salah','Rayong',FALSE),
  ('00006','Susie','BKK',FALSE)
   ;
-- Create Dimension table #2 menu
CREATE TABLE menu (
  menuId char(3) not null,
  menuName VARCHAR,
  type VARCHAR,
  ingredientId CHAR(3),
  Price REAL,
  PRIMARY KEY (menuId)
);

INSERT INTO menu values
  ('F01','Tom-yam-kung',null,'I01',120.5),
  ('F02','Pad-Thai',null,'I02',70),
  ('F03','Som-tum',null,'I03',65),
  ('D01','Coffee',null,'I04',80),
  ('D02','Orange Juice',null,'I05',70),
  ('S01','Sushi',null,'I06',100),
  ('S02','Ramen',null,'I07',125),
  ('S03',' Suki',null,'I08',299),
  ('S04','Checken fried',null,'I09',199);

UPDATE menu 
SET  type =
  CASE WHEN menuId LIKE 'F%' THEN 'Food'
    WHEN menuId LIKE 'D%' THEN 'Drink'
  ELSE 'Special' END;

-- Create Dimension table #3 employee
CREATE TABLE employee  (
  employeeId char(5) not null,
  employeeName VARCHAR,
  type VARCHAR,
  Birthday Date,
  shift VARCHAR,
  PRIMARY KEY (employeeId),
  FOREIGN KEY (shift) REFERENCES shift(shift));

INSERT INTO employee VALUES 
  ('00001','Simon','Permanent','1990-05-13','1'),
  ('00002','Dealil','Permanent','1984-01-29','2'),
  ('00003','Ruby','Parttime','1998-08-21','3'),
  ('00004','Ellie','Permanent','1997-04-15','3'),
  ('00005','John','Permanent','1980-04-15','2'),
  ('00006','Eddie','Parttime','1996-03-20','1');


-- Create Dimension table #4 shift
CREATE TABLE shift (
  shift varchar,
  timeFrom time,
  timeTo time,
  PRIMARY KEY (shift)
);

INSERT INTO shift VALUES 
  ('1','08:00','16:00'),
  ('2','16:00','24:00'),
  ('3','24:00','08:00');


-- Show result


.mode markdown
.head on 
-- 1. What are top 3 best seller 
SELECT 
  m.menuName Name,
  count(*)
FROM orders o
JOIN menu m
  ON o.menuId = m.menuId
GROUP BY m.menuName
ORDER BY count(*) desc
LIMIT 3;

-- 2.Who the oldest employer and what customer He/She take care.
WITH employeeAge as (
  SELECT 
    employeeId Id,
    employeeName Name,
    cast(strftime('%Y.%m%d','now') - strftime('%Y.%m%d',Birthday) as INT) age
  FROM employee

)

-- Select * from employeeAge;

SELECT 
  o.EmployeeId,
  e.employeeName,
  o.customerId,
  c.customerName
FROM orders o 
JOIN customer c 
  ON o.customerId = c.customerId
JOIN employee e 
  ON o.employeeId = e.employeeId
JOIN employeeAge em 
  ON e.employeeId = em.Id
WHERE em.age IN (
      SELECT MAX(age)
      FROM employeeAge
);

-- How long we prepare the order ?

SELECT 
  orderId,
  ((STRFTIME('%s',DeliverTime) 
  - STRFTIME('%s',OrderingTime))/60.0) Duration,
  
  CASE WHEN ((STRFTIME('%s',DeliverTime) - 
            STRFTIME('%s',OrderingTime))/60.0) < 15   THEN "Fast"
    ELSE "Slow" End as Type
FROM orders ;

  
