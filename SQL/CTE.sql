
--			drop table publish.temp123
create table publish.temp123 as
(
--		insert into  publish.temp123
	sel  pat_id, previous_total_rev, row_number()over (order by previous_total_rev ) as rnk
	from publish.bs_rev_rx_post_agege55 
) with no data primary index (pat_id);
	
	with recursive abc (a,b,c,d) as
	(
	sel  pat_id, previous_total_rev as b, previous_total_rev as c,rnk
	from publish.temp123
	where rnk=1
		
	union all
	
	sel  
	x.pat_id, 
	x.previous_total_rev,
	x.previous_total_rev+y.c,
	x.rnk
	from publish.temp123  as x
	inner join abc as y
	on x.rnk=y.d+1

		
	) 
	
	sel * from abc 
	order by d
	
	
	
	
	

			
