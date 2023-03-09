use football_stage;

INSERT INTO football_wr.DimYear(year)
SELECT DISTINCT season
FROM football_stage.Seasons s
WHERE s.season IS NOT NULL
  AND NOT EXISTS(
        SELECT year_id
        FROM football_wr.DimYear dy
        WHERE dy.year = s.season);

INSERT INTO football_wr.DimTeams(team_code, team_name, former_team_names, current, former, defunct, first_appearance)
SELECT DISTINCT
                team_id,
                team_name,
                former_team_names,
                current,
                former,
                defunct,
                first_appearance
FROM football_stage.Teams;

INSERT INTO football_wr.DimSeasons(winner_id, season_code, season_year_id, winner_name, count_teams)
SELECT DISTINCT dt.team_id, fss.season_id, dy.year_id, fss.winner, fss.count_teams
FROM football_stage.Seasons fss
         JOIN football_wr.DimTeams dt ON dt.team_name = fss.winner
         JOIN football_wr.DimYear dy ON dy.year = fss.season;


INSERT INTO football_wr.DimResult (result_id, result_name)
VALUES (1, 'home team win'),
       (2, 'away team win'),
       (3, 'draw');

INSERT INTO football_wr.DimTierDivision(tier, division, subdivision)
SELECT DISTINCT tier, division, subdivision
FROM football_stage.Matches m
WHERE m.tier IS NOT NULL
  AND NOT EXISTS(
        SELECT tier, division, subdivision
        FROM football_wr.DimTierDivision td
        WHERE td.tier = m.tier
          AND td.division = m.division
          AND td.subdivision = m.subdivision);


INSERT INTO football_wr.FactMatches (season_id, match_name, team_home_id, team_away_id, home_team_score,
                                     away_team_score, home_team_score_margin, away_team_score_margin, result_id,
                                     tier_div_sub_id)
SELECT s.season_id,
       m.match_name,
       th.team_id,
       ta.team_id,
       m.home_team_score,
       m.away_team_score,
       m.home_team_score_margin,
       m.away_team_score_margin,
       r.result_id,
       td.tier_div_sub_id
FROM football_stage.Matches m
         JOIN football_wr.DimSeasons s ON m.season_id = s.season_code
         JOIN football_wr.DimTeams ta ON m.away_team_id = ta.team_code
         JOIN football_wr.DimTeams th ON m.home_team_id = th.team_code
         JOIN football_wr.DimResult r ON m.result = r.result_name
         JOIN football_wr.DimTierDivision td
              ON m.tier = td.tier and m.division = td.division and m.subdivision = td.subdivision;
