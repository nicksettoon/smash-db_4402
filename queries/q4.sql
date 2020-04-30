.mode column
.headers on
.separator ROW "\n"

--List regions by number of players from that region
SELECT pregion AS region, COUNT(pname) AS num_players
    FROM Player
    GROUP BY pregion
    HAVING num_players >= 3
	ORDER BY num_players DESC;