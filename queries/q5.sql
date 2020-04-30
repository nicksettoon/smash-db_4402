.mode column
.headers on
.separator ROW "\n"

--List regions by number of tournaments held in that region
SELECT tregion AS region, COUNT(tname) AS  Num_Tournaments
    FROM Tournament
    GROUP BY tregion
    ORDER BY Num_Tournaments DESC;