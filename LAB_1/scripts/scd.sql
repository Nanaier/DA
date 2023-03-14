DROP PROCEDURE IF EXISTS football_wr.scd_teams;

DELIMITER $$
CREATE PROCEDURE football_wr.scd_teams(old_name varchar(70), new_name varchar(70))
BEGIN
    DECLARE old_id int DEFAULT null;
    DECLARE old_team_code VARCHAR(10);
    DECLARE old_former_team_names VARCHAR(500);
    DECLARE old_current TINYINT(1);
    DECLARE old_former TINYINT(1);
    DECLARE old_defunct TINYINT(1);
    DECLARE old_first_appearance INT;
    DECLARE new_id int;

    SELECT team_id, team_code, former_team_names, current, former, defunct, first_appearance
    into old_id, old_team_code, old_former_team_names, old_current, old_former, old_defunct, old_first_appearance
    FROM dimteams
    WHERE team_name = old_name;
    IF old_id IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Old team name has not been found!';
    ELSE
        INSERT INTO dimteams (team_code, team_name, former_team_names, current, former, defunct, Load_Date, previous,
                              first_appearance)
            VALUE (old_team_code, new_name,
                   IF(old_former_team_names = "None", old_name, CONCAT(old_former_team_names, "|", old_name)),
                   old_current, old_former, old_defunct, CURRENT_DATE, old_id, old_first_appearance);
        UPDATE dimteams
        SET End_Load_Date = CURRENT_DATE
        WHERE team_id = old_id;

        SELECT team_id
        into new_id
        FROM dimteams
        WHERE team_name LIKE new_name;
    end if;
end $$

DELIMITER ;
