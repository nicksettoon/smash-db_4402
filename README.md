# smash-db_4402
Repo for semester project for Intro to Database Management Systems

PROJECT OBJECTIVES

    We need the database to correctly determine who has a better head to head matchup between two esports players.

    The database must be able to account for the increase in growth of entries as the popularity of the sport continues to grow.

    Be able to rank the players by the number of set wins they have in order to create a “standings” of the players.

    Determine the fictional characters that give a player the biggest advantage and highest chance to win a set.

    Be able to determine if where a player is from has any influence on their performance.

    Determine which players had the highest participation, meaning ther participated in the most tournaments.

    What are the most popular regions for Ultimate, and what areas need more promotion and advertisement.

    Find which characters are considered to be the favorite amongst players and are used the most to fight in sets.  

DATABASE TECHNICAL DETAILS AND USAGE
    
    This database is built with sqlite3. 

    In order to use, one must simply install sqlite3 for your linux distribution and run the make commands listed in the AVAILABLE COMMANDS section below.

    If on Windows or MAC OS, you can download a program called sqlitebrowser from https://sqlitebrowser.org/dl/ and open the db-browser.sqbpro project file with it.
    All of the queries are clearly labled in the "Execute SQL" tab and the smash.db file included in this repo is stable and up to date.

AVAILABLE COMMANDS

    #rebuild entire database from csvs (same as $ make drop, then $ make create, then $ make import)
    $ make rebuild

    #drop all tables in the db
    $ make drop

    #recreate all tables
    $ make create

    #import data from the csvs
    $ make import

    #delete the db file
    $ make deletedb

    #queries 1 through n (where n = 10)
    $ make qn
    ex: make q3
    ex: make q9
    
PROJECT FILES

    db-browser.sqbpro: project file for easy GUI browsing via sqlitebrowser
    makefile: file holding various make commands
    README.md: this document
    smash.db: the actual sqlite database file

    csvs/
        character.csv
        fightSingles.csv
        player.csv
        playerTournament.csv
        setSingles.csv
        tier.csv
        tournament.csv

    docs/
        ER_Diagram_CSC_4402.jpeg for the separate ER Diagram picture
        Team05_Design.docx for the design document
        Team05_PPT for the powerpoint
        Team05_SQL.sql for the sql syntax in one file. 
            HOWEVER,DO NOT RUN THE Team05_SQL.sql file, it is not a valid MYSQL script. Please use the make commands above.

    mgmt/
        Each kind of command has its own sqlite script 0-rebuild-db.sql through 4-all-queries.sql

    queries/
        q1 through q10 are separated into their own files here for easy execution via the makefile
