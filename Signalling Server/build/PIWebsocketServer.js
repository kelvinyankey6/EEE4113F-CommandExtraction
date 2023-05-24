"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PiServer = void 0;
const ws_1 = require("ws");
const DataTypes_1 = require("./DataTypes");
const ConnectionStore_1 = require("./ConnectionStore");
class PiServer {
    constructor(port) {
        this.port = port;
        this.StartServer();
    }
    StartServer() {
        this.server = new ws_1.WebSocketServer({
            port: this.port
        });
        this.server.on('connection', (ws) => {
            ws.onmessage = function (event) {
                let message;
                try {
                    message = JSON.parse(event.data);
                }
                catch (error) {
                    ws.send('error man');
                    return;
                }
                switch (message.type) {
                    case DataTypes_1.messageTypes.offer: {
                    }
                    case DataTypes_1.messageTypes.register: {
                        //register the device in the list
                        if (!message.deviceId || !message.deviceName) {
                            return;
                        }
                        ConnectionStore_1.ConnectionStore.addPiDevice(ws, message.deviceId, message.deviceName);
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
        console.log("Pi Server Started");
    }
}
exports.PiServer = PiServer;
