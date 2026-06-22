## Bronze Layer Schema

The Bronze Layer serves as the raw data ingestion layer and stores source data with minimal transformation. It contains CRM and ERP datasets used throughout the warehouse.

### `crm_cust_info`

| Column Name        | Data Type    | Description                |
| ------------------ | ------------ | -------------------------- |
| cst_id             | INT          | Unique customer identifier |
| cst_key            | NVARCHAR(50) | Business customer key      |
| cst_firstname      | NVARCHAR(50) | Customer first name        |
| cst_lastname       | NVARCHAR(50) | Customer last name         |
| cst_marital_status | NVARCHAR(50) | Customer marital status    |
| cst_gndr           | NVARCHAR(50) | Customer gender            |
| cst_create_date    | DATE         | Customer creation date     |

---

### `crm_prd_info`

| Column Name  | Data Type    | Description                 |
| ------------ | ------------ | --------------------------- |
| prd_id       | INT          | Unique product identifier   |
| prd_key      | NVARCHAR(50) | Business product key        |
| prd_nm       | NVARCHAR(50) | Product name                |
| prd_cost     | INT          | Product cost                |
| prd_line     | NVARCHAR(50) | Product line classification |
| prd_start_dt | DATETIME     | Product start date          |
| prd_end_dt   | DATETIME     | Product end date            |

---

### `crm_sales_details`

| Column Name  | Data Type    | Description                     |
| ------------ | ------------ | ------------------------------- |
| sls_ord_num  | NVARCHAR(50) | Sales order number              |
| sls_prd_key  | NVARCHAR(50) | Product business key            |
| sls_cust_id  | INT          | Customer identifier             |
| sls_order_dt | INT          | Order date (YYYYMMDD format)    |
| sls_ship_dt  | INT          | Shipping date (YYYYMMDD format) |
| sls_due_dt   | INT          | Due date (YYYYMMDD format)      |
| sls_sales    | INT          | Total sales amount              |
| sls_quantity | INT          | Quantity sold                   |
| sls_price    | INT          | Unit selling price              |

---

### `erp_loc_a101`

| Column Name | Data Type    | Description         |
| ----------- | ------------ | ------------------- |
| cid         | NVARCHAR(50) | Customer identifier |
| cntry       | NVARCHAR(50) | Customer country    |

---

### `erp_cust_az12`

| Column Name | Data Type    | Description         |
| ----------- | ------------ | ------------------- |
| cid         | NVARCHAR(50) | Customer identifier |
| bdate       | DATE         | Customer birth date |
| gen         | NVARCHAR(50) | Customer gender     |

---

### `erp_px_cat_g1v2`

| Column Name | Data Type    | Description                 |
| ----------- | ------------ | --------------------------- |
| id          | NVARCHAR(50) | Product category identifier |
| cat         | NVARCHAR(50) | Product category            |
| subcat      | NVARCHAR(50) | Product subcategory         |
| maintenance | NVARCHAR(50) | Maintenance classification  |

---

### Data Sources Summary

| Source System | Table             | Purpose                          |
| ------------- | ----------------- | -------------------------------- |
| CRM           | crm_cust_info     | Customer master data             |
| CRM           | crm_prd_info      | Product master data              |
| CRM           | crm_sales_details | Sales transaction data           |
| ERP           | erp_loc_a101      | Customer location information    |
| ERP           | erp_cust_az12     | Customer demographic information |
| ERP           | erp_px_cat_g1v2   | Product category reference data  |
