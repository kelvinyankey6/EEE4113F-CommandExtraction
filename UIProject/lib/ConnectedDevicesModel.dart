


import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:system_design_ui_project/SignallingConnection.dart';

import 'ConnectedDevicesObject.dart';

class ConnectedDevicesModel extends ChangeNotifier {
  final List<ConnectedDevicesObject> _devices = [];
  final SignallingConnection connection = SignallingConnection();

  static const CONNECTING = 0;
  static const CONNECTED = 1;
  static const UNAVAILABLE = 2;
  int state = UNAVAILABLE;

  UnmodifiableListView<ConnectedDevicesObject> get devices => UnmodifiableListView(_devices);


  setup(){
    state = CONNECTING;
    notifyListeners();
    connection.onConnected = () {
      state = CONNECTED;
      notifyListeners();
    };
    connection.onDisconnected = (){
      print("njoidwniodw");
      state = UNAVAILABLE;
      notifyListeners();
    };
    try {
      connection.setup();
    }catch (e){
      print("Failed");
      state = UNAVAILABLE;
      notifyListeners();
    }
  }




  ConnectedDevicesModel();




}

