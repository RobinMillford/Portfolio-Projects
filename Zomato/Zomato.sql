use Zomato;
Select * from Zomato;


-- Assuming your table is named "my_table"
ALTER TABLE Zomato
ADD id INT IDENTITY(1,1) PRIMARY KEY;

--For a high-level overview of the hotels,top 5 most voted hotels in the delivery category.
SELECT TOP 5 name, rating, votes
FROM Zomato
WHERE type = 'delivery'
ORDER BY votes DESC;

--top 5 highly rated hotels in the delivery category location Banashankari
SELECT TOP 5 id, name, rating 
FROM Zomato 
WHERE location = 'Banashankari' AND type = 'Delivery' 
ORDER BY rating DESC;

--comparing the ratings of the cheapest and most expensive hotels in Indiranagar.
SELECT 
    MIN(cost_for_two) AS cheapest_hotel_cost,
    MAX(cost_for_two) AS expensive_hotel_cost,
    MIN(rating) AS cheapest_hotel_rating,
    MAX(rating) AS expensive_hotel_rating
FROM 
    Zomato 
WHERE 
    location = 'Indiranagar';

--online_order vs offline_order
SELECT 
    online_order, 
    SUM(votes) AS total_votes
FROM 
    Zomato
GROUP BY 
    online_order;


--Number of votes defines how much the customers are involved with the service provided by the restaurants For each Restaurant type,
--finding out the number of restaurants, total votes, and average rating.
--Display the data with the highest votes on the top( if the first row of output is NA display the remaining rows).
SELECT rest_type AS restaurant_type, COUNT(name) AS number_of_restaurants, SUM(votes) AS total_votes, AVG(rating) AS average_rating
FROM zomato
GROUP BY rest_type
ORDER BY CASE WHEN rest_type = 'NA' THEN 1 ELSE 0 END, total_votes DESC;


--the most liked dish of the most-voted restaurant on Zomato(as the restaurant has a tie-up with Zomato,
--the restaurant compulsorily provides online ordering and delivery facilities.
SELECT dish_liked
FROM zomato
WHERE rating = (SELECT MAX(rating) FROM zomato WHERE online_order = 'Yes')
AND votes = (SELECT MAX(votes) FROM zomato WHERE online_order = 'Yes' AND rating = (SELECT MAX(rating) FROM zomato WHERE online_order = 'Yes'));


--To increase the maximum profit, Zomato is in need to expand its business.
--For doing so Zomato wants the list of the top 15 restaurants which have min 150 votes,
--have a rating greater than 3, and is currently not providing online ordering.
SELECT TOP 15 name, rating, votes
FROM zomato
WHERE online_order = 'NO' AND rating > 3 AND votes >= 150
ORDER BY votes DESC;
