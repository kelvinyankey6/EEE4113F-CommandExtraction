from fastapi import APIRouter
import os

router = APIRouter(
    prefix='/basicActions',
    tags=['basicActions']

)





@router.get('/restart')
async def restart_action():
    print("REBOOTING")
    os.system("shutdown -t 0 -r -f")


@router.get('/shutdown')
async def shutdown_action():
    print("Shutting down")
    os.system("shutdown -n now")

@router.get("/clearStorage")
async def clear_storage():
    # clears the local images storage
    # need to be completed by data logging
    pass
    os.system("rf -r ./images/*")

# @router.get('/checkSensorStatus')
# async def checkSensorStatus():
#     # TODO: Idea is to see if temp, humidity and camera sensors are currently on
        # NOTE: GG
#     return {
#         "temperature": True,
#         "humidity": True,
#         "camera": True
#     }