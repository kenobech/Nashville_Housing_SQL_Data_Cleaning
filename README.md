## Nashville_Housing_Data_Cleaning_and_Visualization_SQL
# Introduction
This project involves cleaning and visualizing data from the Nashville Housing dataset using SQL queries. This dataset contains comprehensive information about properties in Nashville, including sale prices, property characteristics, and owner details. The aim of this project is to prepare the data for analysis and create visualizations to gain insights into the Nashville housing market.
# Dataset
This dataset has 56478 rows and 19 columns. The columns include: UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, LegalReference, SoldAsVacant, OwnerName, OwnerAddress, Acreage, TaxDistrict, LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath and, HalfBath.
# Data_Cleaning
The following procedures were used for data cleaning:
a. Standardize Date Format
    Standardized the date format of the "SaleDate" column.

b. Populate Property Address Data

    Populated missing property address data based on ParcelID matching.

c. Break Address into Individual Columns

    Split the property address into individual columns for Address, City, and State.

d. Change "SoldAsVacant" Values

    Changed "Y" and "N" values in the "SoldAsVacant" column to "Yes" and "No" respectively.

e. Remove Duplicates

    Removed duplicate records based on certain criteria.

f. Delete Unused Columns

    Deleted unused columns for practice purposes.
# Visualization
The cleaned data was visualized using SQL queries to understand various aspects of the Nashville housing market:

    Market Trends: Analyzed the distribution of SalePrice over time.
    Popular Property Types: Identified the most common property types in Nashville.
    Property Values: Evaluated property values based on land use categories.
    Owner Demographics: Explored patterns in property owner locations.
    Market Competitiveness: Analyzed the distribution of SalePrice by property split city.
    
