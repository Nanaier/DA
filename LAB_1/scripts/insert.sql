use football_stage;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/matches.csv' INTO TABLE matches
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (key_id, season_id, season, tier, division, subdivision, match_id, match_name, home_team_id, home_team_name,
     away_team_id, away_team_name, score, home_team_score, away_team_score, home_team_score_margin,
     away_team_score_margin, result, home_team_win, away_team_win, draw);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Seasons.csv' INTO TABLE seasons
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (key_id, season_id, season, tier, division, subdivision, winner, count_teams);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/teams.csv' INTO TABLE teams
    FIELDS TERMINATED BY ','
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS
    (key_id, team_id, team_name, former_team_names, current, former, defunct, first_appearance);


