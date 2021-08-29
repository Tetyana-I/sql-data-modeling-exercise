-- from the terminal run:
-- psql < soccer.sql

DROP DATABASE IF EXISTS soccer;

CREATE DATABASE soccer;

\c soccer

CREATE TABLE seasons
(
    id SERIAL PRIMARY KEY,
    start_dat DATE NOT NULL,
    end_dat DATE NOT NULL
);
INSERT INTO seasons 
    (start_dat, end_dat)
VALUES
    ('07-01-2021', '08-01-2021');


CREATE TABLE teams
(
    id SERIAL PRIMARY KEY,
    team VARCHAR(3) NOT NULL,
    title VARCHAR(20) NOT NULL
);
INSERT INTO teams 
    (team, title)
VALUES
    ('RUS', 'Torpeda'), ('UKR', 'Dinamo'), ('SPA', 'Barcelona'), ('ITA', 'Milan');


CREATE TABLE referees
(
    id SERIAL PRIMARY KEY,
    referee TEXT NOT NULL
);
INSERT INTO referees
    (referee)
VALUES
    ('referee1'),('referee2'),('referee3'),('referee4');

CREATE TABLE players
(
    id SERIAL PRIMARY KEY,
    player VARCHAR(40) NOT NULL
);
INSERT INTO players
    (player)
VALUES
    ('player1'),('player2'),('player3'),('player4'),
    ('player5'),('player6'),('player7'),('player8'),
    ('player9'),('player10'),('player11'),('player12'),
    ('player13'),('player14'),('player15'),('player16');

CREATE TABLE player_team
(
    id SERIAL PRIMARY KEY,
    player_id INTEGER REFERENCES players ON DELETE CASCADE,
    season_id INTEGER REFERENCES seasons ON DELETE CASCADE,
    team_id INTEGER REFERENCES teams ON DELETE CASCADE
);
INSERT INTO player_team
    (player_id, season_id, team_id)
VALUES
    (1,1,1),(2,1,1),(3,1,1),(4,1,1),
    (5,1,2),(6,1,2),(7,1,2),(8,1,2),
    (9,1,3),(10,1,3),(11,1,3),(12,1,3),
    (13,1,4),(14,1,4),(15,1,4),(16,1,4);

CREATE TABLE games
(
    id SERIAL PRIMARY KEY,
    team1_id INTEGER REFERENCES teams ON DELETE CASCADE,
    team2_id INTEGER REFERENCES teams ON DELETE CASCADE,
    referee_id INTEGER REFERENCES referees ON DELETE CASCADE,
    score_1 INTEGER,
    score_2 INTEGER,
    game_date DATE NOT NULL,
    season_id INTEGER REFERENCES seasons ON DELETE CASCADE
);
INSERT INTO games 
(team1_id, team2_id, referee_id, game_date, season_id)
VALUES 
(1,2,1,	'7/2/2021',1),
(1,3,2,'7/4/2021',1),
(1,4,1,'7/6/2021',1),
(2,3,3,'7/8/2021',1),
(2,4,4,'7/10/2021',1),
(3,4,4,'7/12/2021',1);


CREATE TABLE goals
(
    game_id INTEGER REFERENCES games ON DELETE CASCADE,
    player_id INTEGER REFERENCES players ON DELETE CASCADE,
    time_scored INTEGER NOT NULL
);
INSERT INTO goals
    (game_id, player_id, time_scored)
VALUES
(1,1,20), (1,5,40),
(2,1,2), (2,2,47),
(3,3,12), (3,15,27), (3,15,30),(3,16,42);


-- All of the teams in the league
SELECT DISTINCT t.title
    FROM player_team pt
        JOIN teams t ON t.id = pt.team_id
WHERE pt.season_id = 1;

--All of the goals scored by every player for each game
SELECT games.id as game_ID, COUNT(*) as goals_scored 
    FROM goals 
        JOIN games ON games.id = goals.game_id
    WHERE season_id = 1
    GROUP BY games.id;


-- Who (a player) and how many goals were scored during games with 'Barselona' team: 
SELECT games.id as game_ID, player, COUNT(*) as goals_scored
    FROM goals 
        JOIN games ON games.id = goals.game_id
        JOIN players ON players.id = goals.player_id
    WHERE game_id IN (SELECT games.id FROM games 
                        WHERE team1_id = (SELECT teams.id FROM teams WHERE title = 'Barcelona')
                            OR team2_id = (SELECT teams.id FROM teams WHERE title = 'Barcelona')) 
    GROUP BY player, games.id;

-- All of the players in the league and their corresponding teams
SELECT p.player, t.title FROM player_team pt 
    JOIN players p ON pt.team_id = p.id
    JOIN teams t ON t.id = pt.team_id
WHERE pt.season_id = 1;

-- All of the referees who have been part of each game
SELECT g.id as game_id, r.referee FROM games g
    JOIN referees r ON r.id = g.referee_id;
 
-- All of the matches played between teams
SELECt gm.id as game_id, t1.title, t2.title as team_1
    FROM games gm
    JOIN teams t1 ON gm.team1_id = t1.id 
    JOIN teams t2 ON gm.team2_id = t2.id;

-- All of the start and end dates for season that a league has
SELECT * FROM seasons WHERE id = 1;

-- The standings/rankings of each team in the league
   
--    Calculate score for team1 for each game:
   UPDATE games SET score_1 = team1_score_table.score_1 
   FROM 
        (SELECt gm.id, gm.team1_id, gm.team2_id, COUNT(*) as score_1
            FROM games gm 
            JOIN goals gl ON gm.id = gl.game_id
            JOIN player_team pt ON gl.player_id = pt.player_id
            WHERE gm.team1_id = pt.team_id
            GROUP BY gm.id, gm.team1_id, gm.team2_id) team1_score_table
        WHERE games.id = team1_score_table.id AND games.team1_id = team1_score_table.team1_id;

    UPDATE games SET score_2 = 0
    WHERE score_1 IS NOT NULL AND score_2 IS NULL;        
    
--    Calculate score for team2 for each game:
   UPDATE games SET score_2 = team2_score_table.score_2 
   FROM 
        (SELECt gm.id, gm.team1_id, gm.team2_id, COUNT(*) as score_2
            FROM games gm 
            JOIN goals gl ON gm.id = gl.game_id
            JOIN player_team pt ON gl.player_id = pt.player_id
            WHERE gm.team2_id = pt.team_id
            GROUP BY gm.id, gm.team1_id, gm.team2_id) team2_score_table
        WHERE games.id = team2_score_table.id AND games.team2_id = team2_score_table.team2_id;
    
    SELECT * FROM games;

    UPDATE games SET score_1 = 0
    WHERE score_2 IS NOT NULL AND score_1 IS NULL;

-- Calculate Ranking for teams:

