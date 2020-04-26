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

--List players by number of set wins.
--List players by number of fight wins.
--List region by number of players from that region.
--List region by number of tourneys in that region.
--What player wins the most when their character is at disadvantage?
--Which character performs the best against others on average?

--List matchups having at least 10 games played.
SELECT *, SUM(c1_wins + c2_wins) as Total_games
    FROM Matchup
    WHERE Total_games >= 10
    ORDER BY Total_games;

--List players by the depth they were eliminated at for a given tournament.
SELECT pname as Player, MIN(depth) as depth, 
    FROM SinglesSets NATURAL JOIN Tournament
    WHERE tname=""
    GROUP BY Player
    HAVING depth > 4;