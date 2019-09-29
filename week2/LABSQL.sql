SELECT *
FROM customer;

SELECT customer.customer_id, customer.first_name, customer.last_name
FROM customer

SELECT rental.customer_id
FROM rental

SELECT CONCAT(customer.first_name, ' ', customer.last_name) AS customer_name
FROM customer

/*
Who is the customer that has rented the most number of times in the store?
R: ELEANOR HUNT
*/

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(rental.customer_id)
FROM customer
LEFT JOIN rental ON customer.customer_id = rental.customer_id
GROUP BY customer.customer_id
ORDER BY COUNT(rental.customer_id) DESC

/*
Who is the customer that has spent the most in the store?
R: KARL SEAL
*/

SELECT customer.customer_id, customer.first_name, customer.last_name, COUNT(payment.amount), SUM(payment.amount)
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC;

/*
Who is the customer that has spent the most in average in the store?
R: BRITTANY RILEY
*/

SELECT customer.customer_id, customer.first_name, customer.last_name, ROUND(AVG(payment.amount), 2)
FROM customer
LEFT JOIN payment ON customer.customer_id = payment.customer_id
GROUP BY customer.customer_id
ORDER BY ROUND(AVG(payment.amount), 2) DESC;

/*
Are they the same person? What conclusions can we draw from here?
R: Não, podemos concluir que o número de vezes que um cliente vai na loja, 
não está diretamente relacionado com a quantia gasta em cada visita, ou com o total gasto em todas as visitas.
*/

/*
Retrieve the 5 filmes that have been rented the most
*/

SELECT film.film_id, COUNT(inventory.inventory_id) AS alugueis, film.title
FROM film
LEFT JOIN inventory ON film.film_id = inventory.film_id
RIGHT JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id
ORDER BY alugueis DESC
LIMIT 5;

/*
Retrieve the 5 film categories that have been rented the most
*/

SELECT category.name, COUNT(film_category.film_id) AS alugueis_por_categoria
FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN film ON film_category.film_id =  film.film_id 
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY category.name
ORDER BY alugueis_por_categoria DESC
LIMIT 5;

/*
Get the top 5 customers and try to see what are the categories of movies that they like.
*/

