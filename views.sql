USE Small_Business_Inventory_Tracker_SBIT;

DROP VIEW IF EXISTS LowStock;
DROP VIEW IF EXISTS ProductCostBreakdown;

-- ============================================================
-- VIEW 1: LOW STOCK INGREDIENTS
-- Purpose: Shows ingredients that are running low in inventory
-- ============================================================
CREATE VIEW LowStock AS
SELECT 
    IngredientId,
    Name,
    CurrentOnHand
FROM Ingredient
WHERE CurrentOnHand < 30;

-- ============================================================
-- VIEW 2: PRODUCT RECIPE BREAKDOWN
-- Purpose: Shows what ingredients are needed for each product
-- ============================================================
CREATE VIEW ProductCostBreakdown AS
SELECT 
    p.ProductName,
    i.Name AS IngredientName,
    r.QtyNeeded
FROM Product p
JOIN RecipeItem r ON p.ProductId = r.ProductId
JOIN Ingredient i ON r.IngredientId = i.IngredientId;