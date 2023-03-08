use football_wr;
DROP TABLE IF EXISTS DimSeasons;
DROP TABLE IF EXISTS DimTeams;
DROP TABLE IF EXISTS DimResult;
DROP TABLE IF EXISTS DimTierDivision;
DROP TABLE IF EXISTS FactMatches;

CREATE TABLE DimSeasons (
  season_id INT PRIMARY KEY AUTO_INCREMENT,
  season_code VARCHAR(20),
  season_year INT,
  winner VARCHAR(50),
  count_teams INT
);


CREATE TABLE DimTeams (
  team_id INT PRIMARY KEY AUTO_INCREMENT,
  team_code VARCHAR(10),
  team_name VARCHAR(50),
  former_team_names VARCHAR(500),
  current tinyint(1),
  former tinyint(1),
  defunct tinyint(1),
  first_appearance INT
);


CREATE TABLE DimResult (
  result_id INT PRIMARY KEY AUTO_INCREMENT,
  result_name VARCHAR(20)
);

CREATE TABLE DimTierDivision (
  tier_div_sub_id INT PRIMARY KEY AUTO_INCREMENT,
  tier INT,
  division VARCHAR(50),
  subdivision VARCHAR(50)
);

CREATE TABLE FactMatches (
  match_id INT PRIMARY KEY AUTO_INCREMENT,
  season_id INT,
  match_name VARCHAR(100),
  team_home_id int,
  team_away_id int,
  score VARCHAR(10),
  home_team_score INT,
  away_team_score INT,
  home_team_score_margin INT,
  away_team_score_margin INT,
  result_id INT,
  tier_div_sub_id INT,
  FOREIGN KEY (season_id) REFERENCES DimSeasons(season_id),
  FOREIGN KEY (team_home_id) REFERENCES DimTeams(team_id),
  FOREIGN KEY (team_away_id) REFERENCES DimTeams(team_id),
  FOREIGN KEY (result_id) REFERENCES DimResult(result_id),
  FOREIGN KEY (tier_div_sub_id) REFERENCES DimTierDivision(tier_div_sub_id)
);