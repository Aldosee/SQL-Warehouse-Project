# Data Quality & Validation Tests ✅

## Overview 📋

This directory contains SQL scripts used to validate data quality across the warehouse layers. The purpose of these tests is to ensure that data loaded into the warehouse is accurate, complete, and reliable before it is used for reporting and analytics.

Data validation is performed throughout the ETL process to identify potential issues such as duplicate records, missing values, broken relationships, and inconsistencies between source and transformed datasets.

---

## Objectives 📌

The testing framework focuses on the following quality dimensions:

* Completeness – Verify that mandatory fields contain values.
* Uniqueness – Ensure primary keys and business keys are not duplicated.
* Consistency – Confirm transformed data matches expected business rules.
* Referential Integrity – Validate relationships between fact and dimension tables.
* Accuracy – Detect anomalies and unexpected data values.
* Freshness – Verify that data is loaded according to the expected schedule.

---

## Test Categories ⚙️

### 1. Source Data Validation

These tests examine raw datasets before transformation.

Examples:

* Missing customer identifiers
* Invalid dates
* Duplicate source records
* Null values in required columns

### 2. Transformation Validation

These checks confirm that business rules have been correctly applied during the cleansing and transformation process.

Examples:

* Standardized text formats
* Correct data type conversions
* Valid calculated fields
* Removal of invalid records

### 3. Data Model Validation

These tests verify the integrity of the analytical model.

Examples:

* Primary key uniqueness
* Foreign key relationships
* Fact-to-dimension consistency
* Orphaned records detection

### 4. Business Rule Validation

These tests ensure the warehouse aligns with business requirements.

Examples:

* Sales amounts are non-negative
* Order dates are not in the future
* Product categories follow approved classifications
* Revenue calculations match expected formulas

---

## Example Validation Queries

### Duplicate Key Detection

```sql
SELECT customer_id,
       COUNT(*) AS duplicate_count
FROM dim_customers
GROUP BY customer_id
HAVING COUNT(*) > 1;
```

### Missing Required Values

```sql
SELECT *
FROM dim_products
WHERE product_name IS NULL;
```

### Referential Integrity Check

```sql
SELECT f.product_key
FROM fact_sales f
LEFT JOIN dim_products p
    ON f.product_key = p.product_key
WHERE p.product_key IS NULL;
```

---

## Expected Results

All validation queries should return zero records unless a data quality issue exists.

If any test returns rows, the affected records should be investigated and corrected before the data is promoted to downstream layers.

---

## Testing Workflow 🍃

1. Load source data into the staging or bronze layer.
2. Execute data quality validation scripts.
3. Review failed records and resolve issues.
4. Run transformation processes.
5. Perform integrity and business rule checks.
6. Publish validated data to reporting and analytics layers.

---

## Benefits 👍

Implementing data quality tests provides:

* Increased trust in reporting outputs
* Early detection of ETL issues
* Improved data governance
* Reduced risk of inaccurate business decisions
* Better maintainability of the warehouse environment



---

## Notes 💡

Testing should be executed whenever new data is loaded or transformation logic is modified. Maintaining a consistent validation process helps ensure the warehouse remains a reliable source of truth for analytics and reporting.

