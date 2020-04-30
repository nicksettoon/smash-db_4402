--DROP TABLE COMMANDS--
-- DROP TABLE ctemp;
-- DROP TABLE ttemp;
-- DROP TABLE ptemp;
-- DROP TABLE stemp;
-- DROP TABLE ftemp;
-- DROP TABLE PTtemp;
-- DROP TABLE temptiers;

-- DROP TABLE Character;
-- DROP TABLE Tournament;
-- DROP TABLE Player;
-- DROP TABLE SetSingles;
-- DROP TABLE FightSingles;
-- DROP TABLE PlayerTournament;
-- DROP TABLE Tier;
-- DROP TABLE Matchup;


--CREATE TABLE COMMANDS--
CREATE TABLE Tier
(
tierid INTEGER PRIMARY KEY,
tiername VARCHAR(7) NOT NULL
);

CREATE TABLE Matchup
(
c1name  VARCHAR(17),
c2name  VARCHAR(17),
c1wins  VARCHAR(17),
c2wins  VARCHAR(17),
tratio    REAL,
PRIMARY KEY (c1name,c2name),
FOREIGN KEY (c1name)
    REFERENCES Character (cname)
    ON DELETE NO ACTION,
FOREIGN KEY (c2name)
    REFERENCES Character (cname)
);

CREATE TABLE Character
(
cname    VARCHAR(17) PRIMARY KEY,
max_air_acceleration    REAL,
air_speed   REAL,
fall_speed  REAL,
gravity REAL,
full_jump_height    REAL,
weight  INTEGER,
walk_speed  REAL,
init_dash   REAL,
run_speed   REAL,
fastest_OOS_option  INTEGER,
grab_speed  INTEGER,
tierid  INTEGER,
FOREIGN KEY (tierid)
    REFERENCES Tier (tierid)
    ON DELETE NO ACTION
);

CREATE TABLE Tournament
(
tname   VARCHAR(50) PRIMARY KEY,
start_date   DATE,
end_date     DATE,
tregion      VARCHAR(50),
twinner      VARCHAR(50) NOT NULL,
FOREIGN KEY (twinner)
    REFERENCES Player (pname)
    ON DELETE NO ACTION
);

CREATE TABLE SetSingles
(
sid INTEGER PRIMARY KEY,
plyr1 VARCHAR(10) NOT NULL,
plyr2 VARCHAR(10) NOT NULL,
depth INTEGER NOT NULL,
swinner VARCHAR(10) NOT NULL,
bracket VARCHAR(7) NOT NULL,
tname VARCHAR(50) NOT NULL,
FOREIGN KEY (tname)
    REFERENCES Tournament (tname)
    ON DELETE CASCADE,
FOREIGN KEY (plyr1)
    REFERENCES Player (pname)
    ON DELETE NO ACTION,
FOREIGN KEY (plyr2)
    REFERENCES Player (pname)
    ON DELETE NO ACTION,
FOREIGN KEY (swinner)
    REFERENCES Player (pname)
    ON DELETE NO ACTION
);

CREATE TABLE FightSingles
(
fid INTEGER PRIMARY KEY,
char1 VARCHAR(17) NOT NULL,
char2 VARCHAR(17) NOT NULL,
fwinner VARCHAR(17) NOT NULL,
stage VARCHAR(50),
sid INTEGER,
FOREIGN KEY (sid)
    REFERENCES SetSingles (sid)
    ON DELETE CASCADE,
FOREIGN KEY (char1)
    REFERENCES Character (cname)
    ON DELETE NO ACTION,
FOREIGN KEY (char2)
    REFERENCES Character (cname)
    ON DELETE NO ACTION,
FOREIGN KEY (fwinner)
    REFERENCES Character (cname)
    ON DELETE NO ACTION,
FOREIGN KEY (char1,char2)
    REFERENCES Matchup (c1name,c2name)
    ON DELETE NO ACTION
);

CREATE TABLE Player
(
pname   VARCHAR(10) PRIMARY KEY,
main    VARCHAR(17),
pregion  VARCHAR(30),
FOREIGN KEY (main)
    REFERENCES Character (cname)
    ON DELETE NO ACTION
);

CREATE TABLE PlayerTournament
(
pname   VARCHAR(7),
tname   VARCHAR(50),
PRIMARY KEY (pname, tname),
FOREIGN KEY (pname)
    REFERENCES Player (pname),
FOREIGN KEY (tname)
    REFERENCES Player (tname)

);

--IMPORT AND UPDATE COMMANDS--
--Import and create Character Table
.import csvs/character.csv ctemp
INSERT INTO Character (cname,max_air_acceleration,air_speed,fall_speed,gravity,full_jump_height,weight,walk_speed,init_dash,run_speed,fastest_OOS_option,grab_speed,tierid) SELECT * FROM ctemp;

--Import and create Tournament Table
.import csvs/tournament.csv ttemp
INSERT INTO Tournament (tname,start_date,end_date,tregion,twinner) SELECT * FROM ttemp;

--Import and create Player Table
.import csvs/player.csv ptemp
INSERT INTO Player (pname,main,pregion) SELECT * FROM ptemp;

--Import and create SetSingles Table
.import csvs/setSingles.csv stemp
INSERT INTO SetSingles (plyr1,plyr2,depth,swinner,bracket,tname) SELECT * FROM stemp;

--Import and create FightSingles Table
.import csvs/fightSingles.csv ftemp
INSERT INTO FightSingles (char1,char2,fwinner,stage,sid) SELECT * FROM ftemp;

--Import and create PlayerTournament Table
.import csvs/playerTournament.csv PTtemp
INSERT INTO PlayerTournament (pname,tname) SELECT * FROM PTtemp;

--Import and create Tier Table
.import csvs/tier.csv temptiers
INSERT INTO Tier (tiername) SELECT * FROM temptiers;

--Fill Matchup Table
INSERT INTO Matchup (c1name,c2name) SELECT c1.cname as Fighter, c2.cname as Opponent
FROM Character as c1, Character as c2;

--Update Matchup Table
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

UPDATE Matchup as mu
 SET tratio =
	(SELECT ROUND(c1.tierid*1.0/c2.tierid,2) as tratio
		FROM Character c1, Character c2
		WHERE mu.c1name = c1.cname AND mu.c2name = c2.cname);

UPDATE Matchup
    SET c1wins = 0
    WHERE c1wins IS NULL;

UPDATE Matchup
    SET c2wins = 0
    WHERE c2wins IS NULL;


--QUERIES
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

--"COMPLEX"--
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

--List players by the number of sets they have when their character is at a disadvantage
SELECT Player, 
    SUM(Wins_At_Disadvantage) as  
    Wins_At_Disadvantage
    FROM (SELECT plyr1 as Player,  
    COUNT() as Wins_At_Disadvantage
            FROM(SELECT char1, char2,  
            fwinner, plyr1, plyr2
                    FROM FightSingles NATURAL 
                    JOIN SetSingles)
            WHERE (SELECT tratio
                    	FROM Matchup
                    	WHERE c1name = char1 AND   
                         c2name = char2) > 1 
                                       AND char1 = fwinner
            GROUP BY plyr1
            UNION
            SELECT plyr2 as Player, COUNT() as  
            Wins_At_Disadvantage
            FROM(SELECT char1, char2,  
            fwinner, plyr1, plyr2
                    	FROM FightSingles                
                        NATURAL JOIN SetSingles)
            WHERE (SELECT tratio
                    	FROM Matchup
                    	WHERE c1name = char2 AND  
                        c2name = char1) > 1 
                                      AND char2 = fwinner
            GROUP BY plyr2)
GROUP BY Player
ORDER BY Wins_At_Disadvantage DESC;

--List matchups with their character's tier and the tier ratio
SELECT c1name, adv_tier as c1_tier, c2name, t2.tiername as c2_tier, tratio
FROM (SELECT c1name, c2name, tratio, t1.tiername as adv_tier
		FROM Matchup as mu INNER JOIN Character as char on mu.c1name = char.cname NATURAL JOIN Tier as t1) as view1 INNER JOIN Character as char2 on view1.c2name = char2.cname NATURAL JOIN Tier as t2
WHERE tratio < 1
ORDER BY tratio;
