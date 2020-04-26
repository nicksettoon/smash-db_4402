--List players ranked by tournament attendance.
SELECT pname as Player, COUNT(*) as Tourneys
    FROM PlayerTournament NATURAL JOIN Player
    GROUP BY pname
    ORDER BY Tourneys DESC;

--Rank characters by total times played in Frostbite 2019.
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

--Rank players by number of set wins for a given tournament
SELECT Plyr, IFNULL(Set_wins,0) as Set_wins
FROM (SELECT Plyr
		FROM (SELECT plyr1 as Plyr
				FROM SetSingles NATURAL JOIN Tournament
				WHERE tname = "Frostbite 2019"
				GROUP BY plyr1
			  UNION
			  SELECT plyr2 as Plyr
				FROM SetSingles NATURAL JOIN Tournament
				WHERE tname = "Frostbite 2019"
				GROUP BY plyr2
			  )
	  )
LEFT JOIN
	(SELECT swinner, COUNT(*) as Set_wins
		FROM SetSingles NATURAL JOIN Tournament
		WHERE tname = "Frostbite 2019"
		GROUP BY swinner) on P lyr = swinner
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

--List matchups having at least 10 games played.
SELECT *, SUM(c1_wins + c2_wins) as Total_games
    FROM Matchup
    WHERE Total_games >= 10
    ORDER BY Total_games;

--List players by number of fight wins.
--List region by number of players from that region.
--List region by number of tourneys in that region.
--What player wins the most when their character is at disadvantage?
--Which character performs the best against others on average?










 UPDATE Matchup as mu
 SET c1wins =
 (SELECT COUNT (*) as c1wins
	FROM FightSingles as fights
	WHERE fights.char1 = fights.fwinner AND fights.char1 = mu.c1name AND fights.char2 = mu.c2name
	GROUP BY char1, char2, fwinner);
	
 UPDATE Matchup as mu
 SET c2wins =
 (SELECT COUNT (*) as c2wins
	FROM FightSingles as fights
	WHERE fights.char2 = fights.fwinner AND fights.char1 = mu.c1name AND fights.char2 = mu.c2name
	GROUP BY char1, char2, fwinner);
	
SELECT *, SUM(c1wins + c2wins) as Total_Fights
FROM 
	(SELECT c1name, c2name, IFNULL(c1wins,0) as c1wins, IFNULL(c2wins,0) as c2wins
	FROM Matchup
	WHERE c1wins NOT NULL OR c2wins NOT NULL
	GROUP BY c1name,c2name)
GROUP BY c1name,c2name;
