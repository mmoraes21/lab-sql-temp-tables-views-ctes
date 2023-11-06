# LAB - CTE, Temp Tables, Views
USE sakila;
​
/*#First, create a view that summarizes rental information for each customer. 
#The view should include the customer's ID, name, email address, and total number of rentals (rental_count).*/
​
SELECT r.customer_id, CONCAT(c.first_name, " ", c.last_name) as fullname, c.email
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id;
​
​
SELECT c.email, COUNT(*) as rental_count, c.first_name, c.customer_id
FROM rental r
INNER JOIN customer c
ON r.customer_id = c.customer_id
GROUP BY c.customer_id;
​
CREATE VIEW total_rental_customer AS (
	SELECT r.customer_id, CONCAT(c.first_name, " ", c.last_name) as fullname, c.email, COUNT(*) as rental_count
	FROM rental r
	INNER JOIN customer c
	ON r.customer_id = c.customer_id
	GROUP BY r.customer_id
	ORDER BY rental_count DESC);
    
SELECT * FROM total_rental_customer;
​
#2 --------------------------------
/*Next, create a Temporary Table that calculates the total amount paid by each customer (total_paid). 
The Temporary Table should use the rental summary view created in Step 1 to join with the payment 
table and calculate the total amount paid by each customer. */
​
CREATE TEMPORARY TABLE total_amount_customer AS (
		SELECT SUM(p.amount) AS total_paid, t.fullname
		FROM total_rental_customer t
		INNER JOIN payment p
		ON t.customer_id = p.customer_id
		GROUP BY t.customer_id
		ORDER BY total_paid DESC);
        
SELECT * FROM total_amount_customer;

