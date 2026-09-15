--Insertando en la tabla Category
INSERT INTO Category (Name_Category)
SELECT DISTINCT 
	Category
FROM Superstore

--Insertando en la tabla Sub_Category
INSERT INTO Sub_Category(Name_Sub_Category ,Id_Category)
SELECT DISTINCT 
	s.Sub_Category , 
	c.Id_Category
FROM Superstore s
JOIN Category c 
	ON s.Category = c.Name_Category

-- El cruce usa Product_Name + Id_Sub_Category juntos (no solo el nombre),
-- porque un mismo nombre de producto podría repetirse en distinta subcategoría
INSERT INTO Product(Product_Name,Id_Sub_Category)
SELECT DISTINCT 
	s.Product_Name,
	sub.Id_Sub_Category
FROM Superstore s
JOIN Sub_Category sub 
	ON s.Sub_Category = sub.Name_Sub_Category


--Insertando en la tabla Location
INSERT INTO [Location](Country,City,[State],Postal_Code,Region)
SELECT DISTINCT 
	Country,
	City,
	[State],
	Postal_Code,
	Region
FROM Superstore

--Insertando en la tabla Customer
INSERT INTO Customer(Id_Customer, Customer_Name, Segment)
SELECT DISTINCT 
    Customer_ID, 
    Customer_Name, 
    Segment
FROM Superstore 

-- Se usa DISTINCT porque el mismo Order_ID se repite una vez por cada
-- producto del pedido; solo interesan los datos del pedido en sí
INSERT INTO [Order](Id_Order,Order_Date,Ship_Date,Ship_Mode,Id_Customer,Id_Location)
SELECT DISTINCT 
	s.Order_ID,
	s.Order_Date,
	s.Ship_Date,
	s.Ship_Mode,
	c.Id_Customer,
	l.Id_Location
FROM Superstore s
JOIN Customer c 
	ON c.Id_Customer = s.Customer_ID
JOIN [Location] l 
	ON s.Country=l.Country 
	AND s.City = l.City 
	AND s.[State]=l.[State] 
	AND s.Postal_Code=l.Postal_Code 
	AND s.Region=l.Region


--Se excluye 1 fila con Profit nulo (dato faltante en el origen, no un cero real)
INSERT INTO Order_Details(Quantity,Discount,Profit,Sales,Id_Product,Id_Order) 
SELECT 
	s.Quantity,
	s.Discount,
	s.Profit,
	s.Sales,
	p.Id_Product,
	s.Order_ID
FROM Superstore	s
JOIN Sub_Category sc 
    ON s.Sub_Category = sc.Name_Sub_Category 
JOIN Product p 
    ON s.Product_Name = p.Product_Name 
   AND sc.Id_Sub_Category = p.Id_Sub_Category
   



