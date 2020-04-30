.mode column
.headers on
.separator ROW "\n"

--Rank players by number of set wins for all tournaments
SELECT Plyr, IFNULL(Set_wins,0) as Set_wins
	FROM (SELECT Plyr
			FROM (SELECT plyr1 as Plyr
					FROM SetSingles
					GROUP BY plyr1
				  UNION
				  SELECT plyr2 as Plyr
					FROM SetSingles
					GROUP BY plyr2
				  )
		  ) LEFT JOIN
		(SELECT swinner, COUNT(*) as Set_wins
			FROM SetSingles
			GROUP BY swinner) on Plyr = swinner
	ORDER BY Set_wins DESC, Plyr ASC;