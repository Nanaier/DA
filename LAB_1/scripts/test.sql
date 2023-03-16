select *
from football_wr.dimseasons
where (football_wr.dimseasons.season_code = "S-1894-2");
select *
from football_wr.factmatches fm
         join football_wr.DimSeasons s ON fm.season_id = s.season_id
         JOIN football_wr.DimTeams ta ON fm.team_away_id = ta.team_id
         JOIN football_wr.DimTeams th ON fm.team_home_id = th.team_id
where (fm.match_name = "Blackburn Rovers vs Darwen");

select *
from football_stage.matches
where (football_stage.matches.match_name = "Blackburn Rovers vs Darwen");


call football_wr.scd_teams("Accrington", "Accrington12345");

INSERT INTO football_stage.Seasons
    (season_id, season, tier, division, subdivision, winner, count_teams)
VALUES
    ("S-2022-1", 2022, 1, "First Division", "None", "Anastasiia United", 24);

INSERT INTO football_stage.Teams
    (team_id, team_name, former_team_names, current, former, defunct, first_appearance)
VALUES
    ("T-145","Anastasiia United","None",1,0,0,2021);


INSERT INTO football_stage.Teams
    (team_id, team_name, former_team_names, current, former, defunct, first_appearance)
VALUES
    ("T-146","Olena United","None",1,0,0,2021);

INSERT INTO football_stage.matches
    (season_id, season, tier, division, subdivision, match_id, match_name, home_team_id, home_team_name,
     away_team_id, away_team_name, score, home_team_score, away_team_score, home_team_score_margin,
     away_team_score_margin, result, home_team_win, away_team_win, draw)
VALUES
    ("S-2022-1",2022,1,"First Division", "None","M-2022-1-001","Anastasiia United vs Olena United","T-145","Anastasiia United","T-146","Olena United","2-1",2,1,1,-1,"home team win",1,0,0
);

