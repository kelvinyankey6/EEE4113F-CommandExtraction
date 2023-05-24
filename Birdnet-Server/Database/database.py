import sqlite3
import uuid
import datetime
import os
from Models.models import SearchQuery

path = os.path.join(os.getcwd(), "/birdnet.sqlite")
print(path)

con = sqlite3.connect("./birdnet.sqlite")

cur = con.cursor()

def create_data_table():
    cur.execute("CREATE TABLE IF NOT EXISTS birdnet(temperature, humidity, imageFile, timeStamp DATETIME DEFAULT CURRENT_TIMESTAMP);")





def create_identifier_table():
    cur.execute("CREATE TABLE IF NOT EXISTS birdnetidentifier(deviceName, deviceId);")




def get_device_details():
    res = cur.execute("SELECT deviceId, deviceName FROM birdnetidentifier")
    data = res.fetchone()
    if data is None:
        # need to insert a new item in the list
        deviceId = uuid.uuid4().hex;
        deviceName = "Cancerous Snake"
        cur.executemany("INSERT INTO birdnetidentifier VALUES(?, ?)", [
            (deviceName, deviceId)
        ])
        con.commit()

        return deviceId, deviceName
    print("dwd")
    return data


def save_data_piece(temperature, humidity, imageFileLocation):
    rows = [
        (temperature, humidity, imageFileLocation)
    ]

    cur.executemany("INSERT INTO birdnet (temperature, humidity, imageFile) VALUES(?, ?, ?)", rows)
    con.commit()
    print("saved")

def toDataPieces(x):
    return {
        "temperature": x[0],
        "humidity": x[1],
        "image": x[2]
    }


def get_data_piece(query: SearchQuery):
    query.minHum = query.minHum if query.minHum is not None else 0
    query.maxHum = query.maxHum if query.maxHum is not None else 300
    query.minTemp = query.minTemp if query.minTemp is not None else 0
    query.maxTemp = query.minTemp if query.minTemp is not None else 300
    startDate = datetime.datetime.fromtimestamp(query.startDate)
    endDate = datetime.datetime.fromtimestamp(query.endDate)
    print("Got dattime")
    row = (
        # startDate, endDate, query.minHum, query.maxHum, query.minTemp, query.maxTemp,
        startDate, endDate
    )

    
    #res = cur.execute("SELECT temperature, humidity, imageFIle, timeStamp FROM birdnet WHERE (timeStamp > ? AND timeStamp < ? AND humidity > ? AND humidity < ? AND temperature > ? temperature < ?)", row)
    res = cur.execute("SELECT temperature, humidity, imageFIle FROM birdnet WHERE (timeStamp > ? AND timeStamp < ?)", row)
    results = res.fetchall()
    print(results)
    return list(map(toDataPieces, results))

def get_events_captured_today():
    noww = datetime.datetime.now()
    today = datetime.datetime(2001, noww.month, noww.day)
    print(today)
    row = [today]
        
    
    res = cur.execute("SELECT COUNT(*) FROM birdnet WHERE (timeStamp > ?)", row)
    return res.fetchone()[0]

create_data_table()
create_identifier_table()