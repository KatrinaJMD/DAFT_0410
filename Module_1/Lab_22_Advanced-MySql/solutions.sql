USE publications;

# Challenge 1 (SUBQUERIES) - Most Profiting Authors

# Authors and their books...
select a.au_id, a.au_fname, a.au_lname, t.title, t.price
from authors a
inner join titleauthor ta using (au_id) -- on a.au_id = ta.au_id
inner join titles t using (title_id);


# Authors and their books 2....
select a.au_id, a.au_fname, a.au_lname, t.title, t.price
from authors a
left join titleauthor ta using (au_id) -- on a.au_id = ta.au_id
left join titles t using (title_id);

# STEP 1: Calculate royalty of each sale for each author and the advance for each author and publication
SELECT 
    t.title_id,
    ta.au_id,
    (t.advance * ta.royaltyper / 100) AS advance,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN sales s ON t.title_id = s.title_id;

# STEP 2: Aggregate total royalties for each title and author
SELECT
	title_id,
    au_id,
    SUM(sales_royalty) AS total_royalty
FROM
	(SELECT 
		t.title_id,
		ta.au_id,
		(t.advance * ta.royaltyper / 100) AS advance,
		(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
	FROM titles t
	LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
	LEFT JOIN sales s ON t.title_id = s.title_id) AS Step1
GROUP BY
	title_id,
	au_id
ORDER BY au_id DESC;

# STEP 3: Calculate the total profits of each author
SELECT
	au_id,
    SUM(advance + total_royalty) AS profits
FROM
	(SELECT
		title_id,
		au_id,
		advance,
		SUM(sales_royalty) AS total_royalty
	FROM
		(SELECT 
			t.title_id,
			ta.au_id,
			(t.advance * ta.royaltyper / 100) AS advance,
			(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
		FROM titles t
		LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
		LEFT JOIN sales s ON t.title_id = s.title_id) AS Step1
	GROUP BY
		title_id,
		au_id,
        advance) AS Step2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;


# Challenge 2 (TEMPORARY TABLES) - Alternative Solution

# STEP 1: Calculate royalty of each sale for each author and the advance for each author and publication
DROP TEMPORARY TABLE IF EXISTS TempStep1;
CREATE TEMPORARY TABLE TempStep1 AS
SELECT 
    t.title_id,
    ta.au_id,
    (t.advance * ta.royaltyper / 100) AS advance,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM titles t
LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
LEFT JOIN sales s ON t.title_id = s.title_id;

# STEP 2: Aggregate total royalties for each title and author
DROP TEMPORARY TABLE IF EXISTS TempStep2;
CREATE TEMPORARY TABLE TempStep2 AS
SELECT
	title_id,
    au_id,
    advance,
    SUM(sales_royalty) AS total_royalty
FROM TempStep1
GROUP BY
	title_id,
    au_id,
    advance
ORDER BY au_id DESC;

# STEP 3: Calculate the total profits of each author
SELECT 
	au_id,
    SUM(advance + total_royalty) AS profits
FROM TempStep2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;


/*
QUICK NOTE FOR MY READERS :
-----------------------------------------------------------------------------------------------------------------------------------------------------
For the final challenge, both solutions (Challenge 1: subqueries and Challenge 2: temporary tables) are valid and will produce the same result.
However, there are some differences that might make one more suitable than the other depending on the situation.

-------------
COMPLEXITY: |
-------------
Using subqueries (Challenge 1) can be considered more straightforward as it involves writing a single query to insert the data into the table.
On the other hand, temporary tables (Challenge 2) require creating temporary tables first and then inserting the data, making it a bit more complex.

--------------
PERFORMANCE: |
--------------
If our data are massive and queries are complicated, using temporary tables (Challenge 2) can provide significant performance benefits.
This is because time-consuming calculations are performed only once, and the results are persistent.
When we query temporary tables repeatedly, we will not perform expensive transactions again and again in our database.

In the context of the final challenge,
since we only need to populate the most_profiting_authors table once,
the performance difference between the two solutions might not be significant.

In this case,
we could choose the subqueries solution (Challenge 1) for its simplicity.

However,
if we anticipate needing to recalculate and update the most_profiting_authors table frequently,
or if the database size and complexity grow over time,
we might consider using the temporary tables solution (Challenge 2) to improve performance.
-----------------------------------------------------------------------------------------------------------------------------------------------------
KATRINA J, Author
*/

# Challenge 3 (PERMANENT TABLE based on Challenge 1 and 2 solutions)

DROP TABLE IF EXISTS most_profiting_authors;
CREATE TABLE most_profiting_authors (
	au_id VARCHAR(11) NOT NULL,
    profits DECIMAL(20, 5) NOT NULL);
    
INSERT INTO most_profiting_authors (au_id, profits)
SELECT
	au_id,
    SUM(advance + total_royalty) AS profits
FROM
	(SELECT
		title_id,
		au_id,
		advance,
		SUM(sales_royalty) AS total_royalty
	FROM
		(SELECT 
			t.title_id,
			ta.au_id,
			(t.advance * ta.royaltyper / 100) AS advance,
			(t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
		FROM titles t
		LEFT JOIN titleauthor ta ON t.title_id = ta.title_id
		LEFT JOIN sales s ON t.title_id = s.title_id) AS Step1
	GROUP BY
		title_id,
		au_id,
        advance) AS Step2
GROUP BY au_id
ORDER BY profits DESC
LIMIT 3;

# Verify results
SELECT * FROM most_profiting_authors;