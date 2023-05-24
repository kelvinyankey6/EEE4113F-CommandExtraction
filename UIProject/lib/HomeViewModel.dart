




import 'package:flutter/widgets.dart';
import 'package:system_design_ui_project/ConnectedDevicesObject.dart';
import 'package:system_design_ui_project/HttpApi.dart';
import 'package:system_design_ui_project/models/CaptureEventDataClass.dart';
import 'package:system_design_ui_project/models/SensorBriefDataClass.dart';
import 'package:http/http.dart' as http;
import 'models/SensorStatusDataClass.dart';

class HomeViewModel extends ChangeNotifier {
    late String webAddress;
    ConnectedDevicesObject? device;
    late HttpAPi api;
    double temperatureReading = 23.0;
    double humidityReading = 25.0;
    double cpuLoadReading = 45.0;
    double storageSpace = 67.0;
    double batteryLevel = 86.0;
    int eventsCaptured = 0;
    bool isHealthy = false;
    List<CaptureEvent> capturedEvents = [];


    void startSensorBriefUpdate(){
      api = HttpAPi(webAddress, onSensorBrief);
    }

    void updateAddress(String address){
      webAddress = address;
      notifyListeners();
    }


    ConnectedDevicesObject getDevice(){
      if (device == null){
        return ConnectedDevicesObject("Loading..", "Loading..", false);

      }
      return device!;
    }


    void onSensorBrief(SensorBrief brief) {
      isHealthy = true;
      temperatureReading = brief.temphumid.temperature;
      humidityReading = brief.temphumid.humidity;
      batteryLevel = brief.battery.battery_level;
      storageSpace = brief.storage.percentage;
      cpuLoadReading = brief.cpuload.cpu_usage;
      eventsCaptured = brief.events.events;
      device ??= ConnectedDevicesObject(brief.details.device_name, brief.details.device_name, true);
      notifyListeners();
    }

    void clearStorage() async {
      await api.clearStorage();
    }

    void restartStation() async {
      await api.restartStation();
    }

    void shutdownStation() async {
      await api.shutdownAction();
    }

    Future<SensorStatus> getSensorStatus() async {
      return await api.getCurrentSensorStatus();
    }

    Future<void> getCaptureEvent(int startDate, int endDate, int limit, int skip) async {
      print("dwnoidw");
      print(startDate);
      print(endDate);
      var result = await api.getEventsFromQuery(startDate, endDate, limit, skip);
      capturedEvents  = result;
      notifyListeners();
    }

    Future<bool> sendHeartBeat(String baseUrl) async {
      String route = "/heartbeat";
      String path = baseUrl + route;
      var url = Uri.parse(path);


      try {
        var response = await http.get(url);

        return response.statusCode == 200;
      } on Exception catch (e){
        print(path);
        return false;
      }
    }


}