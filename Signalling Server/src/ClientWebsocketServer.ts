import Websocket, {WebSocketServer} from 'ws'
import {WebsocketMessage, messageTypes} from './DataTypes'
import { ConnectionStore } from './ConnectionStore';

export class ClientServer {
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
            console.log("WIEONWOIFNWOEINFOWENFoi")
            ws.onmessage = function (event) {
            let message: WebsocketMessage;
            
            try {
                message = JSON.parse(event.data as string)

            } catch (error) {
                console.log("dnwiodw")
                ws.send('error man')
                return
            }

            switch (message.type){
                case messageTypes.register: {
                    //register the device in the list
                   
                    ConnectionStore.addClientDevice(ws);
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
        console.log("Client Server Started")
    }


}