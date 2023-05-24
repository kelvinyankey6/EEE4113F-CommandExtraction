



class ConnectedDevicesObject {
  final String deviceName;
  final String deviceId;
  final bool isConnected;

  ConnectedDevicesObject(this.deviceName, this.deviceId, this.isConnected);

  ConnectedDevicesObject fromJson(Map<String,dynamic>  json){
    return ConnectedDevicesObject(json["deviceName"], json["deviceId"], json["isConnected"]);
  }

  Map<String, dynamic> toJson(){
    return {
      "deviceName": deviceName,
      "deviceId": deviceId,
      "isConnected": isConnected
    };
  }

}