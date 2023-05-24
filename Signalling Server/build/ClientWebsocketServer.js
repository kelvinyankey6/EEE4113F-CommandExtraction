"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClientServer = void 0;
const ws_1 = require("ws");
const DataTypes_1 = require("./DataTypes");
const ConnectionStore_1 = require("./ConnectionStore");
class ClientServer {
    constructor(port) {
        this.port = port;
        this.StartServer();
    }
    StartServer() {
        this.server = new ws_1.WebSocketServer({
            port: this.port
        });
        this.server.on('connection', (ws) => {
            console.log("WIEONWOIFNWOEINFOWENFoi");
            ws.onmessage = function (event) {
                let message;
                try {
                    message = JSON.parse(event.data);
                }
                catch (error) {
                    console.log("dnwiodw");
                    ws.send('error man');
                    return;
                }
                switch (message.type) {
                    case DataTypes_1.messageTypes.register: {
                        //register the device in the list
                        ConnectionStore_1.ConnectionStore.addClientDevice(ws);
                        return;
                    }
                    default: {
                        ws.send("unrecognized message");
                    }
                }
            };
            ws.onerror = function (event) {
                console.log("error");
            };
        });
        console.log("Client Server Started");
    }
}
exports.ClientServer = ClientServer;
