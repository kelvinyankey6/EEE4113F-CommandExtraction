import { ClientDevice } from "./ClientDevice";
import { WebsocketMessage, messageTypes } from "./DataTypes";
import { PiDevice } from "./PiDevice"
import {WebSocket} from 'ws'

export class ConnectionObject {
    public connectionID: string;
    public piDevice: {
        id: string;
        connection: PiDevice
    };
    public clientDevice: {
        id: string;
        connection: ClientDevice
    }

    constructor(connectionID: string, piDevice: {
        id: string;
        connection: PiDevice
    }, clientDevice: {
        id: string;
        connection: ClientDevice
    }) {
        this.connectionID = connectionID;
        this.piDevice = piDevice;
        this.clientDevice = clientDevice;
    }
}


//keeps a list of singular devices and 
export class ConnectionStore {
    private static piConnections: Map<string, PiDevice> = new Map();

    private static clientConnections: Map<string, ClientDevice> = new Map();
    public static sessions: Map<string, ConnectionObject> = new Map();



    public static addPiDevice(ws: WebSocket, deviceId: string, deviceName: string){
        this.piConnections.set(deviceId, new PiDevice(ws, deviceId, deviceName))
        console.log("Pi Connection Truly Established")
    }

    public static addClientDevice(ws: WebSocket){
        var deviceId = String(Math.floor(Math.random()*10000));
        this.clientConnections.set(deviceId, new ClientDevice(ws, deviceId))
    }


    public static getPiDevice(deviceId: string){
        return this.piConnections.get(deviceId)
    }


    public static getAllConnectedPiDevices(){
        var data = []

        for (var [_, conn] of this.piConnections.entries()){
            data.push(conn.getDescription())
        }
        return data;
    }


    public static sendOfferToPiDevice(deviceId: string, offer: any, clientDeviceId: string){
        var device = this.clientConnections.get(deviceId)
        if (!device){
            throw ""
        }
        var message: WebsocketMessage = {
            type: messageTypes.recieveOffer,
            payload: offer,
            fromDeviceId: clientDeviceId

        }
        device.connection.send(JSON.stringify(message))
    }

    public static sendOfferToClient(deviceId: string, offer: any, piDeviceId: string){
        var device = this.clientConnections.get(deviceId)
        if (!device){
            throw ""
        }
        var message: WebsocketMessage = {
            type: messageTypes.recieveOffer,
            payload: offer,
            fromDeviceId: piDeviceId

        }
        device.connection.send(JSON.stringify(message))
    }

    public static sendICEToClient(deviceId: string, ice: any, piDeviceId: string){
        var device = this.clientConnections.get(deviceId)
        if (!device){
            throw ""
        }
        var message: WebsocketMessage = {
            type: messageTypes.recieveICE,
            payload: ice,
            fromDeviceId: piDeviceId

        }
        device.connection.send(JSON.stringify(message))
    }

    public static sendICEToPiDevice(deviceId: string, ice: any, clientDeviceId: string){
        var device = this.clientConnections.get(deviceId)
        if (!device){
            throw ""
        }
        var message: WebsocketMessage = {
            type: messageTypes.recieveICE,
            payload: ice,
            fromDeviceId: clientDeviceId

        }
        device.connection.send(JSON.stringify(message))
    }


    public static registerConnection(piDeviceId: string, clientDeviceId: string){
        var piDevice = this.piConnections.get(piDeviceId);
        var clientDevice = this.clientConnections.get(clientDeviceId);
        if (!piDevice || !clientDevice){
            throw ""
        }

        this.piConnections.delete(piDeviceId);
        this.clientConnections.delete(clientDeviceId);
        // put them all into a connection object
        var connectionID = String(Math.floor(Math.random()*10000));
        var connection: ConnectionObject = new ConnectionObject(
            connectionID,
            {
                connection: piDevice,
                id: piDeviceId
            },
            {
                id: clientDeviceId,
                connection: clientDevice
            }
        )

        this.sessions.set(connectionID, connection);
        //send the new session id to the pi device. Just incase we need it


        var message: WebsocketMessage = {
            type: messageTypes.connectionConfirmation,
            payload: {
                sessionID: connectionID
            }
        }

        piDevice.connection.send(JSON.stringify(message))

        //return the connection id and send it back to the user
        return connectionID
    }
}