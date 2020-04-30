#Makefile for easy db manipulation

#rebuilt entire database from csvs
rebuild:
	sqlite3 smash.db ".read ./mgmt/0-rebuild-db.sql"
	sqlite3 smash.db ".tables"

#drop all tables in the db
drop:
	sqlite3 smash.db ".read ./mgmt/1-drop-tables.sql"
	sqlite3 smash.db ".tables"

#recreate all tables
create:
	sqlite3 smash.db ".read ./mgmt/2-create-tables.sql"
	sqlite3 smash.db ".tables"

#import data from the csvs
import:
	sqlite3 smash.db ".read ./mgmt/3-import-csvs.sql"
	sqlite3 smash.db ".tables"

#delete the db file
deletedb:
	rm smash.db

q1:
	sqlite3 smash.db ".read ./queries/q1.sql"
	echo "Ranks players by tournament attendance."
q2:
	sqlite3 smash.db ".read ./queries/q2.sql"
	echo "Ranks matchups by number of occurances."
q3:
	sqlite3 smash.db ".read ./queries/q3.sql"
	echo "Ranks players by number of fights won."
q4:
	sqlite3 smash.db ".read ./queries/q4.sql"
	echo "Lists regions by number of players from that region."
q5:
	sqlite3 smash.db ".read ./queries/q5.sql"
	echo "Lists regions by number of tournaments held in that region."
q6:
	sqlite3 smash.db ".read ./queries/q6.sql"
	echo "Ranks characters with their tier by number of fights they've been in."
q7:
	sqlite3 smash.db ".read ./queries/q7.sql"
	echo "Ranks players by number of set wins for all tournaments."
q8:
	sqlite3 smash.db ".read ./queries/q8.sql"
	echo "Ranks players by the depth they were eliminated at across all tournaments."
q9:
	sqlite3 smash.db ".read ./queries/q9.sql"
	echo "Lists players by the number of sets they have when their character is at a disadvantage."
q10:
	sqlite3 smash.db ".read ./queries/q10.sql"
	echo "Lists matchups with their character's tier and the tier ratio."