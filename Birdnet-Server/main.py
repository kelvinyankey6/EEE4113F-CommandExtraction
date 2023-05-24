import datetime
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from Routes import statusMessages
from Routes import basicActions
from Routes import sensorCapture
from Routes import downloadFiles
from Routes import exploreActions
import uvicorn


app = FastAPI()


origins = [
    "*"
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(statusMessages.router)
app.include_router(basicActions.router)
app.include_router(sensorCapture.router)
app.include_router(downloadFiles.router)
app.include_router(exploreActions.router)

@app.get('/heartbeat')
async def heartbeat():
    return;

if __name__ == "__main__":
    uvicorn.run("main:app", host="0.0.0.0", port=8000, log_level="info", reload=True)


