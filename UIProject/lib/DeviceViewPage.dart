




import 'package:flutter/material.dart';
import 'package:system_design_ui_project/ExplorePage.dart';
import 'package:system_design_ui_project/ExtractPage.dart';
import 'package:system_design_ui_project/Home.dart';

import 'ConnectedDevicesObject.dart';

class DeviceViewPage extends StatefulWidget{


  const DeviceViewPage({super.key});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DeviceViewPageState();
  }

}



class _DeviceViewPageState extends State<DeviceViewPage> {

  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(Icons.flight_takeoff),
            label: "Extract",
          ),
        ],

      ),
      body: <Widget>[
        HomeView(),
        ExplorePage(),
        ExtractPage()
      ][currentPageIndex],

    );
  }

}