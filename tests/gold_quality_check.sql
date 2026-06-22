# /*

# Gold Layer Validation Framework

Purpose:
This script validates the analytical data model within the Gold Layer
to ensure dimensional integrity and reliable reporting outputs.

```
The validation process focuses on confirming that dimension tables
maintain unique surrogate keys and that fact table records are
properly linked to their corresponding dimensions.
```

Validation Areas:
• Surrogate key uniqueness
• Dimension table integrity
• Fact-to-dimension relationships
• Referential integrity validation
• Star schema consistency

Execution Guidelines:
• Run after Gold Layer data refresh is completed.
• Investigate all records returned by validation queries.
• Resolve data model issues before publishing reports or dashboards.

Expected Outcome:
Validation queries should return zero records unless data model
violations or integrity issues exist.

===============================================================================
*/

-- ============================================================================
-- Customer Dimension Validation | gold.dim_customers
-- ============================================================================

-- Verify uniqueness of customer surrogate keys
-- Expected Result: No duplicate customer keys detected
SELECT
customer_key,
COUNT(*) AS duplicate_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- ============================================================================
-- Product Dimension Validation | gold.dim_products
-- ============================================================================

-- Verify uniqueness of product surrogate keys
-- Expected Result: No duplicate product keys detected
SELECT
product_key,
COUNT(*) AS duplicate_count
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

-- ============================================================================
-- Fact Table Relationship Validation | gold.fact_sales
-- ============================================================================

-- Validate referential integrity between the sales fact table
-- and associated customer and product dimensions
-------------------------------------------------

-- Expected Result:
-- All fact records should successfully map to existing
-- dimension records. No orphaned keys should be returned.

SELECT *
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE c.customer_key IS NULL
OR p.product_key IS NULL;

-- Purpose:
-- Identify orphaned fact records that reference
-- non-existent dimension members.
----------------------------------

-- Returned records indicate potential ETL issues,
-- incomplete dimension loads, or data model violations.
