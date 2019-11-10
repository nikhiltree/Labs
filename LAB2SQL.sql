/* 
Challenge 1 - Who Have Published What At Where
*/

SELECT *
FROM authors;

SELECT *
FROM titles;

SELECT *
FROM titleauthor;

SELECT *
FROM publishers;

DROP TABLE IF EXISTS author_title_id;

SELECT authors.au_id AS author_id, authors.au_lname AS last_name, authors.au_fname AS first_name, titleauthor.title_id
INTO TEMP TABLE author_title_id
FROM authors
LEFT JOIN titleauthor ON authors.au_id = titleauthor.au_id;

SELECT *
FROM author_title_id

DROP TABLE IF EXISTS author_id_titles;

SELECT author_id, last_name, first_name, author_title_id.title_id, titles.pub_id, titles.title
INTO TEMP TABLE author_id_titles
FROM author_title_id
LEFT JOIN titles ON author_title_id.title_id = titles.title_id

SELECT *
FROM author_id_titles

SELECT author_id, last_name, first_name, author_id_titles.title, publishers.pub_name
INTO TEMP TABLE all_infos
FROM author_id_titles
LEFT JOIN publishers ON author_id_titles.pub_id = publishers.pub_id

SELECT *
FROM all_infos

/* 
Challenge 2 - Who Have Published How Many At Where?
*/

DROP TABLE IF EXISTS ex_2;

SELECT author_id, last_name, first_name, all_infos.pub_name, COUNT(all_infos.pub_name)
INTO TEMP TABLE ex_2
FROM all_infos, publishers
GROUP BY author_id, last_name, first_name, all_infos.pub_name
ORDER BY COUNT(all_infos.pub_name) DESC

SELECT *
FROM ex_2

/* 
Challenge 3 - Best Selling Authors
*/

DROP TABLE IF EXISTS ex_3;


SELECT author_id, last_name, first_name, COUNT(sales.qty) AS total
INTO TEMP TABLE ex_3
FROM author_id_titles
LEFT JOIN sales ON author_id_titles.title_id = sales.title_id
GROUP BY author_id, last_name, first_name
ORDER BY total DESC
LIMIT 3;

SELECT *
FROM ex_3;

/* 
Challenge 4 - Best Selling Authors Ranking
*/

DROP TABLE IF EXISTS ex_4;


SELECT author_id, last_name, first_name, COUNT(sales.qty) AS total
INTO TEMP TABLE ex_4
FROM author_id_titles
LEFT JOIN sales ON author_id_titles.title_id = sales.title_id
GROUP BY author_id, last_name, first_name
ORDER BY total DESC
LIMIT 23;

SELECT *
FROM ex_4;

/* 
Challenge 5 - Most Profiting Authors
*/

DROP TABLE IF EXISTS ex_5;


SELECT author_id_titles.author_id, author_id_titles.title_id, ((titles.price * sales.qty * titles.royalty) / 100) * (titleauthor.royaltyper / 100) AS sales_royalty
FROM all_infos, author_id_titles, sales, titles, titleauthor


SELECT *
FROM ex_5;

