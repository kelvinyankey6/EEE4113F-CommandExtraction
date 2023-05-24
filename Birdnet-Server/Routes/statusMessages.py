import shutil
from fastapi import APIRouter
import os
import psutil
import uuid
from Database import database
from Routes import sensorCapture



router = APIRouter(
    prefix='/healthstatus',
    tags=['health']
)




@router.get('/temperaturehumidity/latest')
async def latest_data():
    # TODO: update with accurate reading
    return {
        "temperature": sensorCapture.latest_temp,
        "humidity": sensorCapture.latest_hum
    }



@router.get("/cpu/latest")
async def cpuload_latest():
    # TODO: update with cpu load reading
    #get cpu load
    load1, load5, load15 = psutil.getloadavg()
    cpu_usage = round((load5/os.cpu_count()) * 100, 2)
    #get ram usage
    total_memory, used_memory, free_memory = map(int, os.popen('free -t -m').readlines()[-1].split()[1:])
    ram_usage = round((used_memory/total_memory) * 100)
    return {
        "cpu_usage": cpu_usage,
        "ram_usage": ram_usage
    }

@router.get('/storage/latest')
async def storage_latest():
    total, used, free = shutil.disk_usage("/")
    totalSize = total // (2**30)
    freeSize = free // (2**30)    
    perc = round((freeSize/totalSize) * 100, 2)
    return {
        "total": totalSize,
        "free": freeSize,
        "percentage": perc,
    }    


@router.get('/battery/latest')
async def battery_level():
    # TODO: Not done yet
    return {
        "battery_level": 86.0

    }

@router.get("/events_captured/today")
async def events_captured():
    # TODO: Naah fam
    print(database.get_events_captured_today())
    return {
        "events": database.get_events_captured_today()
    }


@router.get("/device_details")
async def device_details():
    
    return {
        "device_name": "Cancerous Snake",
        "device_id": uuid.uuid4().hex
    }


@router.get('/all')
async def get_all_status_messages():
    print(sensorCapture.latest_hum)
    devicedetails = await device_details();
    eventscaptured = await events_captured();
    batterylevel = await battery_level();
    storagelatest = await storage_latest();
    cpuloadlatest = await cpuload_latest()
    temphumid = await latest_data();

    return {
        "details": devicedetails,
        "events": eventscaptured,
        "battery": batterylevel,
        "storage": storagelatest,
        "cpuload": cpuloadlatest,
        "temphumid": temphumid
    }
    
    

