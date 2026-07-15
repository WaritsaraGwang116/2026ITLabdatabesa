-- Create database KTMinimart
CREATE TABLE Employees (
EmployeeID INT IDENTITY (1,1) PRIMARY KEY,
Title VARCHAR (20),
FirstName VARCHAR (50) NOT NULL, 
LastName  VARCHAR (50),
Position  VARCHAR (50),
UserName  VARCHAR (50) UNIQUE,
PasswordHash VARCHAR (255) NOT NULL,
IsActive BIT NOT NULL DEFAULT 1

);

INSERT INTO Employees
(Title, FirstName, LastName,
Position, UserName, PasswordHash)

VALUES
('นางสาว' , ' กาญจนา', 'พวงแก้ว',
'Sale Manager', 'user', 'hashed1');

-- กดแสดงผลลัพธ์ข้อมูลที่นำเข้าตารางข้อมูล -- 
SELECT*

FROM Employees;

-- แก้ไขการเก็บข้อมูลภาษาไทยซึ่งต้องแก้ตั้งแต่ก่อนสร้างตาราง
-- ดังนั้นเราจะลบตารางออกจากระบบฐานข้อมููลก่อนแล้วค่อยกลับมาสร้างใหม่

drop table Employees 

--ปรับฐานข้อมูลให้เป็นภาษาไทบ 

ALTER DATABASE KTMinimart
COLLATE Thai_CI_AS;

--หลังจากรันคำสั่ง Alter แล้ว ให้สร้างเป็นตาราง และเพิ่มข้อมูลอีกครั้ง 

-- ทดสอบเพิ่มข้อมูลของคนที่ 2 -- 
INSERT INTO Employees
(Title, FirstName, LastName,
Position, UserName, PasswordHash)

VALUES
('นางสาว' , ' วริศรา', 'สิริธนาคุณ',
'Sale Manager', 'user1', 'hashed1');

-- สร้างตารางหมวดหมู่สินค้า (Categories) -- 
Create   Table Categories(
	CategoryID INT Identity(1,1) Primary Key,
	CategoryName Varchar(50) Not null Unique,
	Description varchar(200)

)

-- หลังจากสร้างตารางแล้ว เพิ่มข้อมูล 5 หมวดหมู่ตามสไลต์ ยังไม่ต้องใส่รายละเอียดก็ได้-- 

Insert into Categories(CategoryName) Values ('เครื่องปรุง')
Insert into Categories(CategoryName) Values ('เครื่องดื่ม')
Insert into Categories(CategoryName) Values ('อาหารสำเร็จรูป')
Insert into Categories(CategoryName) Values ('เครื่องสำอาง')
Insert into Categories(CategoryName) Values ('เวชภัณฑ์')

-- ดูข้อมูลที่ได้ -- 
Select * from Categories

-- สร้างตารางสินค้าืี่มีข้อกำหนดหลายอย่าง โดยเฉพาะ FK 

CREATE TABLE Products (
ProductID VARCHAR(13) PRIMARY KEY,
ProductName VARCHAR(100) NOT NULL,
UnitPrice DECIMAL(10,2) NOT NULL DEFAULT 0,
UnitsInStock INT NOT NULL DEFAULT 0,
CategoryID INT NOT NULL,

Discontinued BIT NOT NULL DEFAULT 0,

CONSTRAINT CK_Products_UnitPrice
	CHECK (UnitPrice >= 0),

CONSTRAINT CK_Products_UnitsInStock
	CHECK (UnitsInStock >= 0),

CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID)
REFERENCES Categories (CategoryID)
);

-- ปฏิบัติทดสอบ Products -- 
-- แบบ SQL ข้อมูลถูก -- 
INSERT INTO Products
(ProductID, ProductName, UnitPrice,
UnitsInStock, CategoryID)
VALUES
	('8858757001948','โค้ก',
	15.00, 290, 1);

-- แบบ SQL ข้อมูลผิด ต้องราคาไม่ติด - ถึงจะถูกต้อง เพราะราคาสินค้าไม่ควรติดลบ -- 
INSERT INTO Products
(ProductID, ProductName, UnitPrice, UnitsInStock, CategoryID)
VALUES
	('8858757909999', 'สินค้าทดสอบ',
	-10.00, 20, 1) ;

-- ไม่สามารถ drop table Categories ได้ เพราะอ้างอิงถึงกันในข้อมูลแล้ว -- 

-- การสร้างตาราง Receipts -- 

CREATE TABLE Receipts (
    ReceiptID INT IDENTITY(1,1) PRIMARY KEY,

    ReceiptDate DATETIME NOT NULL
        DEFAULT GETDATE(),

    EmployeeID INT NOT NULL,

    TotalCash DECIMAL(10,2) NOT NULL
        DEFAULT 0,

    CONSTRAINT CK_Receipts_TotalCash
        CHECK (TotalCash >= 0),

    CONSTRAINT FK_Receipts_Employees
        FOREIGN KEY (EmployeeID)
        REFERENCES Employees(EmployeeID)
);

-- ทอดสอบเพิ่มจ้อมูลใบเสร็จ 
Insert into Receipts(EmpLoyeeID, TotalCash) Values (1, 115)
-- หลังจากเพิ่มแล้วทอดสอบเปิดดูข้อมูลในตาราง Recipts
select * from Receipts

-- ไม่สามารถ drop table EmpLoyee ได้แล้วเนื่องจากทุกตารางเชื่อมกันแล้ว 

-------------------------------------------------

-- สร้างตาราง Details -- 

CREATE TABLE Details (
    ReceiptID INT NOT NULL,
    ProductID VARCHAR(13) NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Quantity INT NOT NULL,

    CONSTRAINT PK_Details
        PRIMARY KEY (ReceiptID, ProductID),

    CONSTRAINT CK_Details_UnitPrice
        CHECK (UnitPrice >= 0),

    CONSTRAINT CK_Details_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_Details_Receipts
        FOREIGN KEY (ReceiptID)
        REFERENCES Receipts(ReceiptID),

    CONSTRAINT FK_Details_Products
        FOREIGN KEY (ProductID)
        REFERENCES Products(ProductID)
);

-- ปฏิบัติเพิ่มข้อมูล Details -- 
-- SQL ข้อมูลที่ ถูกต้อง -- 
INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 3);

-- SQL ข้อมูลที่ไม่ถูกต้อง -- 

INSERT INTO Details
    (ReceiptID, ProductID, UnitPrice, Quantity)
VALUES
    (1, '8858757001948', 15.00, 0);
    0