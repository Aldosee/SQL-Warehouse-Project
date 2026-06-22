## Gold Layer Schema

The Gold Layer contains business-ready data models optimized for reporting, dashboarding, and analytical workloads. Data in this layer is organized into dimension and fact tables following a Star Schema design to support efficient querying and business intelligence applications.

### Analytical Modeling Features

| Modeling Component          | Description                                                       |
| --------------------------- | ----------------------------------------------------------------- |
| Star Schema Design          | Organized into fact and dimension tables for analytical reporting |
| Customer Dimension          | Consolidated customer attributes from CRM and ERP systems         |
| Product Dimension           | Enriched product information including category hierarchy         |
| Sales Fact Table            | Transaction-level sales metrics and business measures             |
| Surrogate Keys              | Generated dimension keys to support analytical relationships      |
| Business-Friendly Structure | Simplified model for reporting and dashboard consumption          |

---

### `dim_customers`

Customer dimension containing consolidated customer attributes from multiple source systems.

| Column Name     | Data Type    | Description                                     |
| --------------- | ------------ | ----------------------------------------------- |
| customer_key    | INT          | Surrogate key used for analytical relationships |
| customer_id     | INT          | Source customer identifier                      |
| customer_number | NVARCHAR(50) | Business customer key                           |
| first_name      | NVARCHAR(50) | Customer first name                             |
| last_name       | NVARCHAR(50) | Customer last name                              |
| country         | NVARCHAR(50) | Customer country                                |
| marital_status  | NVARCHAR(50) | Marital status                                  |
| gender          | NVARCHAR(50) | Customer gender                                 |
| birthdate       | DATE         | Customer birth date                             |
| create_date     | DATE         | Customer creation date                          |

---

### `dim_products`

Product dimension containing product attributes and category information.

| Column Name    | Data Type    | Description                                     |
| -------------- | ------------ | ----------------------------------------------- |
| product_key    | INT          | Surrogate key used for analytical relationships |
| product_id     | INT          | Source product identifier                       |
| product_number | NVARCHAR(50) | Business product key                            |
| product_name   | NVARCHAR(50) | Product name                                    |
| category_id    | NVARCHAR(50) | Product category identifier                     |
| category       | NVARCHAR(50) | Product category                                |
| subcategory    | NVARCHAR(50) | Product subcategory                             |
| maintenance    | NVARCHAR(50) | Maintenance classification                      |
| cost           | INT          | Product cost                                    |
| product_line   | NVARCHAR(50) | Product line                                    |
| start_date     | DATE         | Product effective start date                    |

---

### `fact_sales`

Fact table containing transactional sales measures and references to related dimensions.

| Column Name   | Data Type    | Description                       |
| ------------- | ------------ | --------------------------------- |
| order_number  | NVARCHAR(50) | Sales order number                |
| product_key   | INT          | Foreign key to product dimension  |
| customer_key  | INT          | Foreign key to customer dimension |
| order_date    | DATE         | Order date                        |
| shipping_date | DATE         | Shipping date                     |
| due_date      | DATE         | Due date                          |
| sales_amount  | INT          | Total sales value                 |
| quantity      | INT          | Quantity sold                     |
| price         | INT          | Unit selling price                |

---

### Gold Layer Data Model

| Table         | Type      | Purpose                                   |
| ------------- | --------- | ----------------------------------------- |
| dim_customers | Dimension | Customer analysis and segmentation        |
| dim_products  | Dimension | Product performance and category analysis |
| fact_sales    | Fact      | Sales metrics and transactional reporting |

---

### Analytical Relationships

| Source Table | Target Table  | Relationship |
| ------------ | ------------- | ------------ |
| fact_sales   | dim_customers | Many-to-One  |
| fact_sales   | dim_products  | Many-to-One  |

---

### Business Metrics Supported

| Metric Category       | Example Metrics                                                    |
| --------------------- | ------------------------------------------------------------------ |
| Revenue Analysis      | Total Sales, Revenue Trends, Sales Growth                          |
| Product Performance   | Top Products, Product Line Revenue, Category Analysis              |
| Customer Analytics    | Customer Segmentation, Purchase Frequency, Customer Lifetime Value |
| Operational Reporting | Order Volume, Shipping Performance, Sales Trends                   |
| Time-Based Analysis   | Daily, Monthly, Quarterly, and Yearly Sales Trends                 |

---

### Gold Layer Validation Controls

| Validation Area          | Purpose                                              |
| ------------------------ | ---------------------------------------------------- |
| Surrogate Key Validation | Ensure uniqueness of dimension keys                  |
| Dimension Integrity      | Verify dimension records are complete and consistent |
| Referential Integrity    | Validate fact table references to dimensions         |
| Star Schema Validation   | Ensure analytical relationships remain intact        |
| Orphan Record Detection  | Identify fact records without matching dimensions    |

---

### Layer Purpose

The Gold Layer serves as the presentation and analytics layer of the warehouse. It provides a business-friendly data model that supports reporting, dashboard development, KPI tracking, and ad hoc analysis while maintaining consistency across all analytical workloads.
