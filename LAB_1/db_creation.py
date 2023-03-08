import mysql.connector as mysql
from helper_func import executeScriptsFromFile


def create_databases():
    db = mysql.connect(
        host = "localhost",
        user = "root",
        passwd = "02042004"
    )
    cursor = db.cursor()

    executeScriptsFromFile('scripts/create_stage_db.sql', cursor)
    db.commit()
    executeScriptsFromFile('scripts/create_wh_db.sql', cursor)
    db.commit()
