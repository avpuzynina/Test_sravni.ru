select *
from Sravni.dbo.orders

select *
from Sravni.dbo.users

select id, surname
from (
	select id, surname, amount, row_number() over (partition by id order by surname) as max_amount
	from Sravni.dbo.orders a
	full join Sravni.dbo.users b
	on a.phone LIKE '%' + b.phone + '%'
	where b.sex='woman'
)

select id, surname, b.phone, amount
from Sravni.dbo.orders a
full join Sravni.dbo.users b
on a.phone LIKE '%' + b.phone + '%'
where b.sex='woman'


with women as (
	select id, surname, b.phone, amount
	from Sravni.dbo.orders a
	full join Sravni.dbo.users b
	on a.phone LIKE '%' + b.phone + '%'
	where b.sex='woman'
)
select id, surname
from women
INNER JOIN
	(
		SELECT phone, MAX(amount) as max_amount
		from women as w
		GROUP BY phone
	) grouped_users
ON women.phone = grouped_users.phone
AND women.amount = grouped_users.max_amount

