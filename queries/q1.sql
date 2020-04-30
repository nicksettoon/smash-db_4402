.mode column
.headers on
.separator ROW "\n"

--Rank players by tournament attendance.
SELECT pname as Player, COUNT(*) as Tourneys
    FROM PlayerTournament NATURAL JOIN Player
    GROUP BY pname
    ORDER BY Tourneys DESC;