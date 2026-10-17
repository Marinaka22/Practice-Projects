--Identify the top 20 comedies rented based sales
--What was the average sales for the films? Identify one other interesting finding about the films.

select amount

SELECT f.title,
       SUM(p.amount) AS total_sales
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
WHERE c.name = 'Comedy'
GROUP BY f.title
ORDER BY total_sales DESC
LIMIT 20;

with CTE as (
SELECT f.title,
       c.name AS category,
       s.last_name || ', ' || s.first_name AS salesperson,
       COUNT(r.rental_id) AS num_rental,
       SUM(p.amount) AS Sales
FROM film f
LEFT JOIN film_category fc ON fc.film_id = f.film_id
LEFT JOIN category c ON c.category_id = fc.category_id
LEFT JOIN inventory inv ON inv.film_id = f.film_id
LEFT JOIN rental r ON r.inventory_id = inv.inventory_id
LEFT JOIN payment p ON p.rental_id = r.rental_id
inner join staff s on s.staff_id = p.staff_id
WHERE c.name = 'Comedy'
GROUP BY f.title, c.name, s.last_name, s.First_name
ORDER BY Sales DESC
LIMIT 20)
select *, avg(sales) over (partition by category) as avg
from CTE;

---LAG
with CTE as (
select f.title,
       c.name as category,
       r.rental_date,
       lag(r.rental_date) over (partition by f.title order by r.rental_date) as rental_lag,
       lead(r.rental_date) over (partition by f.title order by r.rental_date) as rental_lead
from film f
left join film_category fc on fc.film_id = f.film_id
left join category c on c.category_id = fc.category_id
left join inventory inv on inv.film_id = f.film_id
left join rental r on r.inventory_id = inv.inventory_id
left join payment p on p.rental_id = r.rental_id
inner join staff s on s.staff_id = p.staff_id
where c.name = 'Comedy'
order by f.title, r.rental_date)
select *,
       (rental_date::date - rental_lag::date) as num_days_lag,
       (rental_lead::date - rental_date::date) as num_days_lead,
       first_value(title) over (order by title, rental_date) as first_film_value,
       last_value(title) over (order by title, rental_date
            rows between unbounded preceding and unbounded following) as last_film_value,
       nth_value(rental_date, 5) over (order by title, rental_date
            range between unbounded preceding and unbounded following) as fifth_date
from cte;

