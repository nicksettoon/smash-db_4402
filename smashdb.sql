#CREATE FIGHTS

CREATE TABLE SinglesFights
(
fight_id INTEGER PRIMARY KEY;
char1 INTEGER,
char2 INTEGER,
winner INTEGER,
stage INTEGER,
set_id INTEGER
);

CREATE TABLE SinglesSets
(
set_id INTEGER PRIMARY KEY;
plyr1 INTEGER,
plyr2 INTEGER,
depth INTEGER,
winner INTEGER,
bracket_type INTEGER,
tnmt_id INTEGER
);

CREATE TABLE Player
(
plyr_id INTEGER,
pname   VARCHAR(50),
main_char_id    INTEGER,
region  INTEGER
);

CREATE TABLE PlayerTournament
(
    plyr_id INTEGER,
    tnmt_id INTEGER
);

CREATE TABLE Tournament
(
tnmt_id INTEGER,
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
c1_id INTEGER,
c2_id INTEGER,
c1_wins     INTEGER,
c2_wins     INTEGER,
total_games INTEGER,
tier_diff INTEGER
);
