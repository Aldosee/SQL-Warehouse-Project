# /*

# Data Validation Framework - Silver Layer

Purpose:
This script validates the integrity and quality of transformed data
stored within the Silver Layer of the warehouse.

```
The checks are designed to identify data quality issues that may
impact reporting, analytics, and downstream business processes.
```

Validation Areas:
• Primary key uniqueness and completeness
• Text formatting and whitespace anomalies
• Reference value standardization
• Date validity and chronological accuracy
• Business rule compliance
• Cross-column consistency checks

Execution Guidelines:
• Run after Silver Layer load completion.
• Review all returned records as potential data quality exceptions.
• Resolve validation failures before promoting data to the Gold Layer.

Expected Outcome:
Validation queries should return zero records unless data quality
issues are present.

===============================================================================
*/

-- ============================================================================
-- Customer Master Validation | silver.crm_cust_info
-- ============================================================================

-- Validate customer identifier uniqueness and completeness
-- Expected Result: No duplicate or null customer IDs

SELECT
cst_id,
COUNT(*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL;

-- Detect leading or trailing whitespace in customer keys
-- Expected Result: No records returned
SELECT
cst_key
FROM silver.crm_cust_info
WHERE cst_key <> TRIM(cst_key);

-- Review available marital status values for standardization compliance
SELECT DISTINCT
cst_marital_status
FROM silver.crm_cust_info;

-- ============================================================================
-- Product Master Validation | silver.crm_prd_info
-- ============================================================================

-- Validate product identifier uniqueness and completeness
-- Expected Result: No duplicate or null product IDs
SELECT
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL;

-- Detect formatting issues in product names
-- Expected Result: No records returned
SELECT
prd_nm
FROM silver.crm_prd_info
WHERE prd_nm <> TRIM(prd_nm);

-- Validate product cost values
-- Expected Result: No null or negative costs
SELECT
prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0
OR prd_cost IS NULL;

-- Review product line classifications for consistency
SELECT DISTINCT
prd_line
FROM silver.crm_prd_info;

-- Validate product lifecycle date ranges
-- Expected Result: Product end date must not precede start date
SELECT
*
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt;

-- ============================================================================
-- Sales Transaction Validation | silver.crm_sales_details
-- ============================================================================

-- Identify invalid or malformed due dates in source transactions
-- Expected Result: No invalid date values detected
SELECT
NULLIF(sls_due_dt, 0) AS sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0
OR LEN(sls_due_dt) <> 8
OR sls_due_dt > 20500101
OR sls_due_dt < 19000101;

-- Validate chronological order of sales events
-- Expected Result: Order date occurs before shipping and due dates
SELECT
*
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt
OR sls_order_dt > sls_due_dt;

-- Verify sales calculations and transactional integrity
-- Business Rule: Sales Amount = Quantity × Unit Price
-- Expected Result: No discrepancies detected
SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales <> sls_quantity * sls_price
OR sls_sales IS NULL
OR sls_quantity IS NULL
OR sls_price IS NULL
OR sls_sales <= 0
OR sls_quantity <= 0
OR sls_price <= 0
ORDER BY sls_sales,
sls_quantity,
sls_price;

-- ============================================================================
-- ERP Customer Validation | silver.erp_cust_az12
-- ============================================================================

-- Validate customer birth dates against acceptable business ranges
-- Expected Result: Dates between 1924-01-01 and current date
SELECT DISTINCT
bdate
FROM silver.erp_cust_az12
WHERE bdate < '1924-01-01'
OR bdate > GETDATE();

-- Review gender values for standardization compliance
SELECT DISTINCT
gen
FROM silver.erp_cust_az12;

-- ============================================================================
-- ERP Location Validation | silver.erp_loc_a101
-- ============================================================================

-- Review country values for naming consistency and standardization
SELECT DISTINCT
cntry
FROM silver.erp_loc_a101
ORDER BY cntry;

-- ============================================================================
-- ERP Product Category Validation | silver.erp_px_cat_g1v2
-- ============================================================================

-- Detect whitespace anomalies across category attributes
-- Expected Result: No records returned
SELECT
*
FROM silver.erp_px_cat_g1v2
WHERE cat <> TRIM(cat)
OR subcat <> TRIM(subcat)
OR maintenance <> TRIM(maintenance);

-- Review maintenance classifications for consistency
SELECT DISTINCT
maintenance
FROM silver.erp_px_cat_g1v2;
