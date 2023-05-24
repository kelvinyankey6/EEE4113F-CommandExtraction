from os import getcwd
from fastapi import APIRouter, File
from fastapi.responses import FileResponse

router = APIRouter(
    prefix='/files',
    tags=['download']

)






@router.get('/download/images/{file_name}')
async def download_image(file_name: str):
    #TODO: Fix according to data logging code
    return FileResponse(path=getcwd() + "/images/" + file_name, media_type='image/jpeg', filename=file_name)