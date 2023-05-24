





import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_design_ui_project/DeviceViewPage.dart';

import 'ConnectedDevicesModel.dart';
import 'ConnectedDevicesObject.dart';
import 'Home.dart';

class ConnectedDevicesListView extends StatefulWidget {
  const ConnectedDevicesListView({super.key});




  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ConnectedDevicesListView();
  }
}


class _ConnectedDevicesListView extends State<ConnectedDevicesListView> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    return Consumer<ConnectedDevicesModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Connected Devices"),
            centerTitle: true,
            actions: [
                  IconButton(
                    icon: const Icon(Icons.repeat),
                    onPressed: () {
                        model.connection.setup();
                    },
                  )
            ],

          ),


          body: buildBody(context, model),

          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/direct");
            },
            tooltip: 'Connect to a Device Directly',
            child: const Icon(Icons.private_connectivity_sharp),
          ),
        );
      },
    );
  }

}

Widget buildBody(BuildContext context, ConnectedDevicesModel model){
  switch (1){
    case ConnectedDevicesModel.CONNECTING: {
      return LoadingScreen();
    }
    case ConnectedDevicesModel.UNAVAILABLE: {
      return const ErrorScreen(message: Text("Could not connect to signalling server", style: TextStyle(fontSize: 25),));
    }
    case ConnectedDevicesModel.CONNECTED: {
      List<Widget> children = [];

        children.add(
            ConnectedDeviceSliver(
              data: ConnectedDevicesObject("Cancerous Snake", "df18a552-6d16-4c2c-84fc-04120e78a586", true),
              callback: (){
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeviceViewPage()
                    )
                );
              },
            )
        );
        children.add(
            const SizedBox(
              height: 10,
            )
        );

        return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: children,
            )
        );
      }
    default:
      return LoadingScreen();

    }

  }


class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return const SizedBox.expand(
      child: Center(
        child: CircularProgressIndicator()
      ),
    );
  }

}


class ErrorScreen extends StatelessWidget {

  final Widget message;

  const ErrorScreen({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox.expand(
      child: Center(
          child: SizedBox(
            child: Column(
              children: [
                Spacer(),
                const Icon(Icons.warning, color: Colors.red, size: 40,),
                SizedBox(height: 20,),
                message,
                Spacer(),
              ],

            ),
          )
      ),
    );
  }

}



class ConnectedDeviceSliver extends StatelessWidget {
  final ConnectedDevicesObject data;

  const ConnectedDeviceSliver({super.key, required this.data, this.callback});

  final Function? callback;




  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      clipBehavior: Clip.antiAlias,

      // child: Column(
      //   children: [
      //     ListTile(
      //       title: Text("Raymonds Balas"),
      //       subtitle: Text("fewafafebawiufbi"),
      //       leading: false ? Icon(Icons.check_circle, color: Colors.lightGreen,) : Icon(Icons.error, color: Colors.redAccent,),
      //     )
      //   ],
      // ),

      child: Container(
        height: 75,
        //Width set by flex container on outside
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Center(
                  child: ListTile(
                          title: Text(data.deviceName),
                          subtitle: Text(data.deviceName),
                          leading: data.isConnected ? Icon(Icons.check_circle, color: Colors.lightGreen,) : Icon(Icons.error, color: Colors.redAccent,),
                        ),
                  ),
                ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                  if (callback != null){
                    callback!.call(data);
                  }
              },
              child: Text("Connect"),

            ),
            SizedBox(
              width: 20,
            )

        ]
        ),
    )
    );
  }
}


