import Websocket, {WebSocketServer} from 'ws'
import {WebsocketMessage, messageTypes} from './DataTypes'
import { ConnectionStore } from './ConnectionStore';

export class PiServer {
    private port: number
    private server!: WebSocketServer;
   

    constructor(port: number){
        this.port = port;
        this.StartServer()
    }



    private StartServer() {
        this.server = new WebSocketServer({
            port: this.port
        })
        this.server.on('connection', (ws) => {
            ws.onmessage = function (event) {
            let message: WebsocketMessage;
            try {
                message = JSON.parse(event.data as string)

            } catch (error) {
                ws.send('error man')
                return
            }

            switch (message.type){
                case messageTypes.offer: {

                }
                case messageTypes.register: {
                    //register the device in the list
                    if (!message.deviceId || !message.deviceName){
                        return;
                    }

                    ConnectionStore.addPiDevice(ws, message.deviceId, message.deviceName);
                    return;

                    
                }

                default: {
                    ws.send("unrecognized message")
                }
            }
            };
            ws.onerror = function (event: Websocket.ErrorEvent){
                console.log("error")
            };
        })
        console.log("Pi Server Started")
    }


}