CREATE TABLE Tier
(
tierid INTEGER PRIMARY KEY,
tiername VARCHAR(7)
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
twinner      VARCHAR(50),
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
    ON DELETE CASCADE
FOREIGN KEY (plyr1)
    REFERENCES Player (pname)
    ON DELETE NO ACTION
FOREIGN KEY (plyr2)
    REFERENCES Player (pname)
    ON DELETE NO ACTION
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
    ON DELETE CASCADE
FOREIGN KEY (char1)
    REFERENCES Character (cname)
    ON DELETE NO ACTION
FOREIGN KEY (char2)
    REFERENCES Character (cname)
    ON DELETE NO ACTION
FOREIGN KEY (fwinner)
    REFERENCES Character (cname)
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
    REFERENCES Player (pname)
);

CREATE TABLE Matchup
(
c1name  VARCHAR(17),
c2name  VARCHAR(17),
c1wins  VARCHAR(17),
c2wins  VARCHAR(17)
);