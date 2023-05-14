USE sakila;

# QUESTION 1
/*
Find the running total of rental payments for each customer in the payment table, ordered by payment date.

By selecting the customer_id, payment_date, and amount columns from the payment table,
and then applying the SUM function to the amount column within each customer_id partition, ordering by payment_date.
*/

SELECT customer_id, payment_date, amount, SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS total_rentalPayments
FROM payment;

# QUESTION 2
/*
Find the rank and dense rank of each payment amount within each payment date by selecting the payment_date and amount columns from the payment table, 
and then applying the RANK and DENSE_RANK functions to the amount column within each payment_date partition, ordering by amount in descending order.
Hint: you need to extract only the date from the payment_date
*/

SELECT date_format(payment_date, '%Y-%m-%d' ) AS pay_date, amount,
RANK() OVER (PARTITION BY date_format(payment_date, '%Y-%m-%d' ) ORDER BY amount DESC) AS "rnk",
DENSE_RANK() OVER (PARTITION BY date_format(payment_date, '%Y-%m-%d' ) ORDER BY amount DESC) AS "dense_rnk"
FROM payment;

# QUESTION 3
/*
Find the ranking of each film based on its rental rate, within its respective category.
Hint: you need to extract the information from the film,film_category and category tables after applying join on them.
*/

SELECT c.name, f.title, f.rental_rate,
RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS "rnk",
DENSE_RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS "dense_rnk"
FROM film f
LEFT JOIN film_category fc USING (film_id)
LEFT JOIN category c USING (category_id)
ORDER BY c.name, f.rental_rate DESC, f.title;

# QUESTION 4
/*
(OPTIONAL)
Update the previous query from above to retrieve only the top 5 films within each category
Hint: you can use ROW_NUMBER function in order to limit the number of rows.
*/

SELECT *
FROM(
SELECT c.name, f.title, f.rental_rate,
RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS "rnk",
DENSE_RANK() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC) AS "dense_rnk",
ROW_NUMBER() OVER (PARTITION BY c.name ORDER BY f.rental_rate DESC, f.title) AS "row_num"
FROM film f
LEFT JOIN film_category fc USING (film_id)
LEFT JOIN category c USING (category_id)) x
WHERE row_num <= 5
ORDER BY name, title, row_num;

# QUESTION 5
/*
Find the difference between the current and previous payment amount and the difference between the current and next payment amount, for each customer in the payment table
Hint: select the payment_id, customer_id, amount, and payment_date columns from the payment table,
and then applying the LAG and LEAD functions to the amount column, partitioning by customer_id and ordering by payment_date.
*/

SELECT  payment_id, customer_id, amount, payment_date,
amount - LAG(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_prev,
amount - LEAD(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS diff_from_next
FROM payment;
