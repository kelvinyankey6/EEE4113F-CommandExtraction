from datetime import datetime
import os
import time
from typing import Annotated
from fastapi import FastAPI, File, UploadFile


#needs to be here. Used in dashboard view
latest_temperature = 0.0;
latest_humidity = 0.0

def searchFunction(day1, day2, limit: int, skip: int):
    
    # This function should return a list of these dictionaries
    # example below
    # optional stuff
    # limit indicates the limit of data we want: so the size of this array
    # skip determines where you should start from. Say you got the search function and you have the list
    # if skip was 1, youd start from the second element and if limit was 5, youd only count the next 4 elements
    result = []
    image_dir = "./images/"
    for filename in os.listdir(image_dir):
        if not (filename.endswith(".jpeg") or filename.endswith(".txt")):
            continue
        file_date_str = filename.split(".")[0]
        file_date = datetime.strptime(file_date_str, "%a %b %d %H:%M:%S %Y")
        if day1 <= file_date <= day2:
            result.append(os.path.join(image_dir, filename))
    return result

def saveFunction(imageFile: Annotated[bytes, File()], temperature: float = 0.0, humidity: float = 0.0):
    latest_temperature = temperature
    latest_humidity = humidity
    # Write save Function here