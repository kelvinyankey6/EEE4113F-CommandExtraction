"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const ClientWebsocketServer_1 = require("./ClientWebsocketServer");
const PIWebsocketServer_1 = require("./PIWebsocketServer");
const clientServer = new ClientWebsocketServer_1.ClientServer(8649);
const piServer = new PIWebsocketServer_1.PiServer(8952);
