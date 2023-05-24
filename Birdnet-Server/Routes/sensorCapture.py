#everything related to the data capture from the sensor is here

import os
from fastapi import APIRouter
from typing import Annotated
from fastapi import File
import time
from Database import database


latest_temp: float = 0;
latest_hum: float = 0

router = APIRouter(
    prefix='/sensor_capture',
    tags=['sensor_capture']

)

# imageFile: Annotated[bytes, File()]

@router.post('/image/submit')
async def image_submit(imageFile: Annotated[bytes, File()], temperature: float = 0.0, humidity: float = 0.0):
   
    # TODO: Write storage code 
    imageName = str(time.time())
    latest_hum = humidity
    latest_temp = temperature
    if not os.path.exists("image"):
    # If it doesn't exist, create it
        os.makedirs("image")
    with open("./images/" + imageName + ".jpeg", "wb") as binary_file:
   
    # Write bytes to file
        binary_file.write(imageFile)

    database.save_data_piece(temperature=temperature, humidity=humidity, imageFileLocation=imageName)
    # save or do something here