import mysql.connector as mysql
from helper_func import executeScriptsFromFile


def create_warehouse():
    warehouse_db = mysql.connect(
        host="localhost",
        user="root",
        password="02042004",
        database="football_wr"
    )
    cursor = warehouse_db.cursor()
    executeScriptsFromFile('scripts/warehouse.sql', cursor)
    warehouse_db.commit()
    executeScriptsFromFile('scripts/connect.sql', cursor)
    warehouse_db.commit()

