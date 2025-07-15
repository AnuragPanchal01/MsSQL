
--1. Create a stored procedure to display the restaurant name, type and cuisine where the
--table booking is not zero.

CREATE or ALTER PROCEDURE getdata
as 
BEGIN
select RestaurantName , Restauranttype , cuisinesType FROM Jomato3
WHERE tableBooking = 'yes'
END
exec getdata

--2. Create a transaction and update the cuisine type ‘Cafe’ to ‘Cafeteria’.Check the result
--and rollback it.

Begin  TRANSACTION 
UPDATE jomato3
set cuisinesType = 'Cafeteria'
WHERE cuisinesType = 'Cafe'

ROLLBACK

--3. Generate a row number column and find the top 5 areas with the highest rating of
--restaurants.

SELECT top 5 area,Rating,ROW_NUMBER() OVER ( ORDER By rating DESC) Numbering FROM jomato3

--4.Use the while loop to display the 1 to 50
DECLARE @n INT = 1
WHILE(@n<=50)
BEGIN
print(@n)
SET @n = @n+1
END

--5.Write a query to Create a Top rating view to store the generated top 5 highest rating of
--restaurants.
CREATE or ALTER VIEW TopRatingView
AS 
SELECT top 5 * FROM jomato3
ORDER by rating DESC

SELECT * from TopRatingView

--6.Create a trigger that give an message whenever a new record is inserted.
CREATE or ALTER TRIGGER messageAlert
ON jomato3
after INSERT
as 
BEGIN 
print 'New record has been inserted in to jomato3 '
END

