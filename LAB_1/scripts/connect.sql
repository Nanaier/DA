use football_stage;

INSERT INTO football_wr.DimSeasons
SELECT DISTINCT key_id, season_id, season, winner, count_teams
FROM football_stage.Seasons;

INSERT INTO football_wr.DimTeams
SELECT DISTINCT key_id, team_id, team_name, former_team_names, current, former, defunct, first_appearance
FROM football_stage.Teams;

INSERT INTO football_wr.DimResult (result_id, result_name)
VALUES
(1, 'home team win'),
(2, 'away team win'),
(3, 'draw');

INSERT INTO football_wr.DimTierDivision(tier, division, subdivision)
SELECT DISTINCT tier, division, subdivision
FROM football_stage.Matches;


INSERT INTO football_wr.FactMatches (season_id, match_name, team_home_id, team_away_id,  home_team_score, away_team_score, home_team_score_margin, away_team_score_margin, result_id, tier_div_sub_id)
SELECT s.season_id, m.match_name, th.team_id, ta.team_id, m.home_team_score, m.away_team_score, m.home_team_score_margin, m.away_team_score_margin, r.result_id, td.tier_div_sub_id
FROM football_stage.Matches m
JOIN football_wr.DimSeasons s ON m.season_id = s.season_code
JOIN football_wr.DimTeams ta ON m.away_team_id = ta.team_code
JOIN football_wr.DimTeams th ON m.home_team_id = th.team_code
JOIN football_wr.DimResult r ON m.result = r.result_name
JOIN football_wr.DimTierDivision td ON m.tier = td.tier and m.division = td.division and m.subdivision = td.subdivision;


