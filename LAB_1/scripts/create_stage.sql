use football_stage;
DROP TABLE IF EXISTS Seasons;
DROP TABLE IF EXISTS Standings;
DROP TABLE IF EXISTS Teams;
DROP TABLE IF EXISTS Matches;
DROP TABLE IF EXISTS Appearences;


CREATE TABLE Seasons (
  key_id INT PRIMARY KEY,
  season_id VARCHAR(10),
  season INT,
  tier INT,
  division VARCHAR(50),
  subdivision VARCHAR(50),
  winner VARCHAR(50),
  count_teams INT
);

CREATE TABLE Teams (
  key_id INT PRIMARY KEY,
  team_id VARCHAR(10),
  team_name VARCHAR(50),
  former_team_names VARCHAR(500),
  current tinyint(1),
  former tinyint(1),
  defunct tinyint(1),
  first_appearance INT
);

CREATE TABLE Matches (
  key_id INT PRIMARY KEY,
  season_id VARCHAR(10),
  season INT,
  tier INT,
  division VARCHAR(50),
  subdivision VARCHAR(50),
  match_id VARCHAR(20),
  match_name VARCHAR(100),
  home_team_id VARCHAR(10),
  home_team_name VARCHAR(50),
  away_team_id VARCHAR(10),
  away_team_name VARCHAR(50),
  score VARCHAR(10),
  home_team_score INT,
  away_team_score INT,
  home_team_score_margin INT,
  away_team_score_margin INT,
  result VARCHAR(20),
  home_team_win tinyint(1),
  away_team_win tinyint(1),
  draw tinyint(1)
);

