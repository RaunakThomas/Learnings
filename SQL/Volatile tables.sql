CREATE MULTISET VOLATILE TABLE g AS
(
--			insert into g 
SEL  1 AS b
) WITH  DATA ON COMMIT PRESERVE ROWS;

INSERT INTO g
SEL 2 AS b;
SEL * FROM g

-- Not working from rxthomas
CREATE GLOBAL TEMPORARY  TABLE e AS
(
SEL  pat_id FROM prdedwvwh.prescription_fill_sold WHERE fill_sold_dt EQ 1150101 GROUP BY 1
) WITH  NO DATA PRIMARY INDEX(pat_id)
ON COMMIT PRESERVE ROWS;

--sel * from a

INSERT  e
SEL  pat_id FROM prdedwvwh.prescription_fill_sold WHERE fill_sold_dt EQ 1150101 GROUP BY 1;

SEL * FROM g
DROP TABLE g

SELECT * FROM DBC.Temptables;


 CREATE VOLATILE TABLE V_TEMP, NO FALLBACK
(
Empid INTEGER,
Salary DECIMAL(10,2)
Deptno INTEGER
) ON COMMIT PRESERVE ROWS;

SELECT * FROM dbc.users WHERE USERNAME = rxthomas

HELP VOLATILE TABLE

