



import 'dart:convert';

import 'package:system_design_ui_project/ConnectedDevicesObject.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;
typedef OnDeviceListFunc = Function(List<ConnectedDevicesObject>);

typedef VoidFunction = void Function();

class SignallingConnection {

  late WebSocketChannel channel;


  OnDeviceListFunc? onDeviceListFunc;
  VoidFunction? onConnected;
  VoidFunction? onDisconnected;


  Map<String, String> messageTypes = {
    "offer": 'offer',
    "register": 'register',
    "getPiDevices": 'getPiDevices',
    "sendOffer": 'sendOffer',
    "recieveOffer": 'recieveOffer',
    "sendICE": 'sendIce',
    "recieveICE": 'recieveICE',
    "connectionEstablished": 'connectionEstablished',
    "connectionConfirmation": 'connectionConfirmation'
  };

  setup(){
    final wsUrl = Uri.parse("ws://localhost:8649");
    var channel = WebSocketChannel.connect(wsUrl);
    this.channel = channel;
    //ensure ready
    print("dwidniowd");
    registerDevice();
    this.channel.stream.listen(
        (dynamic message) {

        },
        onError: (error){
          if (onDisconnected != null){
            onDisconnected?.call();
          }
        },
      onDone: (){
        if (onDisconnected != null){
          onDisconnected?.call();
        }
      },

    );

    if (onConnected != null){
      onConnected?.call();
    }
  }
  
  void onMessage(dynamic data){
    var mappedData = jsonDecode(data);
    if (mappedData is! Map){
      return;
    }

    switch (mappedData["type"]){
      case "deviceList": {
        if (onDeviceListFunc != null) {
            var sc = parseListofDevices(mappedData["list"]);
            onDeviceListFunc?.call(sc);

        }
      }
    }
  }


  void getConnectedDevices(){
    var message = {
      "type": messageTypes["getPiDevices"]

    };

    var bytes = jsonEncode(message);
    print(bytes);
    channel.sink.add(bytes);
  }

  void registerDevice(){
    print("nfeiuofnoefefnieofioen");
    var message = {
      "type": messageTypes["register"]

    };

    var bytes = jsonEncode(message);
    print(bytes);
    channel.sink.add(bytes);
  }



  List<ConnectedDevicesObject> parseListofDevices(List<Map<String, String>> list){
    print(list);
    return [];
  }










}