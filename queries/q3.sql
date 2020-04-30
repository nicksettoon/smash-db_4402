.mode column
.headers on
.separator ROW "\n"

--Rank players by number of fights won
SELECT swinner AS name, COUNT(fid) AS fight_wins
    FROM FightSingles NATURAL JOIN SetSingles
    GROUP BY swinner
    ORDER BY fight_wins DESC;