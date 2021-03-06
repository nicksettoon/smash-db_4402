.open smash.db
.mode csv
--Import and create Character Table
.import ./csvs/character.csv ctemp
INSERT INTO Character (cname,max_air_acceleration,air_speed,fall_speed,gravity,full_jump_height,weight,walk_speed,init_dash,run_speed,fastest_OOS_option,grab_speed,tierid) SELECT * FROM ctemp;

--Import and create Tournament Table
.import ./csvs/tournament.csv ttemp
INSERT INTO Tournament (tname,start_date,end_date,tregion,twinner) SELECT * FROM ttemp;

--Import and create Player Table
.import ./csvs/player.csv ptemp
INSERT INTO Player (pname,main,pregion) SELECT * FROM ptemp;

--Import and create SetSingles Table
.import ./csvs/setSingles.csv stemp
INSERT INTO SetSingles (plyr1,plyr2,depth,swinner,bracket,tname) SELECT * FROM stemp;

--Import and create FightSingles Table
.import ./csvs/fightSingles.csv ftemp
INSERT INTO FightSingles (char1,char2,fwinner,stage,sid) SELECT * FROM ftemp;

--Import and create PlayerTournament Table
.import ./csvs/playerTournament.csv PTtemp
INSERT INTO PlayerTournament (pname,tname) SELECT * FROM PTtemp;

--Import and create Tier Table
.import ./csvs/tier.csv temptiers
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

-- Import cleanup
DROP TABLE ctemp;
DROP TABLE ttemp;
DROP TABLE ptemp;
DROP TABLE stemp;
DROP TABLE ftemp;
DROP TABLE PTtemp;
DROP TABLE temptiers;