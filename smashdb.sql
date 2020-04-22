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

CREATE TABLE Tournament
(
tnmt_id INTEGER,
start_date   DATE,
end_date     DATE,
region      VARCHAR(50),
winner      VARCHAR(50)
);

CREATE TABLE Character
(
cname VARCHAR(17),
);

CREATE TABLE Matchup
(
