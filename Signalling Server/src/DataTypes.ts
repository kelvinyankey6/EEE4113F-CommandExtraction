export interface WebsocketMessage {
    type: string;
    //for use with register func
    deviceId?: string;
    deviceName?: string;
    payload?: any;
    fromDeviceId?: string;
    piDeviceId?: string
}

export const messageTypes = {
    offer: 'offer',
    register: 'register',
    getPiDevices: 'getPiDevices',
    sendOffer: 'sendOffer',
    recieveOffer: 'recieveOffer',
    sendICE: 'sendIce',
    recieveICE: 'recieveICE',
    connectionEstablished: 'connectionEstablished',
    connectionConfirmation: 'connectionConfirmation',
    deviceList: "deviceList",
}