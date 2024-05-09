/*

Cleaning Data in SQL

NashVille Housing

*/

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing;

-- Standardize the Date Format

SELECT SaleDate
FROM [Portfolio Project].dbo.NashvilleHousing;

SELECT SaleDate, CONVERT(date,SaleDate)
FROM [Portfolio Project].dbo.NashvilleHousing;

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT (date,SaleDate);

SELECT SaleDateConverted, CONVERT(date, SaleDate)
FROM [Portfolio Project].dbo.NashvilleHousing;


------------------------------------------------------------------------------------------------------

-- Populate Property Adress Data

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE PropertyAddress is null;

SELECT PropertyAddress
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE PropertyAddress is null;

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE PropertyAddress is null
ORDER BY ParcelID;


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Portfolio Project].dbo.NashvilleHousing a
Join [Portfolio Project].dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
And a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is null;

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].dbo.NashvilleHousing a
Join [Portfolio Project].dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
And a.[UniqueID ]<> b.[UniqueID ]
WHERE a.PropertyAddress is null;

----------------------------------------------------------------------------------------------------------------------------

-- Breaking Adress into Individual Columns (Adress, City, State) Using SubString

-- Adress

SELECT 
SUBSTRING (PropertyAddress, 1, CHARINDEX ( ',',PropertyAddress) -1) AS Adress
FROM [Portfolio Project].dbo.NashvilleHousing;


-- City

SELECT 
SUBSTRING (PropertyAddress, 1, CHARINDEX ( ',',PropertyAddress) -1) as Adress
,SUBSTRING (PropertyAddress, CHARINDEX ( ',',PropertyAddress) +1, LEN(PropertyAddress)) as Adress
FROM [Portfolio Project].dbo.NashvilleHousing;

-- Rename the Column

ALTER TABLE NashvilleHousing
ADD PropertySplitAdress Nvarchar (255)

UPDATE NashvilleHousing
SET PropertySplitAdress = SUBSTRING (PropertyAddress, 1, CHARINDEX ( ',',PropertyAddress) -1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar (255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING (PropertyAddress, CHARINDEX ( ',',PropertyAddress) +1, LEN(PropertyAddress))

SELECT OwnerAddress
FROM [Portfolio Project].dbo.NashvilleHousing

SELECT 
ParseName (Replace (OwnerAddress, ',','.'),3)
,ParseName (Replace (OwnerAddress, ',','.'),2)
,ParseName (Replace (OwnerAddress, ',','.'),1)
FROM [Portfolio Project].dbo.NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAdress Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitAdress = ParseName (Replace (OwnerAddress, ',','.'),1)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitCity = ParseName (Replace (OwnerAddress, ',','.'),2)

ALTER TABLE NashvilleHousing
Add OwnerSplitstate Nvarchar (255);

UPDATE NashvilleHousing
SET OwnerSplitState = ParseName (Replace (OwnerAddress, ',','.'),3)

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing;


----------------------------------------------------------------------------------------------------------------------------

--Change Y and N to Yes and No in the column, "SoldAsVacant"

SELECT DISTINCT(SoldAsVacant), COUNT (SoldAsVacant)
FROM [Portfolio Project].dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2;

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END
FROM[Portfolio Project].dbo.NashvilleHousing;

UPDATE NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' Then 'Yes'
     WHEN SoldAsVacant = 'N' THEN 'No'
	 ELSE SoldAsVacant
	 END;

-----------------------------------------------------------------------------------------------------------------------------

--Remove Duplicates

WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
			  UniqueID
			  )row_num

FROM [Portfolio Project].dbo.NashvilleHousing
 )
DELETE 
FROM RowNumCTE
WHERE row_num>1


WITH RowNumCTE AS(
SELECT *,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY
			  UniqueID
			  )row_num

FROM [Portfolio Project].dbo.NashvilleHousing
 )
SELECT * 
FROM RowNumCTE
WHERE row_num>1

-------------------------------------------------------------------------------------------------------------------
--Delete Unused Columns (This is only used for practise purposes)

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate;


/*

After cleaning this data, it is important to write querries that will help in visualization.

The visualisations will help understand the following:

1. Understanding the MArket Trends
2. Popular Property types
3. Evaluating Property Values
4. Understanding the owner demographics
5. Evaluating marketcompetitiveness

*/

--Select the relevant columns

SELECT *
FROM [Portfolio Project].dbo.NashvilleHousing;

SELECT UniqueID, ParcelID, LandUse, SalePrice, LegalReference, SoldAsVacant, OwnerName, Acreage, 
       LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath, HalfBath, SaleDateConverted, 
       PropertySplitAdress, PropertySplitCity, OwnerSplitAdress, OwnerSplitCity, OwnerSplitState
FROM [Portfolio Project].dbo.NashvilleHousing;

-- Filter and Select data where SalePrice is Greater that zero

SELECT UniqueID, ParcelID, LandUse, SalePrice, LegalReference, SoldAsVacant, OwnerName, Acreage, 
       LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath, HalfBath, SaleDateConverted, 
       PropertySplitAdress, PropertySplitCity, OwnerSplitAdress, OwnerSplitCity, OwnerSplitState
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE SalePrice > 0;

-- Order Data by SalePrice

SELECT UniqueID, ParcelID, LandUse, SalePrice, LegalReference, SoldAsVacant, OwnerName, Acreage, 
       LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath, HalfBath, SaleDateConverted, 
       PropertySplitAdress, PropertySplitCity, OwnerSplitAdress, OwnerSplitCity, OwnerSplitState
FROM [Portfolio Project].dbo.NashvilleHousing
ORDER BY SalePrice DESC;

--  Table 1: Aggregate date by checking on the averagesaleprice per land use

SELECT LandUse, AVG(SalePrice) AS AvgSalePrice
FROM [Portfolio Project].dbo.NashvilleHousing
GROUP BY LandUse;

-- Table 2: Understanding the distribution of SalePrice over time (Understanding Housing Market Trends)

SELECT SaleDateConverted, SalePrice
FROM [Portfolio Project].dbo.NashvilleHousing;

/* Table 3: Understand Owner Demographics
This is useful in exploring patterns of owner locations of the Property Owners in Nashville
*/

SELECT OwnerSplitState, COUNT(*) AS PropertyCount 
FROM [Portfolio Project].dbo.NashvilleHousing 
GROUP BY OwnerSplitState;

SELECT
'Nashville' AS Region,
    COUNT(*) AS PropertyCount 
FROM [Portfolio Project].dbo.NashvilleHousing;

/* Table 4: Evaluating Market competitiveness
Analyzing distribution of SalePrice by PropertySplitCity to determine areas where properties are selling higher or below the average market value
*/

SELECT PropertySplitCity, AVG(SalePrice) AS AvgSalePrice 
FROM [Portfolio Project].dbo.NashvilleHousing
GROUP BY PropertySplitCity
ORDER BY AvgSalePrice ASC;

/* Table 5: Popular Property Types
Identify the most common properties in Nashville
*/

SELECT LandUse, COUNT(*) AS PropertyCount 
FROM [Portfolio Project].dbo.NashvilleHousing 
GROUP BY LandUse
ORDER BY PropertyCount ASC;