import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:system_design_ui_project/models/SensorBriefDataClass.dart';
import 'package:system_design_ui_project/models/SensorStatusDataClass.dart';

import 'models/CaptureEventDataClass.dart';

typedef OnSensorBrief = Function(SensorBrief);

class HttpAPi {
  final String baseUrl;
  late Timer timer;
  OnSensorBrief? onSensorBriefCallback;


  HttpAPi(this.baseUrl, OnSensorBrief? callback){
    onSensorBriefCallback = callback;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      //make the http request and call on sensor callback everytime
      var data = await getCurrentSensorBrief();
      print(data);
      if (onSensorBriefCallback != null){
        onSensorBriefCallback?.call(data);
      }
    },);

  }



  Future<SensorBrief> getCurrentSensorBrief() async {
    String route = "/healthstatus/all";
    String path = baseUrl + route;
    var url = Uri.parse(path);


    var response = await http.get(url);

    var result = SensorBrief.fromJson(jsonDecode(response.body));
    return result;
  }


  Future<void> restartStation() async {
    String route = "/basicActions/restart";
    String path = baseUrl + route;
    var url = Uri.parse(path);


    await http.get(url);

  }

  Future<void> shutdownAction() async {
    String route = "/basicActions/shutdown";
    String path = baseUrl + route;
    var url = Uri.parse(path);


    await http.get(url);


  }

  Future<void> clearStorage() async {
    String route = "/basicActions/clearStorage";
    String path = baseUrl + route;
    var url = Uri.parse(path);


    await http.get(url);
  }

  Future<SensorStatus> getCurrentSensorStatus() async {
    String route = "/basicActions/checkSensorStatus";
    String path = baseUrl + route;
    var url = Uri.parse(path);


    var response = await http.get(url);

    var result = SensorStatus.fromJson(jsonDecode(response.body));
    return result;
  }


  Future<List<CaptureEvent>> getEventsFromQuery(int startDate, int endDate, int limit, int skip) async {
    String route = "/explore/search";
    String path = baseUrl + route;
    var body = {
      "startDate": startDate,
      "endDate": endDate,
      "limit": limit,
      "skip": skip
    };

    var url = Uri.parse(path);


    print(jsonEncode(body));
    var response = await http.post(url, body: jsonEncode(body), headers: {
      "Content-Type" : "application/json"
    });


    var data = jsonDecode(response.body);
    print(data);
    var result = (data as List).map((e) {
      return CaptureEvent.fromJson(e);
    },).toList();

    return result;
  }



}