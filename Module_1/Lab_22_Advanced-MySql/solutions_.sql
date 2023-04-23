USE publications;

# CHALLENGE 1: MOST PROFITING AUTHORS
# Step 1
SELECT 
    t.title_id,
    au_id,
    (t.advance * ta.royaltyper / 100) AS advance,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM 
    titleauthor ta
JOIN 
    titles t ON t.title_id = ta.title_id
JOIN 
    sales s ON s.title_id = t.title_id;

# Step 2
SELECT 
    title_id,
    au_id,
    SUM(sales_royalty) AS total_royalties
FROM 
    (
        SELECT 
            t.title_id,
            au_id,
            (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
        FROM 
            titleauthor ta
        JOIN 
            titles t ON t.title_id = ta.title_id
        JOIN 
            sales s ON s.title_id = t.title_id
    ) AS step1
GROUP BY 
    title_id,
    au_id;

# Step 3
SELECT 
    au_id,
    SUM(advance + total_royalties) AS total_profits
FROM 
    (
        SELECT 
            t.title_id,
            ta.au_id,
            (t.advance * ta.royaltyper / 100) AS advance,
            SUM(sales_royalty) AS total_royalties
        FROM 
            (
                SELECT 
                    t.title_id,
                    ta.au_id,
                    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
                FROM 
                    titleauthor ta
                JOIN 
                    titles t ON t.title_id = ta.title_id
                JOIN 
                    sales s ON s.title_id = t.title_id
            ) AS royalties
        JOIN 
            titleauthor ta ON ta.title_id = royalties.title_id
        JOIN 
            titles t ON t.title_id = ta.title_id
        GROUP BY 
            t.title_id,
            au_id
    ) AS step2
GROUP BY 
    au_id
ORDER BY 
    total_profits DESC
LIMIT 3;

# CHALLENGE 2: ALTERNATIVE SOLUTION
# Step 1: Create a temporary table for royalties per sale
DROP TEMPORARY TABLE IF EXISTS temp_royalties;
CREATE TEMPORARY TABLE temp_royalties
SELECT 
    t.title_id,
    au_id,
    (t.advance * ta.royaltyper / 100) AS advance,
    (t.price * s.qty * t.royalty / 100 * ta.royaltyper / 100) AS sales_royalty
FROM 
    titleauthor ta
JOIN 
    titles t ON t.title_id = ta.title_id
JOIN 
    sales s ON s.title_id = t.title_id;
    
# Step 2: Create a temporary table for aggregated royalties
DROP TEMPORARY TABLE IF EXISTS temp_agg_royalties;
CREATE TEMPORARY TABLE temp_agg_royalties
SELECT 
    title_id,
    au_id,
    SUM(sales_royalty) AS total_royalties
FROM 
    temp_royalties
GROUP BY 
    title_id,
    au_id;
    
# Step 3: Calculate the total profits of each author
SELECT 
    au_id,
    SUM(advance + total_royalties) AS total_profits
FROM 
    (
        SELECT 
            temp_royalties.title_id,
            temp_royalties.au_id,
            advance,
            total_royalties
        FROM 
            temp_royalties
        JOIN 
            temp_agg_royalties ON temp_agg_royalties.title_id = temp_royalties.title_id
            AND temp_agg_royalties.au_id = temp_royalties.au_id
    ) AS profits
GROUP BY 
    au_id
ORDER BY 
    total_profits DESC
LIMIT 3;

# CHALLENGE 3: 
DROP TABLE IF EXISTS most_profiting_authors;
CREATE TABLE most_profiting_authors (
    au_id VARCHAR(11),
    profits DECIMAL(10, 2));
    
INSERT INTO most_profiting_authors (au_id, profits)
SELECT 
    step2.au_id,
    SUM(advance + total_royalties) AS total_profits
FROM 
    (
        SELECT 
            royalties.title_id,
            royalties.au_id,
            (titles.advance * titleauthor.royaltyper / 100) AS advance,
            SUM(sales_royalty) AS total_royalties
        FROM 
            (
                SELECT 
                    titleauthor.title_id,
                    titleauthor.au_id,
                    (titles.price * sales.qty * titles.royalty / 100 * titleauthor.royaltyper / 100) AS sales_royalty
                FROM 
                    titleauthor
                JOIN 
                    titles ON titles.title_id = titleauthor.title_id
                JOIN 
                    sales ON sales.title_id = titles.title_id
            ) AS royalties
        JOIN 
            titleauthor ON titleauthor.title_id = royalties.title_id AND titleauthor.au_id = royalties.au_id
        JOIN 
            titles ON titles.title_id = titleauthor.title_id
        GROUP BY 
            royalties.title_id,
            royalties.au_id
    ) AS step2
GROUP BY 
    step2.au_id
ORDER BY 
    total_profits DESC
LIMIT 3;