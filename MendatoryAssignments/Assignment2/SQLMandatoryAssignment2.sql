SELECT * FROM JOMATO
--1. Create a user-defined functions to stuff the Chicken into ‘Quick Bites’. --Eg: 'Quick Chicken Bites’.  

CREATE or ALTER FUNCTION INSERTCHICKEN 
(@NAME VARCHAR(100)) 
RETURNS VARCHAR (100) 
AS  
BEGIN 
DECLARE @NEWNAME VARCHAR(100) 
IF @NAME = 'Quick Bites' 
SET @NEWNAME = STUFF(@NAME,6,0,' Chicken') 
ELSE  SET @NEWNAME = @NAME 
RETURN @NEWNAME 
END; 

select  dbo.INSERTCHICKEN('QUICK BITES') AS Result; 

--2. Use the function to display the restaurant name and cuisine type which has the
--maximum number of rating.

CREATE or ALTER FUNCTION getmaxRating()
RETURNS DECIMAL(2,1)
as 
BEGIN
DECLARE @max DECIMAL(2,1)
SELECT @max = MAX(rating) from JOMATO
RETURN @max
END;

SELECT RestaurantName,CuisinesType,Rating
from JOMATO
WHERE rating = dbo.getmaxRating()

--3. Create a Rating Status column to display the rating as ‘Excellent’ if it has more the 4
--start rating,‘Good’ if it has above 3.5 and below 5 star rating,and below 3.5 and ‘Bad’ if it is below 3 star rating

select RestaurantName ,Rating ,
Case 
when Rating >4 then 'Excellent'
when Rating > 3.5 then 'Good'
when Rating >=3 then 'Average'
else 'Bad'
END RatingStatus
from JOMATO
    
--4. Find the Ceil, floor and absolute values of the rating column and display the current date
--and separately display the year, month_name and date
SELECT 
RestaurantName,Rating,
CEILING(Rating) CEILINGRating,
FLOOR(Rating) floorRating,
ABS(Rating) AbosulateRating,
GETDATE() CURRENTDate ,
YEAR(GETDATE()) CurrentYear,
datename(month,GETDATE()) CurrentMonth,
DAY(GETDATE()) CurrentDay
from JOMATO 

--5. Display the restaurant type and total average cost using rollup.
SELECT  restaurantType,SUM(AverageCost) TotalAverageCost
from JOMATO
GROUP BY rollup(restaurantType)