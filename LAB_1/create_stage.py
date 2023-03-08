import mysql.connector as mysql
from helper_func import executeScriptsFromFile


def create_insert_stage():
    stage_db = mysql.connect(
        host="localhost",
        user="root",
        password="02042004",
        database="football_stage"
    )
    cursor = stage_db.cursor()
    executeScriptsFromFile('scripts/create_stage.sql', cursor)
    stage_db.commit()
    executeScriptsFromFile('scripts/insert.sql', cursor)
    stage_db.commit()
