--  finding all teradata IDs that have codes that are running currently			(does not show Putty)

  select * from dbc.SessionInfo 
  where username in ('axnair', 'axroy','mkbharath','pxsaurabh','rxthomas','sxshankar','txsira','vxashok','hxsubra','sxsabberwal','rxncstr','sxmani')

--checking space and skew of tables


select creatorname,sum(tablesizegb) from 
(
-------Please run from here
select  
 a.DataBaseName
,a.TableName
,a.CreatorName
,a.CreateTimeStamp
,a.LastAccessTimeStamp
,a.AccessCount
,cast(b.TableSize as decimal(15,0)) as TableSize
,TableSize/(1024**3) as TableSizeGB
,cast(b.VirtualSize as decimal(15,0)) as VirtualSize
,VirtualSize/(1024**3)  as VirtualSizeGB
,b.TableSkew
from
   dbc.tables a
   right join
(
select
        databasename
       ,tablename
       ,SUM(CurrentPerm) as TableSize
       ,MAX(CurrentPerm) * ( HASHAMP()+1) as VirtualSize
       ,100-avg(CurrentPerm)/max(CurrentPerm)*100.0 as TableSkew
from   dbc.tablesize a
where exists
(
select 1
from   dbc.tables b
where a.databasename eq b.databasename
  and a.tablename    eq b.tablename
  and a.databasename eq 'publish'
  
)
group by 1, 2
)  b
on   a.databasename eq b.databasename
 and a.tablename    eq b.tablename
-------------------------------------------------------

) a group by 1

     
----------------------------------OPTIMIZED SPACE CODE------------------

sel CreatorName, sum(TableSizeGB) as TableSizeGB, sum(VirtualSizeGB) as VirtualSizeGB
from
(
	SELECT
		a.DataBaseName,
	 	a.TableName,
	 	b.CreatorName,
	 	b.CreateTimeStamp,
	 	b.LastAccessTimeStamp,
	 	b.AccessCount,
  	 	CAST(SUM(a.CurrentPerm) AS DECIMAL(15,0)) /(1024**3) AS TableSizeGB,
        CAST((MAX(a.CurrentPerm) * ( HASHAMP()+1))  AS DECIMAL(15,0))/(1024**3)  AS VirtualSizeGB,
        100-AVG(a.CurrentPerm)/MAX(a.CurrentPerm)*100.0 AS TableSkew
		FROM   
		dbc.tablesizev a
		INNER JOIN 
			(
				SELECT TableName, creatorname,CreateTimeStamp,LastAccessTimeStamp, AccessCount
				FROM   dbc.tablesv b
				
				--	where creatorname IN ('sxshankar')
				--	AND creatorname IN ('rxthomas')
  			) AS b
  			ON a.tablename=b.tablename  		
  			WHERE 
  			a.databasename eq  'publish' 
  			--			or a.databasename eq 'prdteraminer' 
  			--			or a.databasename eq  'Analytics_Temp' 
  			
  			GROUP BY 1,2,3,4,5,6
  			having TableSizeGB gt 0.1
 			order by TableSizeGB desc
 ) a 
 group by 1 			
	
	
	
--------------------------------- Checking Space in Publish, prdteraminer--------------------------------

SELECT
DatabaseName
,SUM(CurrentPerm)/1024/1024/1024 AS USEDSPACE_IN_GB
,SUM(MaxPerm)/1024/1024/1024 AS MAXSPACE_IN_GB
,(MAX(CurrentPerm) * ( HASHAMP()+1))/1024/1024/1024 as VirtualSize_used
,SUM(CurrentPerm)/ NULLIFZERO (SUM(MaxPerm)) *100 (FORMAT 'zz9.99%') AS Percentage_Used
,MAXSPACE_IN_GB- USEDSPACE_IN_GB AS REMAININGSPACE_IN_GB
FROM DBC.DiskSpace
WHERE DatabaseName in  ('prdteraminer','publish')
GROUP BY DatabaseName;	


sel * from dbc.tablesv where tablename like '%med%' and databasename eq 'publish'



