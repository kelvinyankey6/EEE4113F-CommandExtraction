import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ConnectedDevicesObject.dart';
import 'HomeViewModel.dart';
import 'ScreenSizeQuery.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return _HomeViewState();
  }
}

class _HomeViewState extends State<HomeView> {
  Color getWashedOutColor(Color themeColor) {
    return Color.fromARGB(
        255,
        themeColor.red + 150 > 255 ? 255 : themeColor.red + 150,
        themeColor.green + 130 > 255 ? 255 : themeColor.green + 130,
        themeColor.blue + 150 > 255 ? 255 : themeColor.blue + 150);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var deviceType = ScreenSizeQuery.getDeviceType(context);
    var textSize = deviceType == ScreenSizeQuery.isMobile ? 25.0 : 35.0;
    return Consumer<HomeViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
            centerTitle: true,
          ),
          body: Padding(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(
                            "Good Morning,",
                            style: TextStyle(
                              fontSize: textSize,
                              fontWeight: FontWeight.w900,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Center(
                          child: Text(
                            "User",
                            style: TextStyle(
                                fontSize: textSize,
                                fontWeight: FontWeight.w300,
                                color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Wrap(
                      spacing: 10,
                      alignment: WrapAlignment.center,
                      children: [
                        Chip(
                          avatar: CircleAvatar(
                            child: Icon(Icons.devices),
                          ),
                          label: Text(model.getDevice().deviceName),
                        ),
                        Chip(
                          avatar: CircleAvatar(
                            child: model.getDevice().isConnected ? Icon(Icons.circle) : Icon(Icons.warning),

                          ),
                          label: model.getDevice().isConnected ? Text("Online") : Text("Loading..."),
                          elevation: 0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Center(
                        child: Text(
                          "Last updated: just now",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 15,
                      runSpacing: 15,
                      direction: Axis.horizontal,
                      children: [
                        InformationReportingSliver(
                          label: "Temperature",
                          description: "${model.temperatureReading} °C",
                          icon: Icons.thermostat,
                          themeColor: Colors.red,
                        ),
                        InformationReportingSliver(
                          label: "Humidity",
                          description: "${model.humidityReading} °%",
                          icon: Icons.waves,
                          themeColor: Colors.blue,
                        ),
                        InformationReportingSliver(
                          label: "CPU Load",
                          description: "${model.cpuLoadReading} %",
                          icon: Icons.computer_outlined,
                          themeColor: Colors.green,
                        ),
                        InformationReportingSliver(
                          label: "Events Captured",
                          description: "${model.eventsCaptured}",
                          icon: Icons.camera,
                          themeColor: Colors.black,

                        ),
                        InformationReportingSliver(
                          label: "Battery Level",
                          description: "${model.batteryLevel} °%",
                          icon: Icons.battery_4_bar_sharp,
                          themeColor: Colors.pink,

                        ),
                        InformationReportingSliver(
                          label: "Overall Health",
                          description: model.isHealthy ? "OK": "Error",
                          icon: Icons.health_and_safety_outlined,
                          themeColor: model.isHealthy ? Colors.teal : Colors.deepOrange,

                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Actions",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: textSize,
                              fontWeight: FontWeight.w900),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Wrap(
                      runSpacing: 15,
                      spacing: 15,
                      alignment: WrapAlignment.center,
                      children: [
                        FilledButton.icon(
                          onPressed: () async {

                          },
                          icon: Icon(Icons.video_call),
                          label: Text("Live Video"),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () async {
                            Provider.of<HomeViewModel>(context, listen: false).restartStation();
                          },
                          icon: Icon(Icons.restart_alt),
                          label: Text("Restart"),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () {
                            Provider.of<HomeViewModel>(context, listen: false).shutdownStation();
                          },
                          icon: Icon(Icons.power_off),
                          label: Text("Shutdown"),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () {
                            Provider.of<HomeViewModel>(context, listen: false).clearStorage();
                          },
                          icon: Icon(Icons.restart_alt),
                          label: Text("Clear Storage"),
                        ),
                        FilledButton.tonalIcon(
                          onPressed: () async {
                            await Provider.of<HomeViewModel>(context, listen: false).getSensorStatus();
                          },
                          icon: Icon(Icons.sensors),
                          label: Text("Sensor Status"),
                        ),

                      ],
                    ),

                  ],
                ),
              )),
        );
      },
    );
  }
}

class InformationReportingSliver extends StatelessWidget {
  final Color themeColor;
  final String label;
  final String description;
  final IconData icon;
  final bool small;

  const InformationReportingSliver(
      {super.key,
      required this.themeColor,
      required this.label,
      required this.description,
      required this.icon, this.small = false});

  Color getWashedOutColor() {
    return Color.fromARGB(
        255,
        themeColor.red + 170 > 255 ? 255 : themeColor.red + 170,
        themeColor.green + 170 > 255 ? 255 : themeColor.green + 170,
        themeColor.blue + 170 > 255 ? 255 : themeColor.blue + 170);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var width = MediaQuery.of(context).size.width / 2 - 50;
    var fontSize = 30.0;
    var height = 100.0;
    var deviceType = ScreenSizeQuery.getDeviceType(context);
    switch (deviceType) {
      case ScreenSizeQuery.isMobile:
        {
          width = MediaQuery.of(context).size.width  - 50;
          fontSize = 30.0;
          height = 100.0;

          break;
        }
      case ScreenSizeQuery.isTablet:
        {
          width = MediaQuery.of(context).size.width / 2 - 50;
          fontSize = 30.0;
          height = 120.0;
          break;
        }
      case ScreenSizeQuery.isDesktop:
        {
          width = MediaQuery.of(context).size.width / (small ? 8 : 3) - 50;
          fontSize = small? 30.0 : 45.0;
          height = small? 150.0 : 150.0;
          break;
        }
    }
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: getWashedOutColor(),
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  label,
                  style: TextStyle(
                      color: themeColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900),
                )
              ],
            ),
            Expanded(
              child: Row(
                children: [
                  Icon(
                    icon,
                    color: themeColor,
                    size: fontSize,
                  ),
                  Spacer(),
                  Text(
                    description,
                    style: TextStyle(
                        color: themeColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w300),
                  ),
                  Spacer(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
