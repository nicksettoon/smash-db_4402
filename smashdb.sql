CREATE TABLE SinglesFights
(
fight_id INTEGER PRIMARY KEY,
char1 VARCHAR(17),
char2 VARCHAR(17),
winner VARCHAR(50),
stage VARCHAR(50),
set_id INTEGER
);

CREATE TABLE SinglesSets
(
set_id INTEGER PRIMARY KEY,
plyr1 VARCHAR(50),
plyr2 VARCHAR(50),
depth INTEGER,
winner VARCHAR(50),
bracket_type INTEGER,
tname VARCHAR(50)
);

CREATE TABLE Player
(
pname   VARCHAR(50),
main_cname  VARCHAR(17),
region  VARCHAR(30)
);

CREATE TABLE PlayerTournament
(
    plyr_id INTEGER,
    tnmt_id INTEGER
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
total_games INTEGER,
tier_diff INTEGER
);