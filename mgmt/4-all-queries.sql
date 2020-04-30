.open smash.db
--"SIMPLE"--
--List players ranked by tournament attendance.
SELECT pname as Player, COUNT(*) as Tourneys
    FROM PlayerTournament NATURAL JOIN Player
    GROUP BY pname
    ORDER BY Tourneys DESC;
--Rank matchups by occurances
SELECT *, c1wins + c2wins as Total_Fights
    FROM Matchup
    WHERE Total_Fights >= 1
    ORDER BY Total_Fights DESC;

--List players by number of fight wins.
SELECT swinner AS name, COUNT(fid) AS fight_wins
    FROM FightSingles NATURAL INNER JOIN SetSingles
    GROUP BY swinner
    ORDER BY fight_wins DESC;

--List region by number of players from that region.
SELECT pregion AS region, COUNT(pname) AS num_players
    FROM Player
    GROUP BY pregion
    ORDER BY num_players DESC;

--List region by number of tourneys in that region.
SELECT tregion AS region, COUNT(tname) AS num_tournaments
    FROM Tournament
    GROUP BY tregion
    ORDER BY num_tournaments DESC;

--COMPLEX--
--Rank characters by total times played in all tournaments
SELECT Character, sum(Play_rate) as Total_Played
FROM (SELECT char1 as Character, COUNT(*) as Play_rate
    FROM FightSingles NATURAL JOIN SetSingles NATURAL JOIN Tournament
	WHERE tname = "Frostbite 2019"
    GROUP BY char1
UNION
SELECT char2 as Character, COUNT(*) as Play_rate
    FROM FightSingles NATURAL JOIN SetSingles NATURAL JOIN Tournament
	WHERE tname = "Frostbite 2019"
    GROUP BY char2)
GROUP BY Character
ORDER BY Total_Played DESC;

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
	  )
LEFT JOIN
	(SELECT swinner, COUNT(*) as Set_wins
		FROM SetSingles
		GROUP BY swinner) on Plyr = swinner
ORDER BY Set_wins DESC, Plyr ASC;

--Rank players by the depth they were eliminated at across all tournaments.
SELECT plyr1 as Player, MIN(depth) as Round_Eliminated
    FROM SetSingles NATURAL JOIN Tournament
    GROUP BY Player
UNION
Select plyr2 as Player, MIN(depth) as Round_Eliminated
    FROM SetSingles NATURAL JOIN Tournament
    GROUP BY Player
    ORDER BY Round_Eliminated;

--Rank players by the number of fights won when their character is at disadvantage?
SELECT Player,SUM(Wins_At_Disadvantage) as Wins_At_Disadvantage
	FROM (SELECT plyr1 as Player, COUNT() as Wins_At_Disadvantage
			FROM(SELECT char1,char2,fwinner,plyr1,plyr2
					FROM FightSingles NATURAL JOIN SetSingles)
			WHERE (SELECT tratio
					FROM Matchup
					WHERE c1name = char1 AND c2name = char2) > 1 AND char1 = fwinner
			GROUP BY plyr1
		UNION
		SELECT plyr2 as Player, COUNT() as Wins_At_Disadvantage
			FROM(SELECT char1,char2,fwinner,plyr1,plyr2
					FROM FightSingles NATURAL JOIN SetSingles)
			WHERE (SELECT tratio
					FROM Matchup
					WHERE c1name = char2 AND c2name = char1) > 1 AND char2 = fwinner
			GROUP BY plyr2)
	GROUP BY Player
	ORDER BY Wins_At_Disadvantage DESC

--Show matchups with their character's tier next to the character and the matchup's ratio?
SELECT c1name, adv_tier as c1_tier, c2name, t2.tiername as c2_tier, tratio
FROM (SELECT c1name, c2name, tratio, t1.tiername as adv_tier
		FROM Matchup as mu INNER JOIN Character as char on mu.c1name = char.cname NATURAL JOIN Tier as t1) as view1 INNER JOIN Character as char2 on view1.c2name = char2.cname NATURAL JOIN Tier as t2
WHERE tratio < 1
ORDER BY tratio;
