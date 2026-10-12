/*
 * For each film, show the customer who most recently rented it.
 *
 * HINT:
 * Use the first_value function.
 * The window will include both PARTITION BY and ORDER BY
 */
SELECT DISTINCT title,
       first_value(customer_id) OVER w AS customer_id,
       first_value(first_name || ' ' || last_name) OVER w AS customer_name
FROM film
JOIN inventory USING (film_id)
JOIN rental USING (inventory_id)
JOIN customer USING (customer_id)
WINDOW w AS (PARTITION BY film_id ORDER BY rental_date DESC)
ORDER BY title;
