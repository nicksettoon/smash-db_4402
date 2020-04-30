.mode column
.headers on
.separator ROW "\n"

--Rank players by the depth they were eliminated at across all tournaments.
SELECT plyr1 as Player, MIN(depth) as Round_Eliminated
	FROM SetSingles NATURAL JOIN Tournament
	GROUP BY Player
UNION
Select plyr2 as Player, MIN(depth) as Round_Eliminated
	FROM SetSingles NATURAL JOIN Tournament
	GROUP BY Player
	ORDER BY Round_Eliminated;