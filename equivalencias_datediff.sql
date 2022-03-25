-- SQL SERVER: como excluir los fines de semana de un datediff

SELECT
DATEDIFF(DD, '2022-03-25', '2022-03-29') 
- (DATEDIFF(WK, '2022-03-25', '2022-03-29') * 2) 
- CASE WHEN DATEPART(DW, '2022-03-25') = 1 THEN 1 ELSE 0 END 
+ CASE WHEN DATEPART(DW, '2022-03-29') = 1 THEN 1 ELSE 0 END AS Date_Diff

-- Funcion SQL equivalente a SERVER:

CREATE FUNCTION TOTAL_WEEKDAYS(date1 DATE, date2 DATE)
RETURNS INT
RETURN ABS(DATEDIFF(date2, date1)) + 1
     - ABS(DATEDIFF(ADDDATE(date2, INTERVAL 1 - DAYOFWEEK(date2) DAY),
                    ADDDATE(date1, INTERVAL 1 - DAYOFWEEK(date1) DAY))) / 7 * 2
     - (DAYOFWEEK(IF(date1 < date2, date1, date2)) = 1)
     - (DAYOFWEEK(IF(date1 > date2, date1, date2)) = 7);
     
-- Llamando a la funcion:

SELECT TOTAL_WEEKDAYS('2013-08-03', '2013-08-21') weekdays1,
       TOTAL_WEEKDAYS('2013-08-21', '2013-08-03') weekdays2;

-- MySQL (Query): como excluir los fines de semana de un datediff

select ABS(DATEDIFF('2022-03-29', '2022-03-15'))
 - ABS(DATEDIFF(ADDDATE('2022-03-29', INTERVAL 1 - DAYOFWEEK('2022-03-29') DAY),
                ADDDATE('2022-03-15', INTERVAL 1 - DAYOFWEEK('2022-03-15') DAY))) / 7 * 2
 - (DAYOFWEEK(IF('2022-03-15' < '2022-03-29', '2022-03-15', '2022-03-29')) = 1)
 - (DAYOFWEEK(IF('2022-03-15' > '2022-03-29', '2022-03-15', '2022-03-29')) = 7) as diff
