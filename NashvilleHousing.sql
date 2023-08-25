--cleaning data


SELECT *
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]


--date format 
ALTER TABLE NashvilleHousing
  ADD con_saledate DATE;

UPDATE NashvilleHousing
  SET con_saledate = CONVERT(DATE,SaleDate)

SELECT con_saledate
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]


--property adress data
SELECT *
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]
  --WHERE PropertyAddress IS NULL
  ORDER BY ParcelID

SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
  FROM [Portfolio_Project].[dbo].[NashvilleHousing] a
  JOIN [Portfolio_Project].[dbo].[NashvilleHousing] b
        ON a.ParcelID = b.ParcelID
        AND a.[UniqueID] <> b.[UniqueID]
        WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
  FROM [Portfolio_Project].[dbo].[NashvilleHousing] a
  JOIN [Portfolio_Project].[dbo].[NashvilleHousing] b
        ON a.ParcelID = b.ParcelID
        AND a.[UniqueID] <> b.[UniqueID]
        WHERE a.PropertyAddress IS NULL



--address, city, state
SELECT PropertyAddress
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]

SELECT
SUBSTRING(
  PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1
) AS address,
SUBSTRING(
  PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)
) AS city
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]

ALTER TABLE NashvilleHousing
  ADD property_address NVARCHAR(255);

UPDATE NashvilleHousing
  SET property_address = SUBSTRING(
  PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1
)

ALTER TABLE NashvilleHousing
  ADD property_city NVARCHAR(255);

UPDATE NashvilleHousing
  SET property_city = SUBSTRING(
  PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)
)

----------------------------------------------------

SELECT OwnerAddress
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]


ALTER TABLE NashvilleHousing
  ADD owner_address NVARCHAR(255);

UPDATE NashvilleHousing
  SET owner_address = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE NashvilleHousing
  ADD owner_city NVARCHAR(255);

UPDATE NashvilleHousing
  SET owner_city = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE NashvilleHousing
  ADD owner_state NVARCHAR(255);

UPDATE NashvilleHousing
  SET owner_state = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)


--y and n to yes and no in SoldAsVacant field
SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]
  GROUP BY SoldAsVacant
  ORDER BY 2

UPDATE NashvilleHousing
  SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                          WHEN SoldAsVacant = 'N' THEN 'No'
                          ELSE SoldAsVacant
                          END



--remove duplicate

WITH row_numCTE AS(
SELECT *,
  ROW_NUMBER() OVER(
    PARTITION BY ParcelID,
                 PropertyAddress,
                 SaleDate,
                 SalePrice,
                 LegalReference
                 ORDER BY UniqueID
  ) row_num
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]
  --ORDER BY ParcelID
)

DELETE
  FROM row_numCTE
  WHERE row_num > 1


--delete unused column
SELECT *
  FROM [Portfolio_Project].[dbo].[NashvilleHousing]

ALTER TABLE [Portfolio_Project].[dbo].[NashvilleHousing]
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate