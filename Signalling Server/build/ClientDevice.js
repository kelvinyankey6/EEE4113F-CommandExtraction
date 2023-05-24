"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ClientDevice = void 0;
const DataTypes_1 = require("./DataTypes");
const ConnectionStore_1 = require("./ConnectionStore");
class ClientDevice {
    constructor(ws, deviceId) {
        //console.log("Yes")
        //console.log(ws, deviceId);
        this.connection = ws;
        this.deviceId = deviceId;
        this.setupDevice();
    }
    setupDevice() {
        this.connection.onmessage = (event) => {
            this.onMessage(event);
        };
    }
    onMessage(event) {
        let message;
        try {
            message = JSON.parse(event.data);
        }
        catch (error) {
            this.connection.send("no man");
            return;
        }
        switch (message.type) {
            case DataTypes_1.messageTypes.getPiDevices: {
                // give list of all pi devices
                var lists = ConnectionStore_1.ConnectionStore.getAllConnectedPiDevices();
                var bytes = JSON.stringify({
                    list: lists,
                    type: DataTypes_1.messageTypes.deviceList
                });
                console.log(this.deviceId);
                this.connection.send(bytes);
                return;
            }
            case DataTypes_1.messageTypes.sendOffer: {
                try {
                    ConnectionStore_1.ConnectionStore.sendOfferToPiDevice(message.deviceId, message.payload, this.deviceId);
                }
                catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    });
                    this.connection.send(bytes);
                    return;
                }
            }
            case DataTypes_1.messageTypes.sendOffer: {
                try {
                    ConnectionStore_1.ConnectionStore.sendICEToPiDevice(message.deviceId, message.payload, this.deviceId);
                }
                catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    });
                    this.connection.send(bytes);
                    return;
                }
            }
            case DataTypes_1.messageTypes.connectionEstablished: {
                var piDeviceId = message.piDeviceId;
                try {
                    if (!piDeviceId) {
                        throw "";
                    }
                    var connectionID = ConnectionStore_1.ConnectionStore.registerConnection(this.deviceId, piDeviceId);
                    var response = {
                        type: DataTypes_1.messageTypes.connectionConfirmation,
                        payload: {
                            sessionID: connectionID
                        }
                    };
                    this.connection.send(JSON.stringify(response));
                }
                catch (error) {
                    var bytes = JSON.stringify({
                        "error": "naah bro"
                    });
                    this.connection.send(bytes);
                    return;
                }
            }
            default: {
                this.connection.send("naaaaaaaaaaahhhh");
            }
        }
    }
}
exports.ClientDevice = ClientDevice;
