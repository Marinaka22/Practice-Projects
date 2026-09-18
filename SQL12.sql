CREATE TABLE IF NOT EXISTS Product(
	id INTEGER Primary Key Autoincrement,
	P_Code VARCHAR(100),
	P_Name VARCHAR(100),
	Price INTEGER,
	Stock INTEGER,
	Category VARCHAR(100)
	)
	
CREATE TABLE IF NOT EXISTS Customers(
	C_Id INTEGER Primary Key Autoincrement,
	C_Name VARCHAR(100),
	C_Location VARCHAR(100),
	C_Phoneno VARCHAR(20)
	)
	
CREATE TABLE IF NOT EXISTS Sales(
	C_id INTEGER Primary Key Autoincrement,
	Order_date  DATE,
	Order_no VARCHAR(100),
	S_code VARCHAR(100) REFERENCES Product(P_Code),
	P_name VARCHAR(100),
	Qty INTEGER,
	Price INTEGER
	)
	
INSERT INTO Product(P_Code, P_Name, Price, Stock, Category)
Values (1, 'tulip',	198, 5,	'perfume'),
	   (2,	'cornoto', 50, 21, 'icecream'),
	   (3,	'Pen', 10, 52, 'Stationary'),
	   (4,	'Lays',	10,	20,	'snacks'),
	   (5,	'mayanoise', 90, 10, 'dip'),
	   (6,	'jam', 105,	10,	'spread'),
	   (7,	'shampoo', 5, 90, 'hair product'),
	   (8,	'axe', 210, 4, 'perfume'),
	   (9,	'park avenue', 901, 2, 'perfume'),
	   (10,	'wattagirl', 201, 3, 'perfume' ),
	   (11,	'pencil', 4, 10, 'Stationary'),
	   (12,	'sharpener', 5,	90,	'Stationary'),
	   (13,	'sketch pen', 30, 10, 'Stationary'),
	   (14,	'tape',	15,	30,	'Stationary'),
	   (15,	'paint', 60, 12, 'Stationary'),
	   (16,	'chocolate', 25,50, 'snacks'),
	   (17,	'biscuts', 60, 26,'snacks'),
	   (18,	'mango', 100, 21, 'fruits'),
	   (19,	'apple', 120, 9, 'fruits'),
	   (20,	'kiwi',	140, 4,	'fruits'),
	   (21,	'carrot', 35, 12, 'vegetable'),
	   (22,	'onion', 22, 38, 'vegetable'),
	   (23,	'tomato', 21, 15, 'vegetable'),
	   (24,	'serum', 90, 4,	'hair product'),
	   (25,	'conditioner', 200, 5,	'hair product'),
	   (26,	'oil bottle', 40, 2,'kitchen utensil');	

AlTER TABLE SALES ADD COLUMN SerialNumbers VARCHAR(100);

ALTER TABLE SALES ADD COLUMN Categories VARCHAR(100);
	
SELECT * FROM Sales;

ALTER TABLE SALES DROP COLUMN SerialNumbers;

ALTER TABLE SALES DROP COLUMN Categories;

ALTER TABLE Customers RENAME TO Customer_Details;

SELECT Order_no, C_id, Order_date, Price, Qty
FROM Sales;

SELECT *
FROM PRODUCT 
WHERE Category = 'Stationary';

SELECT DISTINCT Category
FROM Product; 

SELECT *
FROM Product
ORDER BY price DESC;
	