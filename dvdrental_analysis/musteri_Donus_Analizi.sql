--Müşteri Geri Dönüş Sıklığı Analizi

select 
   c.customer_id ,
   c.first_name ,
   r.rental_date ,

  LAG(r.rental_date) over(
     PARTITION BY c.customer_id 
	 ORDER by r.rental_date
   ) AS before_rate_date 

From customer as c 
join rental as r on c.customer_id = r.customer_id 
order by c.first_name , r.rental_date 