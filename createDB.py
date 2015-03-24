"""
Parking Fines Project, Part I - Create SQL Database
David C. Wallace
Updated March 3rd, 2015.
"""

import sqlite3
import csv
import codecs


db = sqlite3.connect('bmorefines')
#create the database

cursor = db.cursor()
#cursor executes SQL commands

db.text_factory = str
#Fixes string format for importing data

cursor.execute('''
    CREATE TABLE fines(tag TEXT,citation INT,expmm INT,
    expyy INT,make TEXT,state TEXT,location TEXT,
    violCode INT,Description TEXT,violFine FLOAT,
    violDate TEXT,violTime TEXT,balance FLOAT,
    openFine FLOAT,openPenalty FLOAT, blank NULL,
    violDay TEXT, violMonth TEXT,violDOM TEXT,violYear TEXT)
''')
#Create table holding all Baltimore City parking fines from the last two years
#Data available at https://data.baltimorecity.gov/analytics

def get_raw(f):
    data = []
    file = codecs.open(f, 'rU')
    try:
        reader = csv.reader(file)
        for row in reader:
            data.append(row)
        for i in range(len(data)):
            dateClean = data[i][10].replace(',', '').split(' ')
            try:    
                data[i].append(dateClean[0])
            except IndexError:
                data[i].append('')
            try:    
                data[i].append(dateClean[1])
            except IndexError:
                data[i].append('')
            try:    
                data[i].append(dateClean[2])
            except IndexError:
                data[i].append('')
            try:    
                data[i].append(dateClean[3])
            except IndexError:
                data[i].append('')
    finally:
        file.close()
    return data         

to_db = get_raw('BMparkingfines1415.csv')
#Import data from csv file, create table to send to database

cursor.executemany('''INSERT INTO fines(tag,citation,expmm,
expyy,make,state,location,violCode,Description,violFine,violDate,
violTime,balance,openFine,openPenalty, blank, violDay, violMonth,violDOM,violYear) 
VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);''', to_db)
#Send data to database

db.commit()
db.close()
#Close the database so we can access it via SQLite3 in a terminal window.
