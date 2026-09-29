USE Small_Business_Inventory_Tracker_SBIT;

-- ============================================================
-- PRODUCT DATA (10 rows)
-- ============================================================
INSERT INTO Product (ProductName, SalePrice, ProductType) VALUES
('Latte', 4.50, 'Drink'),
('Espresso', 3.00, 'Drink'),
('Cappuccino', 4.00, 'Drink'),
('Mocha', 5.00, 'Drink'),
('Bagel', 2.50, 'Food'),
('Muffin', 3.25, 'Food'),
('Croissant', 3.75, 'Food'),
('Coffee Beans 1lb', 12.00, 'Retail'),
('Tea Box', 8.50, 'Retail'),
('Reusable Cup', 6.00, 'Retail');

-- ============================================================
-- DRINK DATA
-- ============================================================
INSERT INTO Drink VALUES
(1,'Hot','Regular','Small,Medium,Large'),
(2,'Hot','Regular','Single'),
(3,'Hot','Regular','Small,Medium,Large'),
(4,'Hot','Regular','Small,Medium,Large');

-- ============================================================
-- FOOD DATA
-- ============================================================
INSERT INTO Food VALUES
(5, FALSE, 'Room Temp', 'Gluten'),
(6, FALSE, 'Room Temp', 'Dairy,Gluten'),
(7, TRUE, 'Room Temp', 'Gluten,Butter');

-- ============================================================
-- RETAIL DATA
-- ============================================================
INSERT INTO Retail VALUES
(8,'Blue Bean Co','1 lb','111AAA'),
(9,'TeaTime','20 bags','222BBB'),
(10,'EcoBrand','16 oz','333CCC');

-- ============================================================
-- INGREDIENT DATA (10 rows)
-- ============================================================
INSERT INTO Ingredient (Name, Unit, CurrentOnHand) VALUES
('Milk','gallons',40),
('Coffee Beans','lbs',60),
('Sugar','lbs',30),
('Flour','lbs',50),
('Butter','lbs',20),
('Eggs','units',100),
('Chocolate Syrup','bottles',25),
('Tea Leaves','lbs',15),
('Water','gallons',200),
('Cups','units',500);

-- ============================================================
-- SUPPLIER DATA (10 rows)
-- ============================================================
INSERT INTO Supplier (Name, Phone, Email) VALUES
('Fresh Dairy','555-1111','dairy@sup.com'),
('Bean Masters','555-2222','beans@sup.com'),
('Bakery Goods','555-3333','bakery@sup.com'),
('Tea Supply','555-4444','tea@sup.com'),
('Packaging Co','555-5555','pack@sup.com'),
('Farm Direct','555-6666','farm@sup.com'),
('Sugar Source','555-7777','sugar@sup.com'),
('Global Imports','555-8888','import@sup.com'),
('Eco Supplies','555-9999','eco@sup.com'),
('Local Market','555-0000','local@sup.com');

-- ============================================================
-- PURCHASE ORDERS (10 rows)
-- ============================================================
INSERT INTO PurchaseOrder (SupplierId, Status, OrderDate, TotalCost) VALUES
(1,'Received','2026-04-01',200),
(2,'Placed','2026-04-02',350),
(3,'Received','2026-04-03',150),
(4,'Placed','2026-04-04',120),
(5,'Received','2026-04-05',90),
(6,'Placed','2026-04-06',300),
(7,'Received','2026-04-07',110),
(8,'Placed','2026-04-08',500),
(9,'Received','2026-04-09',220),
(10,'Placed','2026-04-10',175);

-- ============================================================
-- SHIPMENTS (10 rows)
-- ============================================================
INSERT INTO Shipment (PoId, ShipOutDate, EstimatedArrival, ActualArrival) VALUES
(1,'2026-04-02','2026-04-05','2026-04-05'),
(2,'2026-04-03','2026-04-06','2026-04-06'),
(3,'2026-04-04','2026-04-07','2026-04-07'),
(4,'2026-04-05','2026-04-08','2026-04-08'),
(5,'2026-04-06','2026-04-09','2026-04-09'),
(6,'2026-04-07','2026-04-10','2026-04-10'),
(7,'2026-04-08','2026-04-11','2026-04-11'),
(8,'2026-04-09','2026-04-12','2026-04-12'),
(9,'2026-04-10','2026-04-13','2026-04-13'),
(10,'2026-04-11','2026-04-14','2026-04-14');

-- ============================================================
-- PO LINE (M:N relationship)
-- ============================================================
INSERT INTO PoLine (PoId, IngredientId, QtyOrdered, UnitCost) VALUES
(1,1,10,5.00),
(2,2,15,6.00),
(3,3,8,3.00),
(4,4,12,4.00),
(5,5,6,7.00),
(6,6,20,2.50),
(7,7,5,8.00),
(8,8,10,10.00),
(9,9,25,1.00),
(10,10,100,0.10);

-- ============================================================
-- RECIPE ITEMS (M:N relationship)
-- ============================================================
INSERT INTO RecipeItem (ProductId, IngredientId, QtyNeeded) VALUES
(1,1,0.25),
(1,2,0.10),
(2,2,0.15),
(3,1,0.20),
(4,7,0.30),
(5,4,0.50),
(6,5,0.20),
(7,5,0.30),
(8,2,1.00),
(9,8,0.50);