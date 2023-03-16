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
SELECT DISTINCT team_id,
                team_name,
                former_team_names,
                current,
                former,
                defunct,
                first_appearance
FROM football_stage.Teams t
WHERE NOT EXISTS(
        SELECT 1
        FROM football_wr.DimTeams dt
        WHERE dt.team_code = t.team_id
          and dt.team_name = t.team_name
          and dt.former_team_names = t.former_team_names
          and dt.current = t.current
          and dt.former = t.former
          and dt.defunct = t.defunct
          and dt.first_appearance = t.first_appearance);

INSERT INTO football_wr.DimSeasons(winner_id, season_code, season_year_id, winner_name, count_teams)
SELECT DISTINCT dt.team_id, fss.season_id, dy.year_id, fss.winner, fss.count_teams
FROM football_stage.Seasons fss
         JOIN football_wr.DimTeams dt ON dt.team_name = fss.winner
         JOIN football_wr.DimYear dy ON dy.year = fss.season
WHERE NOT EXISTS(
        SELECT 1
        FROM football_wr.DimSeasons ds
        WHERE ds.winner_id = (select team_id from football_wr.DimTeams dt where dt.team_name = fss.winner)
          and ds.season_code = fss.season_id
          and ds.season_year_id = (select dy.year_id from football_wr.DimYear dy where dy.year = fss.season)
          and ds.winner_name = fss.winner
          and ds.count_teams = fss.count_teams);


INSERT INTO football_wr.FactMatches (season_id, match_name, team_home_id, team_away_id, home_team_score,
                                     away_team_score, home_team_score_margin, away_team_score_margin, result_id,
                                     tier_div_sub_id)
SELECT DISTINCT s.season_id,
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
              ON m.tier = td.tier and m.division = td.division and m.subdivision = td.subdivision
WHERE NOT EXISTS(
        SELECT 1
        FROM football_wr.FactMatches fm
        WHERE fm.season_id = (select season_id from football_wr.DimSeasons s where m.season_id = s.season_code)
          and fm.match_name = m.match_name
          and fm.team_home_id = (select ta.team_id from football_wr.DimTeams ta where m.away_team_id = ta.team_code)
          and fm.team_away_id = (select th.team_id from football_wr.DimTeams th where m.home_team_id = th.team_code)
          and fm.home_team_score = m.home_team_score
          and fm.away_team_score = m.away_team_score
          and fm.home_team_score_margin = m.home_team_score_margin
          and fm.away_team_score_margin = m.away_team_score_margin
          and fm.result_id = (select result_id from football_wr.DimResult r where m.result = r.result_name)
          and fm.tier_div_sub_id = (select tier_div_sub_id
                                    from football_wr.DimTierDivision td
                                    where (m.tier = td.tier and m.division = td.division and
                                           m.subdivision = td.subdivision)));
