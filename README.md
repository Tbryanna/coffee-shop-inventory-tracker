# Coffee Shop Inventory Tracker

A MySQL relational database designed to manage inventory, products, suppliers,
purchase orders, shipments, and ingredients for a small coffee shop business.

## About the Project

The Small Business Inventory Tracker (SBIT) was designed to model and manage
the inventory operations of a coffee shop. The database organizes products,
ingredients, suppliers, purchase orders, and shipments while maintaining
relationships between the different parts of the business.

The project was developed using MySQL and demonstrates relational database
design, data organization, SQL queries, and database views.

## Database Features

- Tracks products sold by the business
- Organizes products into Drink, Food, and Retail categories
- Tracks ingredients and current inventory levels
- Stores supplier information
- Manages purchase orders
- Tracks shipments associated with purchase orders
- Connects ingredients to purchase orders
- Uses relational constraints to maintain data integrity

## Database Design

The database contains several related tables, including:

- `Product` - Stores general product information
- `Drink` - Stores drink-specific information
- `Food` - Stores food-specific information
- `Retail` - Stores retail product information
- `Ingredient` - Tracks ingredients and current inventory
- `Supplier` - Stores supplier information
- `PurchaseOrder` - Tracks orders placed with suppliers
- `Shipment` - Tracks shipments associated with purchase orders
- `PoLine` - Connects ingredients to purchase orders

## SQL Concepts Demonstrated

- Relational database design
- Primary keys
- Foreign keys
- One-to-many relationships
- Many-to-many relationships
- Associative entities
- Supertype and subtype relationships
- CHECK constraints
- UNIQUE constraints
- ENUM data types
- SQL queries
- Database views
- Sample data creation

## Project Files

- `SBIT.sql` - Creates the database schema, tables, relationships, and constraints
- `sample_data.sql` - Populates the database with sample data
- `queries.sql` - Contains SQL queries used to retrieve and analyze database information
- `views.sql` - Contains database views for commonly accessed information

## Technologies Used

- MySQL
- MySQL Workbench
- SQL

## What I Learned

Through this project, I gained experience designing and implementing a
relational database from a logical database design. I practiced translating
relationships into MySQL tables, creating primary and foreign keys, enforcing
data integrity with constraints, and writing queries and views to retrieve
useful information from the database.
