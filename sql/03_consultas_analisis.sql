
-- 1. Ganancia y venta total por Categoría
SELECT
    c.Name_Category AS Category,
    SUM(od.Sales) AS Total_Sales,
    SUM(od.Profit) AS Total_Profit
FROM Order_Details od
JOIN Product p ON od.Id_Product = p.Id_Product
JOIN Sub_Category sc ON p.Id_Sub_Category = sc.Id_Sub_Category
JOIN Category c ON sc.Id_Category = c.Id_Category
GROUP BY c.Name_Category;



-- ============================================
-- 2. Ganancia y venta total por Subcategoría
-- (Aquí al ejecutar se identificó que Tables ,Supplies y Bookcases generan pérdidas)
SELECT
    sc.Name_Sub_Category AS Sub_Category,
    SUM(od.Sales) AS Total_Sales,
    SUM(od.Profit) AS Total_Profit
FROM Order_Details od
JOIN Product p ON od.Id_Product = p.Id_Product
JOIN Sub_Category sc ON p.Id_Sub_Category = sc.Id_Sub_Category
JOIN Category c ON sc.Id_Category = c.Id_Category
GROUP BY sc.Name_Sub_Category;



-- ============================================
-- 3. Descuento promedio, venta y ganancia por Subcategoría
-- (Aquí se confirmó la relación entre descuento alto y pérdida, 
-- y se identificaron las excepciones como Binders/Machines)
SELECT
    sc.Name_Sub_Category AS Sub_Category,
    AVG(od.Discount) AS Promedio_Discount,
    SUM(od.Sales) AS Total_Sales,
    SUM(od.Profit) AS Total_Profit
FROM Order_Details od
JOIN Product p ON od.Id_Product = p.Id_Product
JOIN Sub_Category sc ON p.Id_Sub_Category = sc.Id_Sub_Category
JOIN Category c ON sc.Id_Category = c.Id_Category
GROUP BY sc.Name_Sub_Category;



-- ============================================
-- 4. Precio promedio por unidad (Sales / Quantity) por Subcategoría
-- (Aquí se confirmó la hipótesis final: productos caros como 
-- Tables pierden más en términos absolutos al aplicar el mismo 
-- % de descuento que productos baratos como Binders)
SELECT
    sc.Name_Sub_Category AS Sub_Category,
    AVG(od.Discount) AS Promedio_Discount,
    SUM(od.Sales) / SUM(od.Quantity) AS PromedioXUnidad,
    SUM(od.Sales) AS Total_Sales,
    SUM(od.Profit) AS Total_Profit
FROM Order_Details od
JOIN Product p ON od.Id_Product = p.Id_Product
JOIN Sub_Category sc ON p.Id_Sub_Category = sc.Id_Sub_Category
JOIN Category c ON sc.Id_Category = c.Id_Category
GROUP BY sc.Name_Sub_Category;