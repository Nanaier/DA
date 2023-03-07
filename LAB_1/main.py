import mysql.connector as mysql
import pandas as pd

def executeScriptsFromFile(filename):
    fd = open(filename, 'r')
    sqlFile = fd.read()
    fd.close()
    sqlCommands = sqlFile.split(';')

    for command in sqlCommands:
        try:
            if command.strip() != '':
                cursor.execute(command)
        except IOError as msg:
            print("Command skipped: ", msg)

db = mysql.connect(
    host = "localhost",
    user = "root",
    passwd = "02042004"
)
cursor = db.cursor()

executeScriptsFromFile('scripts/create_stage_db.sql')
db.commit()
executeScriptsFromFile('scripts/create_wh_db.sql')
db.commit()

stage_db = mysql.connect(
    host = "localhost",
    user = "root",
    password = "02042004",
    database = "football_stage"
)

cursor = stage_db.cursor()
executeScriptsFromFile('scripts/create_stage.sql')
stage_db.commit()
executeScriptsFromFile('scripts/insert.sql')
stage_db.commit()

warehouse_db = mysql.connect(
    host = "localhost",
    user = "root",
    password = "02042004",
    database = "football_wr"
)

cursor = warehouse_db.cursor()
executeScriptsFromFile('scripts/warehouse.sql')
warehouse_db.commit()
executeScriptsFromFile('scripts/connect.sql')
warehouse_db.commit()




