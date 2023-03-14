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