.mode column
.headers on
.separator ROW "\n"

--Rank matchups by number of occurances
SELECT *, c1wins + c2wins as Total_Fights
    FROM Matchup
    WHERE Total_Fights >= 1
	ORDER BY Total_Fights DESC;