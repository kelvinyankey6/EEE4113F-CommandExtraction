"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ConnectionStore = exports.ConnectionObject = void 0;
const ClientDevice_1 = require("./ClientDevice");
const DataTypes_1 = require("./DataTypes");
const PiDevice_1 = require("./PiDevice");
class ConnectionObject {
    constructor(connectionID, piDevice, clientDevice) {
        this.connectionID = connectionID;
        this.piDevice = piDevice;
        this.clientDevice = clientDevice;
    }
}
exports.ConnectionObject = ConnectionObject;
//keeps a list of singular devices and 
class ConnectionStore {
    static addPiDevice(ws, deviceId, deviceName) {
        this.piConnections.set(deviceId, new PiDevice_1.PiDevice(ws, deviceId, deviceName));
        console.log("Pi Connection Truly Established");
    }
    static addClientDevice(ws) {
        var deviceId = String(Math.floor(Math.random() * 10000));
        this.clientConnections.set(deviceId, new ClientDevice_1.ClientDevice(ws, deviceId));
    }
    static getPiDevice(deviceId) {
        return this.piConnections.get(deviceId);
    }
    static getAllConnectedPiDevices() {
        var data = [];
        for (var [_, conn] of this.piConnections.entries()) {
            data.push(conn.getDescription());
        }
        return data;
    }
    static sendOfferToPiDevice(deviceId, offer, clientDeviceId) {
        var device = this.clientConnections.get(deviceId);
        if (!device) {
            throw "";
        }
        var message = {
            type: DataTypes_1.messageTypes.recieveOffer,
            payload: offer,
            fromDeviceId: clientDeviceId
        };
        device.connection.send(JSON.stringify(message));
    }
    static sendOfferToClient(deviceId, offer, piDeviceId) {
        var device = this.clientConnections.get(deviceId);
        if (!device) {
            throw "";
        }
        var message = {
            type: DataTypes_1.messageTypes.recieveOffer,
            payload: offer,
            fromDeviceId: piDeviceId
        };
        device.connection.send(JSON.stringify(message));
    }
    static sendICEToClient(deviceId, ice, piDeviceId) {
        var device = this.clientConnections.get(deviceId);
        if (!device) {
            throw "";
        }
        var message = {
            type: DataTypes_1.messageTypes.recieveICE,
            payload: ice,
            fromDeviceId: piDeviceId
        };
        device.connection.send(JSON.stringify(message));
    }
    static sendICEToPiDevice(deviceId, ice, clientDeviceId) {
        var device = this.clientConnections.get(deviceId);
        if (!device) {
            throw "";
        }
        var message = {
            type: DataTypes_1.messageTypes.recieveICE,
            payload: ice,
            fromDeviceId: clientDeviceId
        };
        device.connection.send(JSON.stringify(message));
    }
    static registerConnection(piDeviceId, clientDeviceId) {
        var piDevice = this.piConnections.get(piDeviceId);
        var clientDevice = this.clientConnections.get(clientDeviceId);
        if (!piDevice || !clientDevice) {
            throw "";
        }
        this.piConnections.delete(piDeviceId);
        this.clientConnections.delete(clientDeviceId);
        // put them all into a connection object
        var connectionID = String(Math.floor(Math.random() * 10000));
        var connection = new ConnectionObject(connectionID, {
            connection: piDevice,
            id: piDeviceId
        }, {
            id: clientDeviceId,
            connection: clientDevice
        });
        this.sessions.set(connectionID, connection);
        //send the new session id to the pi device. Just incase we need it
        var message = {
            type: DataTypes_1.messageTypes.connectionConfirmation,
            payload: {
                sessionID: connectionID
            }
        };
        piDevice.connection.send(JSON.stringify(message));
        //return the connection id and send it back to the user
        return connectionID;
    }
}
ConnectionStore.piConnections = new Map();
ConnectionStore.clientConnections = new Map();
ConnectionStore.sessions = new Map();
exports.ConnectionStore = ConnectionStore;
