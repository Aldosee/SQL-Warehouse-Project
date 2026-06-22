## Silver Layer Schema

The Silver Layer contains cleansed, standardized, and validated data derived from the Bronze Layer. This layer applies business rules, corrects data quality issues, standardizes formats, and enriches records to prepare them for analytical consumption.

### Key Transformations

| Transformation Category  | Description                                                                |
| ------------------------ | -------------------------------------------------------------------------- |
| Data Cleansing           | Removal of duplicates, null handling, and correction of invalid values     |
| Data Standardization     | Standardized gender, marital status, country, and product classifications  |
| Data Type Conversion     | Conversion of source date integers into SQL DATE format                    |
| Business Rule Validation | Validation of sales calculations, date ranges, and referential consistency |
| Audit Tracking           | Addition of warehouse load timestamps (`dwh_create_date`)                  |

---

### `crm_cust_info`

| Column Name        | Data Type    | Description                      |
| ------------------ | ------------ | -------------------------------- |
| cst_id             | INT          | Unique customer identifier       |
| cst_key            | NVARCHAR(50) | Business customer key            |
| cst_firstname      | NVARCHAR(50) | Standardized customer first name |
| cst_lastname       | NVARCHAR(50) | Standardized customer last name  |
| cst_marital_status | NVARCHAR(50) | Standardized marital status      |
| cst_gndr           | NVARCHAR(50) | Standardized gender value        |
| cst_create_date    | DATE         | Customer creation date           |
| dwh_create_date    | DATETIME2    | Warehouse load timestamp         |

---

### `crm_prd_info`

| Column Name     | Data Type    | Description                  |
| --------------- | ------------ | ---------------------------- |
| prd_id          | INT          | Unique product identifier    |
| cat_id          | NVARCHAR(50) | Product category identifier  |
| prd_key         | NVARCHAR(50) | Business product key         |
| prd_nm          | NVARCHAR(50) | Standardized product name    |
| prd_cost        | INT          | Product cost                 |
| prd_line        | NVARCHAR(50) | Product line classification  |
| prd_start_dt    | DATE         | Product effective start date |
| prd_end_dt      | DATE         | Product effective end date   |
| dwh_create_date | DATETIME2    | Warehouse load timestamp     |

---

### `crm_sales_details`

| Column Name     | Data Type    | Description              |
| --------------- | ------------ | ------------------------ |
| sls_ord_num     | NVARCHAR(50) | Sales order number       |
| sls_prd_key     | NVARCHAR(50) | Product business key     |
| sls_cust_id     | INT          | Customer identifier      |
| sls_order_dt    | DATE         | Order date               |
| sls_ship_dt     | DATE         | Shipping date            |
| sls_due_dt      | DATE         | Due date                 |
| sls_sales       | INT          | Total sales amount       |
| sls_quantity    | INT          | Quantity sold            |
| sls_price       | INT          | Unit selling price       |
| dwh_create_date | DATETIME2    | Warehouse load timestamp |

---

### `erp_loc_a101`

| Column Name     | Data Type    | Description               |
| --------------- | ------------ | ------------------------- |
| cid             | NVARCHAR(50) | Customer identifier       |
| cntry           | NVARCHAR(50) | Standardized country name |
| dwh_create_date | DATETIME2    | Warehouse load timestamp  |

---

### `erp_cust_az12`

| Column Name     | Data Type    | Description               |
| --------------- | ------------ | ------------------------- |
| cid             | NVARCHAR(50) | Customer identifier       |
| bdate           | DATE         | Customer birth date       |
| gen             | NVARCHAR(50) | Standardized gender value |
| dwh_create_date | DATETIME2    | Warehouse load timestamp  |

---

### `erp_px_cat_g1v2`

| Column Name     | Data Type    | Description                 |
| --------------- | ------------ | --------------------------- |
| id              | NVARCHAR(50) | Product category identifier |
| cat             | NVARCHAR(50) | Product category            |
| subcat          | NVARCHAR(50) | Product subcategory         |
| maintenance     | NVARCHAR(50) | Maintenance classification  |
| dwh_create_date | DATETIME2    | Warehouse load timestamp    |

---

### Silver Layer Quality Controls

| Validation Area          | Purpose                                                                 |
| ------------------------ | ----------------------------------------------------------------------- |
| Primary Key Validation   | Detect duplicate or null business identifiers                           |
| Text Standardization     | Remove unwanted spaces and normalize text values                        |
| Date Validation          | Verify valid date ranges and chronological order                        |
| Business Rule Validation | Ensure sales calculations match expected formulas                       |
| Domain Validation        | Verify approved values for gender, country, and product classifications |
| Audit Tracking           | Record data load timestamps for lineage and monitoring                  |

---

### Layer Purpose

The Silver Layer acts as the trusted operational data layer within the warehouse. All records are validated and standardized before being promoted to the Gold Layer, where dimensional models and analytical reporting structures are built.
