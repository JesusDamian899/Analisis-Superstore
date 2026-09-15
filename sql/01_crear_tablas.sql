-- Tabla de ubicaciones geográficas de los pedidos (no del cliente,
-- ya que se identificó que un mismo cliente puede comprar desde distintas ubicaciones
CREATE TABLE [Location] (
    Id_Location INT PRIMARY KEY IDENTITY(1,1),
    Country VARCHAR(50),
    City VARCHAR(50),
    [State] VARCHAR(50),
    Postal_Code INT,
    Region VARCHAR(50)
);


CREATE TABLE Category(
    Id_Category INT PRIMARY KEY IDENTITY(1,1),
    Name_Category VARCHAR(50)
);


CREATE TABLE Sub_Category(
    Id_Sub_Category INT PRIMARY KEY IDENTITY(1,1),
    Name_Sub_Category VARCHAR(50),
    Id_Category INT,
    FOREIGN KEY (Id_Category) REFERENCES Category(Id_Category)
);


--Product usa Id_Product autogenerado (no el Product_ID de Superstore)
-- porque se detectó que el mismo Product_ID podía tener nombres de producto distintos
CREATE TABLE Product(
    Id_Product INT PRIMARY KEY IDENTITY(1,1),
    Product_Name VARCHAR(250),
    Id_Sub_Category INT,
    FOREIGN KEY (Id_Sub_Category) REFERENCES Sub_Category(Id_Sub_Category)
);

--La ubicación (Id_Location) se coloca en Order y no en Customer,
-- porque se descubrió que un mismo cliente puede comprar desde distintas ubicaciones
CREATE TABLE Customer(
    Id_Customer VARCHAR(50) PRIMARY KEY, 
    Customer_Name VARCHAR(50),
    Segment VARCHAR(50)
);

--A diferencia de Product, aquí sí se usa el Order_ID real de Superstore como PK,
-- ya que se verificó que es consistente (mismo pedido = mismos datos siempre)
CREATE TABLE [Order] (
	Id_Order VARCHAR(250) PRIMARY KEY,
	Order_Date DATE,
	Ship_Date DATE,
	Ship_Mode VARCHAR(50),
	Id_Customer VARCHAR(50),
	Id_Location INT,
	FOREIGN KEY (Id_Customer) REFERENCES Customer(Id_Customer),
	FOREIGN KEY (Id_Location) REFERENCES [Location](ID_Location)
);


CREATE TABLE Order_Details(
	Id_Order_Details INT PRIMARY KEY IDENTITY(1,1),
	Quantity INT,
	Discount DECIMAL(10,2),
	Profit DECIMAL(10,2),
	Sales DECIMAL(10,2),
	Id_Product INT,
	Id_Order VARCHAR(250),
	FOREIGN KEY(Id_Product) REFERENCES Product(Id_Product),
	FOREIGN KEY(Id_Order) REFERENCES [Order](Id_Order)
);

