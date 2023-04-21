use olist;

# 1. From the order_items table, find the price of the highest priced order and lowest price order.
select price
from order_items
order by price desc;

# 2. From the order_items table, what is range of the shipping_limit_date of the orders?
select
	max(shipping_limit_date) as MAX_shipping_limit_date, 
    min(shipping_limit_date) as MIN_shipping_limit_date
from order_items;

# 3. From the customers table, find the states with the greatest number of customers.
select customer_state, count(customer_state) as nb_customers
from customers
group by customer_state
order by nb_customers desc
limit 5;

# 4. From the customers table, within the state with the greatest number of customers, find the cities with the greatest number of customers.
select customer_state, customer_city, count(customer_state) as nb_customers
from customers
where customer_state = 'SP'
group by customer_city
order by nb_customers desc;

# 5. From the closed_deals table, how many distinct business segments are there (not including null)?
select count(distinct business_segment) as nb_business_segment
from closed_deals;

# 6. From the closed_deals table, sum the declared_monthly_revenue for duplicate row values in business_segment and find the 3 business segments with the highest declared monthly revenue (of those that declared revenue).
select business_segment, sum(declared_monthly_revenue) as total_declared_monthly_revenue
from closed_deals
group by business_segment
order by total_declared_monthly_revenue desc
limit 3;

# 7. From the order_reviews table, find the total number of distinct review score values.
select count(distinct review_score)
from order_reviews;

# 8. In the order_reviews table, create a new column with a description that corresponds to each number category for each review score from 1 - 5, then find the review score and category occurring most frequently in the table.
select
	review_score,
case
	when review_score = 1 then "Terrible"
    when review_score = 2 then "Bad"
    when review_score = 3 then "Needs improvement"
    when review_score = 4 then "Good"
    else "Excellent"
    end as review_description,
    count(review_score) as nb_reviews
from order_reviews
group by review_score
order by nb_reviews desc
limit 1;
    
# 9. From the order_reviews table, find the review value occurring most frequently and how many times it occurs.
select review_score, count(review_score) as nb_reviews
from order_reviews
group by review_score
order by nb_reviews desc
limit 1;