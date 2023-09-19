use sakila;

-- List the number of films per category.
select c.name, count(fc.film_id) as "number of film"
from category as c
join film_category as fc
on c.category_id=fc.category_id
group by c.name
order by count(fc.film_id) desc;

-- Retrieve the store ID, city, and country for each store.
select s.store_id , ci.city, co.country
from country as co
join city as ci on co.country_id=ci.country_id
join address as a on a.city_id= ci.city_id
join store as s on a.address_id=s.address_id;

-- Calculate the total revenue generated by each store in dollars.
select s.store_id , sum(p.amount) as "Total amount ($)" 
from staff as s
join payment as p on s.staff_id= p.staff_id
group by store_id;

-- Determine the average running time of films for each category.
select c.name, round(avg(f.length),2) as "average running time"
from category as c
join film_category as fc
on c.category_id=fc.category_id
join film as f on f.film_id= fc.film_id
group by c.name
order by avg(f.length) desc;

-- Identify the film categories with the longest average running time.
select c.name, round(avg(f.length),2) as "average running time"
from category as c
join film_category as fc
on c.category_id=fc.category_id
join film as f on f.film_id= fc.film_id
group by c.name
order by avg(f.length) desc
limit 1;

-- Display the top 10 most frequently rented movies in descending order.
select title, rental_rate from film
order by rental_rate desc
limit 10;

-- Determine if "Academy Dinosaur" can be rented from Store 1.
select 
case
when count(*) > 0 then 'available'
else 'unavailable'
end as rental_status
from film as f
join inventory as i on f.film_id= i.film_id
join store as s on s.store_id=i.store_id
where f.title ='Academy Dinosaur' and s.store_id=1;


-- Provide a list of all distinct film titles, along with their availability status in the inventory. Include a column indicating whether each title is 'Available' or 'NOT available.'
select
    f.title as film_title,
    case
        when ifnull(count(i.inventory_id), 0) > 0 then 'available'
        else 'not available'
    end as availability_status
from
    film as f
left join inventory as i on f.film_id = i.film_id
group by f.title;