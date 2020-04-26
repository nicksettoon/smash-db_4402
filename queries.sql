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
SELECT swinner AS name, COUNT(fid) AS fight_wins
    FROM FightSingles NATURAL INNER JOIN SetSingles
    GROUP BY swinner
    ORDER BY fight_wins DESC

--List region by number of players from that region.
SELECT pregion AS region, COUNT(pname) AS num_players
    FROM Player
    GROUP BY pregion
    ORDER BY num_players DESC

--List region by number of tourneys in that region.
SELECT tregion AS region, COUNT(tname) AS num_players
    FROM Tournament
    GROUP BY tregion
    ORDER BY num_players DESC

--What player wins the most when their character is at disadvantage?
--Which character performs the best against others on average?
