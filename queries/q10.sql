.mode column
.headers on
.separator ROW "\n"

--List matchups with their character's tier and the tier ratio
SELECT c1name, adv_tier as c1_tier, c2name, t2.tiername as c2_tier, tratio
FROM (SELECT c1name, c2name, tratio, t1.tiername as adv_tier
		FROM Matchup as mu INNER JOIN Character as char on mu.c1name = char.cname NATURAL JOIN Tier as t1) as view1 INNER JOIN Character as char2 on view1.c2name = char2.cname NATURAL JOIN Tier as t2
WHERE tratio < 1
ORDER BY tratio;