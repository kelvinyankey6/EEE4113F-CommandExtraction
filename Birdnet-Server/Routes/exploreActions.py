from fastapi import APIRouter
from Models.models import SearchQuery
import zipfile
from starlette.background import BackgroundTasks
from fastapi.responses import FileResponse
import os
from Database import database
import csv
import time



router = APIRouter(
    prefix= '/explore',
    tags=['explore']
)




@router.post('/search')
async def search_data(query: SearchQuery):
    
    results = database.get_data_piece(query=query)
    return results



def delete_background_temp_file(file, csvFile):
    os.unlink(file)
    os.unlink(csvFile)


@router.post('/download_data')
async def download_data(query: SearchQuery, background_tasks: BackgroundTasks):
    # First get the results
    # again. depends on data logging code
    #results = dataCRUD.searchFunction(query.startDate, query.endDate, query.limit, query.skip)
    # create the temporary file and zip archive

    results = database.get_data_piece(query=query)

    # Make a csv text file with temperature and humidity data as well as an index
    with open('./points.csv', newline='') as csvfile:
        writer = csv.writer(csvfile=csvfile, delimiter=',')
        #write heading
        writer.writerow(['Index', 'Temperature', 'Humidity', 'Time'])

        for index, result in enumerate(results):
            writer.writerow([str(index)], result["temperature"], result["humidity"], result["timeStamp"])
    

    with open('./export.zip', 'wb') as tmp:
        with zipfile.ZipFile(tmp, 'w', zipfile.ZIP_DEFLATED) as archive:
            # save the images in the zip file according to the index
            for index, result in enumerate(results):
                path = os.path.dirname("./images")
                fn = os.path.join(path, result["imageFile"])
                archive.write(fn, str(index) + ".jpeg") 
    # Reset file pointer
        tmp.seek(0)
        background_tasks.add_task(delete_background_temp_file, tmp.name, "./points.csv")
        return FileResponse(tmp.name, media_type='application/x-zip-compressed', filename=str(time.time()) + ".zip")

    # Write file data to response
        



