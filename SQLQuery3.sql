select * from EmpLoyees 
select * from Categories
select * from Products
select * from Receipts 
select * from Details

INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID, Discontinued)
VALUES
    ('56', N'ยางลบ', 10.00, 250, 4, 0);

	SELECT * FROM Products;
--------------------------------------------------------

UPDATE Products
SET UnitsInStock = UnitsInStock + 100
WHERE ProductName = N'ดินสอ';

SELECT *
FROM Products
WHERE ProductName = N'ดินสอ';
---------------------------------------------------------
-- คำสั่งสำรวจชื่อตารางในฐานข้อมูลที่ใช้อยู่ -- 
Select * from INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

-- คำสั่ง sp (store procedure) สำรวจตาราง products -- 
exec sp_help 'dbo.products' 

-- คำสั่งดูทุกๆคอลัมในตาราง products -- 
select * from dbo.Products;

--
select 
ProductID,
PRODUCTName,
UnitPrice
From dbo.Products;

select 
PRODUCTName AS ชื่อสินค้า,
UnitPrice AS ราคา 
From dbo.Products;

--ใช้ Distinct สำหรับลดการแสดงข้อมูลที่ซ้ำกัน -- 
select distinct Position from Employees 

-- เรียกดู Top 5 ของสิยค้า -- 
SELECT TOP (5) 
PRODUCTID,
PRODUCTName,
UnitPrice

FROM dbo.Products;

-- การแก้ไขข้อมูลในตารางให้สินค้าชื่อ ดินสอ ราคา เป็น 12 
Update Products
set UnitPrice = 12
where productID = 1 

------------------------------------------
Update Products
set UnitPrice = 15
where ProductName = 'ดินสอ' 

-- ปรัยปรุงราคายางลบ ให้มีราคา 10 บาท และมีจำนวนคงเหลือ 250 -- 

UPDATE dbo.Products 
SET 
	UnitPrice = 10.00, 
	UnitsInStock = 250 
	where ProductName = 'ยางลบ' 

-- ปรับปรุงจำนวนคงเหลือของดินสอ เพิ่มขึ้น 100 ชิ้น -- 

Update Products 
set UnitsInStock = UnitsInStock+100
where ProductName = 'ดินสอ' 

------------------------------------------------- 
INSERT INTO Products
    (ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID, Discontinued)
VALUES
    ('88', N'ดินสอ', 5.00, 100, 4, 0);

UPDATE Products
SET UnitsInStock = UnitsInStock + 100
WHERE ProductName = N'ดินสอ';

SELECT ProductID, ProductName, UnitsInStock
FROM Products
WHERE ProductName = N'ดินสอ';

--------------------------------------------------

-- ขึ้นราคาสินค้า 5% ทุกรายการ -- 
Update Products 
set UnitPrice = UnitPrice * 1.05 

-- DELETE ลบข้อมูล แต่โครงสร้างตารางยังอยู๋ -- 
Select * from Products
-- เลือกสินค้าที่อยากลบ และใช้ PRODUCTID ในการลบ -- 
Delete from Products where PRODUCTID = 8858757012345  
-- แต่ถ้าสินค้าไหนเคยขายไปแล้วจะไม่สามารถลบออกจากตารางได้ -- 
-------------------------------------------------------------------------------------

-- คำสั่ง Select (การใช้ Where)
-----------------------------------------------

Select ProductID, ProductName, UnitPrice
from Products
where UnitPrice < 20

-- ต้องการ ชื่อ นามสกุล พนักงานที่เป็น Sale Manager

Select firstname, lastname
from Employees
where Position = 'Sale manager'

-- ต้องการ รหัสสินค้า ของ ชาเขียว

select productID
from Products
where ProductName = 'ชาเขียว'

-- ข้อมูลสินค้าที่มีจำนวนในสต็อก ต่ำกว่า 400

select *
from products
where UnitsInStock < 400

-- ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 และราคาไม่เกิน 20

Select * from products
where CategoryID = 1 and UnitPrice <= 20

-- ข้อมูลสินค้าที่รหัสหมวดหมู่ 1 หรือ ราคาไม่เกิน 20

Select * from products
where CategoryID = 1 or UnitPrice <= 20

-- BETWEEN = กำหนดช่วง (ช่วงราคายอดเงิน) -- 
SELECT
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
WHERE UnitPrice BETWEEN 10 AND 20;

-- IN = ตรวจสอบค่าหลายค่า --
SELECT
    ProductID,
    ProductName,
    CategoryID
FROM dbo.Products
WHERE CategoryID IN (1, 2, 4);

-- หา product ที่ขึ้นต้นด้วยคำว่า น้ำ -- 
SELECT
    ProductID,
    ProductName
FROM dbo.Products 
WHERE ProductName LIKE N'น้ำ%'

-- * 2 
Select *
from products
where ProductName like 'น้ำ%'

-- ชื่อ นามสกุลพนักงานที่มีนามสกุลลงท้ายด้วย "คำ"
Select FirstName, LastName

from Employees

where LastName like '%คำ'

-- ชื่อสินค้า ราคา สินค้าที่มีคำว่า ส้ม

Select ProductName, UnitPrice

from Products

where ProductName like '%ส้ม%'
----------------------------------------

-- เตรีนมข้อมูลที่มีค่าNull -- 
Insert into Employees(FirstName, UserName, Password)
values ('วริศ', 'Waris','1234')

Insert into Employees(FirstName,LastName UserName, Password)
values ('วริศ','', 'Waris','1234')

-- ต้องการข้อมูลของพนักงานที่ยังไม่ทราบนามสกุล

SELECT *
FROM Employees
WHERE LastName IS NULL OR LastName = ''

-- ต้องการ คำนำหน้า ชื่อ นามสกุล พนักงาน ทุกคน และอยู่ในช่องเดียวกัน

SELECT Title + FirstName + ' ' + LastName AS ชื่อนามสกุลพนักงาน
FROM Employees

-- กรณีมีเงื่อนไขเป็นวันที่
-----------------------------------------------

SELECT *
FROM Receipts
WHERE ReceiptDate = '2013/02/10' --ตรงตามวัน

SELECT *
FROM Receipts
WHERE ReceiptDate < '2013/02/10' -- ก่อนัวนที่ 

SELECT *  
FROM Receipts
WHERE ReceiptDate > '2013/02/10' -- ตั้งแต่ .. เป็นต้นไป 

SELECT *
FROM Receipts
WHERE ReceiptDate between '2013-02-01' and '2013-02-07'

-- ใช้ Function Year(), Month() มาช่วยในเงื่อนไข

SELECT *
FROM Receipts
WHERE YEAR(ReceiptDate) = 2013

-- ปี 2013 ทั้งหมด

SELECT *
FROM Receipts

WHERE YEAR(ReceiptDate) = 2013
  AND MONTH(ReceiptDate) = 2


  SELECT
    ReceiptID,
    ReceiptDate,
    EmployeeID,
    TotalCash
FROM dbo.Receipts
WHERE ReceiptDate >= '20260701'
    AND ReceiptDate < '20260702';

    -------------------------------------

   -- ORDER BY ใช้สำหรับเรียงลำดับ จะใส่ต่อท้ายสุดของคำสั่ง SQL
-----------------------------------------------

-- รหัสสินค้า ชื่อสินค้า ราคา จำนวนคงเหลือ เรียงตามชื่อสินค้า

SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
ORDER BY ProductName

-- รหัสสินค้า ชื่อสินค้า ราคา จำนวนคงเหลือ เรียงตามราคาจากมากไปน้อย

SELECT ProductID, ProductName, UnitPrice, UnitsInStock
FROM Products
ORDER BY UnitPrice DESC

SELECT *
FROM Products
ORDER BY CategoryID

-- top เอาจำนวนสินค้าที่มีจำนวนมากที่สุด 3 หรือ 5 อันดับ ) 

-- แสดงสินค้าที่มีราคาสูงที่สุด 5 อันดับ

SELECT TOP (5)
    ProductID,
    ProductName,
    UnitPrice
FROM dbo.Products
ORDER BY UnitPrice DESC;

-- แสดงสินค้าที่มีจำนวนคงเหลือน้อยที่สุด 3 อันดับ

SELECT TOP (3)
    ProductID,
    ProductName,
    UnitsInStock
FROM dbo.Products
ORDER BY UnitsInStock ASC;



