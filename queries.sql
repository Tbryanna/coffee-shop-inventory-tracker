-- ============================================================
-- SBIT CAPSTONE: QUERY PORTFOLIO
-- ============================================================

USE Small_Business_Inventory_Tracker_SBIT;

-- ============================================================
-- 1. VIEW ALL PRODUCTS WITH RECIPE DETAILS (JOIN 3 TABLES)
-- ============================================================
SELECT 
    p.ProductName,
    i.Name AS Ingredient,
    r.QtyNeeded
FROM Product p
JOIN RecipeItem r ON p.ProductId = r.ProductId
JOIN Ingredient i ON r.IngredientId = i.IngredientId;

-- ============================================================
-- 2. PURCHASE ORDERS WITH SUPPLIER + INGREDIENTS (4 TABLE JOIN)
-- ============================================================
SELECT 
    po.PoId,
    s.Name AS Supplier,
    i.Name AS Ingredient,
    pl.QtyOrdered,
    pl.UnitCost
FROM PurchaseOrder po
JOIN Supplier s ON po.SupplierId = s.SupplierId
JOIN PoLine pl ON po.PoId = pl.PoId
JOIN Ingredient i ON pl.IngredientId = i.IngredientId;

-- ============================================================
-- 3. TOTAL INGREDIENTS ORDERED (GROUP BY + HAVING)
-- ============================================================
SELECT 
    IngredientId,
    SUM(QtyOrdered) AS TotalOrdered
FROM PoLine
GROUP BY IngredientId
HAVING SUM(QtyOrdered) > 10;

-- ============================================================
-- 4. PRODUCT COUNT BY TYPE (AGGREGATE)
-- ============================================================
SELECT 
    ProductType,
    COUNT(*) AS TotalProducts
FROM Product
GROUP BY ProductType;

-- ============================================================
-- 5. SUBQUERY: PRODUCTS WITH HIGH INGREDIENT USAGE
-- ============================================================
SELECT ProductName
FROM Product
WHERE ProductId IN (
    SELECT ProductId
    FROM RecipeItem
    GROUP BY ProductId
    HAVING SUM(QtyNeeded) > 0.2
);

-- ============================================================
-- 6. SUBQUERY: SHOW TOTAL INVENTORY VALUE CONTEXT
-- ============================================================
SELECT 
    Name,
    (SELECT SUM(CurrentOnHand) FROM Ingredient) AS TotalInventory
FROM Ingredient;

-- ============================================================
-- 7. VIEW USAGE: LOW STOCK INGREDIENTS
-- ============================================================
SELECT * FROM LowStock;

-- ============================================================
-- 8. VIEW USAGE: PRODUCT RECIPE BREAKDOWN
-- ============================================================
SELECT * FROM ProductCostBreakdown;

-- ============================================================
-- 9. SUPPLIER TOTAL SPENDING
-- ============================================================
SELECT 
    s.Name,
    SUM(po.TotalCost) AS TotalSpent
FROM Supplier s
JOIN PurchaseOrder po ON s.SupplierId = po.SupplierId
GROUP BY s.Name;

-- ============================================================
-- 10. LOW STOCK ALERT QUERY
-- ============================================================
SELECT 
    Name,
    CurrentOnHand
FROM Ingredient
WHERE CurrentOnHand < 50;

-- ============================================================
-- 11. MOST ORDERED INGREDIENTS
-- ============================================================
SELECT 
    i.Name,
    SUM(pl.QtyOrdered) AS TotalUsed
FROM Ingredient i
JOIN PoLine pl ON i.IngredientId = pl.IngredientId
GROUP BY i.Name
ORDER BY TotalUsed DESC;

-- ============================================================
-- 12. PRODUCT PRICE LIST (SORTED)
-- ============================================================
SELECT 
    ProductName,
    SalePrice
FROM Product
ORDER BY SalePrice DESC;
