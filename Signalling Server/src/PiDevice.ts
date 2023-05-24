import ws, { WebSocket } from "ws";
import { ConnectionStore } from "./ConnectionStore";
import { WebsocketMessage, messageTypes } from "./DataTypes";




export class PiDevice {
    private deviceId: string
    private deviceName: string
    public connection: WebSocket

    constructor(ws: WebSocket, deviceId: string, deviceName: string){
        this.connection = ws;
        this.deviceId = deviceId;
        this.deviceName = deviceName;
        this.setupDevice();
    }



    public getDescription(){
        return {
            deviceId: this.deviceId,
            deviceName: this.deviceName
        }
    }

    private setupDevice() {
        this.connection.onmessage = (event) => {
            this.onMessage(event)
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
                    list: lists
                })

                this.connection.send(bytes);
                return
            }

            case messageTypes.sendOffer: {
                try {
                    
                    ConnectionStore.sendOfferToClient(message.deviceId as string, message.payload, this.deviceId)
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
                    
                    ConnectionStore.sendICEToClient(message.deviceId as string, message.payload, this.deviceId)
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