.mode column
.headers on
.separator ROW "\n"

--List players by the number of sets they have when their character is at a disadvantage.
SELECT Player, 
    SUM(Wins_At_Disadvantage) as  
    Wins_At_Disadvantage
    FROM (SELECT plyr1 as Player,  
    COUNT() as Wins_At_Disadvantage
            FROM(SELECT char1, char2,  
            fwinner, plyr1, plyr2
                    FROM FightSingles NATURAL 
                    JOIN SetSingles)
            WHERE (SELECT tratio
                    	FROM Matchup
                    	WHERE c1name = char1 AND   
                         c2name = char2) > 1 
                                       AND char1 = fwinner
            GROUP BY plyr1
            UNION
            SELECT plyr2 as Player, COUNT() as  
            Wins_At_Disadvantage
            FROM(SELECT char1, char2,  
            fwinner, plyr1, plyr2
                    	FROM FightSingles                
                        NATURAL JOIN SetSingles)
            WHERE (SELECT tratio
                    	FROM Matchup
                    	WHERE c1name = char2 AND  
                        c2name = char1) > 1 
                                      AND char2 = fwinner
            GROUP BY plyr2)
GROUP BY Player
ORDER BY Wins_At_Disadvantage DESC;
