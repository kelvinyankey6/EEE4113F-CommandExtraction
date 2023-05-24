"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.PiDevice = void 0;
const ConnectionStore_1 = require("./ConnectionStore");
const DataTypes_1 = require("./DataTypes");
class PiDevice {
    constructor(ws, deviceId, deviceName) {
        this.connection = ws;
        this.deviceId = deviceId;
        this.deviceName = deviceName;
        this.setupDevice();
    }
    getDescription() {
        return {
            deviceId: this.deviceId,
            deviceName: this.deviceName
        };
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
                    list: lists
                });
                this.connection.send(bytes);
                return;
            }
            case DataTypes_1.messageTypes.sendOffer: {
                try {
                    ConnectionStore_1.ConnectionStore.sendOfferToClient(message.deviceId, message.payload, this.deviceId);
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
                    ConnectionStore_1.ConnectionStore.sendICEToClient(message.deviceId, message.payload, this.deviceId);
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
exports.PiDevice = PiDevice;
