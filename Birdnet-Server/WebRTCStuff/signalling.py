import asyncio
import websockets
from aiortc import RTCPeerConnection, RTCDataChannel

import json

# peer connection
peerConnection: RTCPeerConnection = None
dataChannel: RTCDataChannel = None


# async def echo(websocket):
#     async for message in websocket:
#         #run the function if there is one
#         try:
#             print(message)
#             result = router.runFunction(message)
#             sdx = json.dumps(result.payload)
#             print(sdx)
#             await websocket.send(sdx)
#         except Exception as e:
#             print(e)
#             await websocket.send("NOpe")

# async def main():
#     async with serve(echo, "localhost", 8765):
#         await asyncio.Future()  # run forever

# asyncio.run(main())
messageTypes = {
    "offer": 'offer',
    "register": 'register',
    "getPiDevices": 'getPiDevices',
    "sendOffer": 'sendOffer',
    "recieveOffer": 'recieveOffer',
    "sendICE": 'sendIce',
    "recieveICE": 'recieveICE',
    "connectionEstablished": 'connectionEstablished',
    "connectionConfirmation": 'connectionConfirmation'
}

async def onRecieveOffer(ws, offer):
    #
    answer = await peerConnection.createAnswer()
    await peerConnection.setLocalDescription(answer)
    await peerConnection.setRemoteDescription(offer)
    ws.send(answer)

async def onRecieveICE(ws, ice):
    await peerConnection.addIceCandidate(ice)


async def onConnectionConfirmation(ws, sessionID):
    await setupDataChannel()

def payloadToJson(payload):
    return json.dumps(payload)

async def setupDataChannel():
    dataChannel = peerConnection.createDataChannel()
    
    @dataChannel.on("open")
    def on_open():
        pass

    @dataChannel.on("message")
    def on_message(message):
        print("message sent")


async def startClient():
    url = "ws://localhost:8952"
    peerConnection = RTCPeerConnection()
    async with websockets.connect(url) as ws:
        # do stuff here
        # send a register message
        deviceID = "myhero"
        deviceName = "your mom"
        global targetDeviceId;
        targetDeviceId = None
        
        message = {
            "type": messageTypes["register"],
            "deviceId": deviceID,
            "deviceName": deviceName
        }
        bytes = payloadToJson(message)
        await ws.send(bytes)
        async for message in ws:
            messageObj = json.load(message)
            if messageObj["type"] == messageTypes["recieveOffer"]:
                targetDeviceId = messageObj["fromDeviceId"]
                onRecieveOffer(ws, messageObj["payload"])
            elif messageObj["type"] == messageTypes["recieveICE"]:
                targetDeviceId = messageObj["fromDeviceId"]
                onRecieveICE(ws, messageObj["payload"])
            elif messageObj["type"] == messageTypes["connectionConfirmation"]:
                #targetDeviceId = messageObj["fromDeviceId"]
                onConnectionConfirmation(ws, messageObj["payload"]["sessionID"])
            
if __name__ == "__main__":
    asyncio.run(startClient())