CREATE TABLE SinglesFight
(
fight_id INTEGER PRIMARY KEY,
char1 VARCHAR(17),
char2 VARCHAR(17),
winner VARCHAR(7),
stage VARCHAR(50),
set_id INTEGER
);

CREATE TABLE SinglesSet
(
set_id INTEGER PRIMARY KEY,
plyr1 VARCHAR(7),
plyr2 VARCHAR(7),
depth INTEGER,
winner VARCHAR(7),
bracket_type INTEGER,
tname VARCHAR(50)
);

CREATE TABLE Player
(
pname   VARCHAR(7),
main_cname  VARCHAR(17),
region  VARCHAR(30)
);

CREATE TABLE PlayerTournament
(
    pname   VARCHAR(7),
    tname   VARCHAR(50)
);

CREATE TABLE Tournament
(
tname   VARCHAR(50),
start_date   DATE,
end_date     DATE,
region      VARCHAR(50),
winner      VARCHAR(50)
);

CREATE TABLE Character
(
cname VARCHAR(17),
max_air_acceleration    FLOAT,
air_speed   FLOAT,
fall_speed  FLOAT,
gravity FLOAT,
full_jump_height    FLOAT,
weight  FLOAT,
walk_speed  FLOAT,
init_dash   FLOAT,
run_speed   FLOAT,
fastest_OOS_option  FLOAT,
grab_speed  FLOAT,
total_wins INTEGER,
tier INTEGER
);

CREATE TABLE Matchup
(
c1_id VARCHAR(17),
c2_id VARCHAR(17),
c1_wins     VARCHAR(17),
c2_wins     VARCHAR(17),
tier_diff INTEGER
);