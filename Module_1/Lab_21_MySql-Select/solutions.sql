use publications;

select count(*) from titleauthor; -- there are 25 rows in total for this table

# Challenge 1 - Who Have Published What At Where?
select
	a.au_id as 'AUTHOR ID',
	a.au_fname as 'FIRST NAME',
    a.au_lname as 'LAST NAME',
    t.title as 'TITLE',
    p.pub_name as 'PUBLISHER'
from titleauthor ta
left join authors a on ta.au_id = a.au_id
left join titles t on t.title_id = ta.title_id
left join publishers p on p.pub_id = t.pub_id;
-- there are also 25 rows shown in this query, so we're good!

# Challenge 2 - Who Have Published How Many At Where?
select
	a.au_id as 'AUTHOR ID',
	a.au_fname as 'FIRST NAME',
    a.au_lname as 'LAST NAME',
    p.pub_name as 'PUBLISHER',
    count(t.title) as 'TITLE COUNT'
from titleauthor ta
left join authors a on ta.au_id = a.au_id
left join titles t on t.title_id = ta.title_id
left join publishers p on p.pub_id = t.pub_id
group by a.au_id, a.au_fname, a.au_lname, p.pub_name
order by a.au_id desc;

# Challenge 3 - Best Selling Authors
select
	a.au_id as author_id,
    a.au_fname as first_name,
    a.au_lname as last_name,
    sum(s.qty) as total
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join titles t on t.title_id = ta.title_id
left join sales s on s.title_id = t.title_id
group by
	author_id,
	first_name,
    last_name
order by total desc
limit 3;

# Challenge 4 - Best Selling Authors Ranking
select
	a.au_id as author_id,
    a.au_fname as first_name,
    a.au_lname as last_name,
    coalesce(sum(s.qty), 0) as total
from authors a
left join titleauthor ta on a.au_id = ta.au_id
left join titles t on t.title_id = ta.title_id
left join sales s on s.title_id = t.title_id
group by
	author_id,
	first_name,
    last_name
order by total desc;
-- there are 23 rows in total, as expected, so we're good!
