-- ============================================================
-- Small Business Inventory Tracker (SBIT)
-- Phase 2: Logical Design — Physical Implementation (MySQL)
-- ============================================================
-- This script creates the complete SBIT relational schema
-- derived from the ER diagram.
-- ============================================================

DROP DATABASE IF EXISTS Small_Business_Inventory_Tracker_SBIT;
CREATE DATABASE Small_Business_Inventory_Tracker_SBIT;
USE Small_Business_Inventory_Tracker_SBIT;

-- ============================================================
-- Drop Tables (Reverse Order)
-- ============================================================
DROP TABLE IF EXISTS RecipeItem;
DROP TABLE IF EXISTS PoLine;
DROP TABLE IF EXISTS Shipment;
DROP TABLE IF EXISTS PurchaseOrder;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS Drink;
DROP TABLE IF EXISTS Food;
DROP TABLE IF EXISTS Retail;
DROP TABLE IF EXISTS Product;

-- ============================================================
-- TABLE 1: Product (Supertype)
-- ============================================================
-- ER Mapping: Strong entity Product → Table.
-- ProductId is the primary key (unique identifier).
-- ProductType acts as the discriminator for the IsA hierarchy.
-- ============================================================

CREATE TABLE Product (
    ProductId INT NOT NULL AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    SalePrice DECIMAL(6,2) NOT NULL,
    ProductType ENUM('Drink','Food','Retail') NOT NULL,

    CONSTRAINT PkProduct
        PRIMARY KEY (ProductId),

    CONSTRAINT ChkProductPrice
        CHECK (SalePrice > 0)
);

-- ============================================================
-- TABLE 2: Drink (Subtype of Product)
-- ============================================================
-- ER Mapping: Subtype entity Drink → Table using separate table strategy.
-- ProductId is both PK and FK (shared primary key pattern).
-- Stores only drink-specific attributes.
-- ============================================================

CREATE TABLE Drink (
    ProductId INT NOT NULL,
    ServedTemperature ENUM('Hot','Iced') NOT NULL,
    CaffeineLevel ENUM('Regular','Decaf','None') NOT NULL,
    SizeOptions VARCHAR(50),

    CONSTRAINT PkDrink
        PRIMARY KEY (ProductId),

    CONSTRAINT FkDrinkProduct
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE 3: Food (Subtype of Product)
-- ============================================================
-- ER Mapping: Subtype entity Food → Table using separate table strategy.
-- ProductId is both PK and FK referencing Product.
-- Stores only food-specific attributes.
-- ============================================================

CREATE TABLE Food (
    ProductId INT NOT NULL,
    IsWarmed BOOLEAN NOT NULL,
    StorageType ENUM('Frozen','Refrigerated','Room Temp') NOT NULL,
    Allergens VARCHAR(200) NOT NULL,

    CONSTRAINT PkFood
        PRIMARY KEY (ProductId),

    CONSTRAINT FkFoodProduct
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE 4: Retail (Subtype of Product)
-- ============================================================
-- ER Mapping: Subtype entity Retail → Table using separate table strategy.
-- ProductId is both PK and FK referencing Product.
-- Stores only retail-specific attributes.
-- ============================================================

CREATE TABLE Retail (
    ProductId INT NOT NULL,
    Brand VARCHAR(100) NOT NULL,
    PackageSize VARCHAR(50) NOT NULL,
    Barcode VARCHAR(100),

    CONSTRAINT PkRetail
        PRIMARY KEY (ProductId),

    CONSTRAINT FkRetailProduct
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE 5: Ingredient (Strong Entity)
-- ============================================================
-- ER Mapping: Strong entity Ingredient → Table.
-- IngredientId is the primary key.
-- Name is unique to prevent duplicate ingredients.
-- ============================================================

CREATE TABLE Ingredient (
    IngredientId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Unit VARCHAR(50) NOT NULL,
    CurrentOnHand INT NOT NULL,

    CONSTRAINT PkIngredient
        PRIMARY KEY (IngredientId),

    CONSTRAINT UqIngredientName
        UNIQUE (Name),

    CONSTRAINT ChkIngredientStock
        CHECK (CurrentOnHand >= 0)
);

-- ============================================================
-- TABLE 6: Supplier (Strong Entity)
-- ============================================================
-- ER Mapping: Strong entity Supplier → Table.
-- SupplierId is the primary key.
-- Name is unique to prevent duplicate suppliers.
-- ============================================================

CREATE TABLE Supplier (
    SupplierId INT NOT NULL AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Phone VARCHAR(20),
    Email VARCHAR(100),

    CONSTRAINT PkSupplier
        PRIMARY KEY (SupplierId),

    CONSTRAINT UqSupplierName
        UNIQUE (Name)
);

-- ============================================================
-- TABLE 7: PurchaseOrder (Strong Entity)
-- ============================================================
-- ER Mapping: Strong entity PurchaseOrder → Table.
-- Implements relationship Supplier (1) → PurchaseOrder (M)
-- using SupplierId as a foreign key.
-- Each purchase order belongs to exactly one supplier.
-- ============================================================

CREATE TABLE PurchaseOrder (
    PoId INT NOT NULL AUTO_INCREMENT,
    SupplierId INT NOT NULL,
    Status ENUM('Placed','Received','Cancelled') NOT NULL,
    OrderDate DATE NOT NULL,
    TotalCost DECIMAL(8,2) NOT NULL,

    CONSTRAINT PkPurchaseOrder
        PRIMARY KEY (PoId),

    CONSTRAINT FkPurchaseOrderSupplier
        FOREIGN KEY (SupplierId)
        REFERENCES Supplier(SupplierId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ChkTotalCost
        CHECK (TotalCost > 0)
);

-- ============================================================
-- TABLE 8: Shipment (Weak/Dependent Entity)
-- ============================================================
-- ER Mapping: Shipment depends on PurchaseOrder.
-- Implements relationship PurchaseOrder (1) → Shipment (M).
-- PoId is a foreign key.
-- Each shipment is associated with exactly one purchase order.
-- ============================================================

CREATE TABLE Shipment (
    ShipmentId INT NOT NULL AUTO_INCREMENT,
    PoId INT NOT NULL,
    ShipOutDate DATE NOT NULL,
    EstimatedArrival DATE,
    ActualArrival DATE NOT NULL,

    CONSTRAINT PkShipment
        PRIMARY KEY (ShipmentId),

    CONSTRAINT FkShipmentPo
        FOREIGN KEY (PoId)
        REFERENCES PurchaseOrder(PoId)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- ============================================================
-- TABLE 9: PoLine (Associative Entity)
-- ============================================================
-- ER Mapping: Resolves M:N relationship between
-- PurchaseOrder and Ingredient.
-- Composite uniqueness (PoId, IngredientId) ensures
-- no duplicate ingredient entries per order.
-- ============================================================

CREATE TABLE PoLine (
    PoLineId INT NOT NULL AUTO_INCREMENT,
    PoId INT NOT NULL,
    IngredientId INT NOT NULL,
    QtyOrdered INT NOT NULL,
    UnitCost DECIMAL(6,2) NOT NULL,

    CONSTRAINT PkPoLine
        PRIMARY KEY (PoLineId),

    CONSTRAINT UqPoLine
        UNIQUE (PoId, IngredientId),

    CONSTRAINT FkPoLinePo
        FOREIGN KEY (PoId)
        REFERENCES PurchaseOrder(PoId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FkPoLineIngredient
        FOREIGN KEY (IngredientId)
        REFERENCES Ingredient(IngredientId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ChkQtyOrdered
        CHECK (QtyOrdered > 0),

    CONSTRAINT ChkUnitCost
        CHECK (UnitCost >= 0)
);

-- ============================================================
-- TABLE 10: RecipeItem (Associative Entity)
-- ============================================================
-- ER Mapping: Resolves M:N relationship between
-- Product and Ingredient.
-- Represents recipe composition (what ingredients make a product).
-- Composite uniqueness (ProductId, IngredientId) prevents duplicates.
-- ============================================================

CREATE TABLE RecipeItem (
    RecipeItemId INT NOT NULL AUTO_INCREMENT,
    ProductId INT NOT NULL,
    IngredientId INT NOT NULL,
    QtyNeeded DECIMAL(6,2) NOT NULL,

    CONSTRAINT PkRecipeItem
        PRIMARY KEY (RecipeItemId),

    CONSTRAINT UqRecipe
        UNIQUE (ProductId, IngredientId),

    CONSTRAINT FkRecipeProduct
        FOREIGN KEY (ProductId)
        REFERENCES Product(ProductId)
        ON DELETE CASCADE
        ON UPDATE CASCADE,

    CONSTRAINT FkRecipeIngredient
        FOREIGN KEY (IngredientId)
        REFERENCES Ingredient(IngredientId)
        ON DELETE RESTRICT
        ON UPDATE CASCADE,

    CONSTRAINT ChkQtyNeeded
        CHECK (QtyNeeded > 0)
);

-- ============================================================
-- Verification
-- ============================================================

SHOW TABLES;

DESCRIBE Product;
DESCRIBE Drink;
DESCRIBE Food;
DESCRIBE Retail;
DESCRIBE Ingredient;
DESCRIBE Supplier;
DESCRIBE PurchaseOrder;
DESCRIBE Shipment;
DESCRIBE PoLine;
DESCRIBE RecipeItem;

-- ============================================================
-- END OF SCHEMA
-- ============================================================