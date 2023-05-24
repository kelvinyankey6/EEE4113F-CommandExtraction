import ws, {WebSocket} from 'ws'
import { WebsocketMessage, messageTypes } from './DataTypes';
import { ConnectionStore } from './ConnectionStore';


export class ClientDevice {
    private deviceId: string
    public connection: WebSocket

    constructor(ws: WebSocket, deviceId: string){
        //console.log("Yes")
        //console.log(ws, deviceId);
        this.connection= ws;
        this.deviceId = deviceId;
        this.setupDevice();
    }




    private setupDevice() {
        this.connection.onmessage = (event) => {
            this.onMessage(event);
        };
    }


    private onMessage(event: ws.MessageEvent){
        let message: WebsocketMessage;
        
        try {
            message = JSON.parse(event.data as string)
        } catch (error) {
            this.connection.send("no man")
            return
        }

        switch (message.type){
            case messageTypes.getPiDevices: {
                // give list of all pi devices
                var lists = ConnectionStore.getAllConnectedPiDevices();

                var bytes = JSON.stringify({
                    list: lists,
                    type: messageTypes.deviceList
                })
                console.log(this.deviceId);
                this.connection.send(bytes);
                return
            }

            case messageTypes.sendOffer: {
                try {
                    
                    ConnectionStore.sendOfferToPiDevice(message.deviceId as string, message.payload, this.deviceId)
                } catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    })
                    this.connection.send(bytes)
                    return
                }
            }

            case messageTypes.sendOffer: {
                try {
                    
                    ConnectionStore.sendICEToPiDevice(message.deviceId as string, message.payload, this.deviceId)
                } catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    })
                    this.connection.send(bytes)
                    return
                }
            }

            case messageTypes.connectionEstablished: {
                var piDeviceId = message.piDeviceId;
                try {
                    if (!piDeviceId){
                        throw ""
                    }
                    var connectionID = ConnectionStore.registerConnection(this.deviceId, piDeviceId);
                    var response: WebsocketMessage = {
                        type: messageTypes.connectionConfirmation,
                        payload: {
                            sessionID: connectionID
                        }
                    }

                    this.connection.send(JSON.stringify(response));
                } catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    })
                    this.connection.send(bytes)
                    return
                }
            }


            

            default:{
                this.connection.send("naaaaaaaaaaahhhh")
            }
        }



    }
}