use Ironhack_DB;

# 1. What are the different genres?
select distinct(prime_genre) from applestore;

# 2. Which is the genre with the most apps rated?
select
	prime_genre,
    sum(rating_count_tot) as "total ratings per genre"
from applestore
group by prime_genre
order by sum(rating_count_tot) desc
limit 1;

# 3. Which is the genre with most apps?
select
	prime_genre,
    count(track_name) as nb_apps
from applestore
group by prime_genre
order by nb_apps desc
limit 1;

# 4. Which is the one with least?
select
	prime_genre,
    count(track_name) as nb_apps
from applestore
group by prime_genre
order by nb_apps
limit 1;

# 5. Find the top 10 apps most rated.
select
	track_name,
    sum(rating_count_tot) as "total ratings per app"
from applestore
group by track_name
order by sum(rating_count_tot) desc
limit 10;

# 6. Find the top 10 apps best rated by users.
select
	track_name,
    user_rating
from applestore
order by user_rating desc 
limit 10;

# 7. Take a look at the data you retrieved in question 5. Give some insights.
select
	track_name,
    prime_genre,
    sum(rating_count_tot) as "total ratings per app"
from applestore
group by track_name, prime_genre
order by sum(rating_count_tot) desc
limit 10;

# 8. Take a look at the data you retrieved in question 6. Give some insights.
select
	track_name,
    prime_genre,
    user_rating
from applestore
order by user_rating desc 
limit 10;

# 9. Now compare the data from questions 5 and 6. What do you see?
/*
queries are fetched from questions 5 and 6, and excetuted them in a seprate tab to compare
*/

# 10. How could you take the top 3 regarding both user ratings and number of votes?
select
	track_name,
    user_rating,
    sum(rating_count_tot) as "total ratings per app"
from applestore
group by track_name, user_rating
order by user_rating /*sum(rating_count_tot)*/ desc 
limit 3;

# 11. Do people care about the price of an app? Do some queries, comment why are you doing them and the results you retrieve. What is your conclusion?
select
	track_name,
    prime_genre,
    price,
    user_rating,
    sum(rating_count_tot) as "total ratings per app"
from applestore
group by track_name, prime_genre, price, user_rating
order by user_rating desc, sum(rating_count_tot) desc;
    