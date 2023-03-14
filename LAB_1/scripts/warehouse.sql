use football_wr;
DROP TABLE IF EXISTS DimYear;
DROP TABLE IF EXISTS DimTeams;
DROP TABLE IF EXISTS DimSeasons;
DROP TABLE IF EXISTS DimResult;
DROP TABLE IF EXISTS DimTierDivision;
DROP TABLE IF EXISTS FactMatches;

CREATE TABLE DimYear
(
    year_id INT PRIMARY KEY AUTO_INCREMENT,
    year    INT
);


CREATE TABLE DimTeams
(
    team_id           INT PRIMARY KEY AUTO_INCREMENT,
    team_code         VARCHAR(10),
    team_name         VARCHAR(50),
    former_team_names VARCHAR(500),
    current           tinyint(1),
    former            tinyint(1),
    defunct           tinyint(1),
    Load_Date         date not null DEFAULT '1000-01-01',
    End_Load_Date     date not null DEFAULT '3000-01-01',
    previous          INT DEFAULT NULL,
    first_appearance  INT
);


CREATE TABLE DimSeasons
(
    season_id      INT PRIMARY KEY AUTO_INCREMENT,
    winner_id      INT,
    season_code    VARCHAR(20),
    season_year_id INT,
    winner_name    VARCHAR(50),
    count_teams    INT,
    FOREIGN KEY (season_year_id) REFERENCES DimYear (year_id),
    FOREIGN KEY (winner_id) REFERENCES DimTeams (team_id)
);

CREATE TABLE DimResult
(
    result_id   INT PRIMARY KEY AUTO_INCREMENT,
    result_name VARCHAR(20)
);

CREATE TABLE DimTierDivision
(
    tier_div_sub_id INT PRIMARY KEY AUTO_INCREMENT,
    tier            INT,
    division        VARCHAR(50),
    subdivision     VARCHAR(50)
);

CREATE TABLE FactMatches
(
    match_id               INT PRIMARY KEY AUTO_INCREMENT,
    season_id              INT,
    match_name             VARCHAR(100),
    team_home_id           int,
    team_away_id           int,
    result_id              INT,
    tier_div_sub_id        INT,
    home_team_score        INT,
    away_team_score        INT,
    home_team_score_margin INT,
    away_team_score_margin INT,
    FOREIGN KEY (season_id) REFERENCES DimSeasons (season_id),
    FOREIGN KEY (team_home_id) REFERENCES DimTeams (team_id),
    FOREIGN KEY (team_away_id) REFERENCES DimTeams (team_id),
    FOREIGN KEY (result_id) REFERENCES DimResult (result_id),
    FOREIGN KEY (tier_div_sub_id) REFERENCES DimTierDivision (tier_div_sub_id)
);