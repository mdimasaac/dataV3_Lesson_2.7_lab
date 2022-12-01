use sakila;
-- 1. How many films are there for each of the categories in the category table.
select c.name as category, count(fc.film_id) as num_films from film_category fc
join category c
on fc.category_id = c.category_id
group by c.name;

-- 2. Display the total amount rung up by each staff member in August of 2005.
select staff_id, sum(amount) as sum,
date_format((payment_date), "%M %Y") as date from payment 
where date_format((payment_date), "%M") = "August" and
date_format((payment_date), "%Y") = 2005
group by staff_id;

-- 3. Which actor has appeared in the most films?
select concat(a.first_name, " ", a.last_name) as actor_name,
count(fa.film_id) as total_films from film f
join film_actor fa on f.film_id = fa.film_id
join actor a on a.actor_id = fa.actor_id
group by fa.actor_id order by count(fa.film_id) desc;

-- 4. Most active customer (the customer that has rented the most number of films)
select * from rental;
select customer_id, count(rental_date) as num_of_rent from rental
group by customer_id order by count(rental_date) desc limit 1;

-- 5. Display the first and last names, as well as the address, of each staff member.
select concat(st.first_name, " ", st.last_name) as staff_name,
a.address as address from staff st
join address a on 
a.address_id = st.address_id;

-- 6. List each film and the number of actors who are listed for that film.
select f.title as title, count(fa.actor_id) as num_of_actors from film f
join film_actor fa on f.film_id = fa.film_id group by f.film_id 
order by count(fa.actor_id) desc;

-- 7. Using the tables payment and customer and the JOIN command,
--    list the total paid by each customer. List the customers alphabetically by last name.
select c.last_name, c.first_name, sum(p.amount) as total_paid from customer c
join payment p on c.customer_id = p.customer_id group by c.last_name
order by c.last_name asc;

-- 8. List number of films per category.
select * from category;
select c.name, count(f.film_id) as num_of_films from category c
join film_category fc on c.category_id = fc.category_id
join film f on f.film_id = fc.film_id group by c.name
order by c.name asc;