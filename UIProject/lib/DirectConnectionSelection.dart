


import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:system_design_ui_project/HomeViewModel.dart';

class DirectConnectionSelection extends StatefulWidget {
  const DirectConnectionSelection({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DirectConnectionSelectionState();
  }

}



class _DirectConnectionSelectionState extends State<DirectConnectionSelection>{


  final _formKey = GlobalKey<FormState>();
  final TextEditingController addressFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressFieldController.text = "http://192.168.2.1:8000";
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Direct Connection"),
        centerTitle: true,

      ),

      body: Consumer<HomeViewModel>(
        builder: (context, value, child) {
          return Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(height: 100,),
                    Container(

                      child: TextFormField(
                        validator: (value){

                        },
                        controller: addressFieldController,

                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter the address of the server'
                        ),


                      ),
                    ),
                    SizedBox(height: 100,),
                    ElevatedButton.icon(
                      onPressed: () async {
                        //Before testing this out, first check if the route is okay
                        // if (!(await value.sendHeartBeat(addressFieldController.value.text))){
                        //   //Show a dialog here
                        //   print("No cake");
                        //   return;
                        // }

                        value.updateAddress(addressFieldController.value.text);
                        value.startSensorBriefUpdate();
                        Navigator.pushNamed(context, '/home');
                      },
                      icon: const Icon(Icons.private_connectivity_outlined),
                      label: const Text("Connect"),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }

}