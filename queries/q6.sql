.mode column
.headers on
.separator ROW "\n"

--Rank characters by number of fights they've been in with their tier.
SELECT cname AS Character, tiername as Tier, Total_Played
	FROM (SELECT Character AS cname, sum(Play_rate) as Total_Played
		FROM (SELECT char1 as Character, COUNT() as Play_rate
				FROM FightSingles NATURAL JOIN SetSingles
				GROUP BY char1
			  UNION
			  SELECT char2 as Character, COUNT() as Play_rate
				  FROM FightSingles NATURAL JOIN SetSingles
				  GROUP BY char2)
	GROUP BY Character
	ORDER BY Total_Played DESC) NATURAL JOIN Character NATURAL JOIN Tier;
