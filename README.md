# Data Cleaning SQL Queries

This repository contains a set of SQL queries designed to clean and preprocess data from the 'NashvilleHousing' table. The queries address various data cleaning tasks, such as handling date formats, addressing missing and inconsistent data, and restructuring columns for better organization.

## Queries

### Query 1: Initial Data Inspection
Retrieves all data from the 'NashvilleHousing' table for initial inspection.

### Query 2: Handling Date Format
Adds a new column 'con_saledate' to the table and updates it with converted 'SaleDate' values in DATE format.

### Query 3: Cleaning Property Address Data
Identifies records with missing property addresses, fills in missing addresses from other records with the same ParcelID, and updates the 'PropertyAddress' column.

### Query 4: Splitting Address, City, and State
Splits the 'PropertyAddress' column into separate 'property_address' and 'property_city' columns, enhancing data organization.

### Query 5: Splitting Owner Address, City, and State
Splits the 'OwnerAddress' column into separate 'owner_address', 'owner_city', and 'owner_state' columns for more structured data.

### Query 6: Updating 'SoldAsVacant' Values
Updates 'SoldAsVacant' values from 'Y' and 'N' to 'Yes' and 'No', respectively, for improved clarity.

### Query 7: Removing Duplicate Records
Deletes duplicate records from the 'NashvilleHousing' table, retaining only the records with unique combinations of specified columns.

### Query 8: Removing Unused Columns
Drops the columns 'OwnerAddress', 'TaxDistrict', 'PropertyAddress', and 'SaleDate' from the table, eliminating unused or redundant information.

---
