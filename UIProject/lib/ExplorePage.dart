import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:system_design_ui_project/HomeViewModel.dart';

import 'lineChart.dart';
import 'models/CaptureEventDataClass.dart';

class ExplorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ExplorePageState();
  }
}

class _ExplorePageState extends State<ExplorePage> {
  var hasResults = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController startDateFieldController =
  TextEditingController();
  final TextEditingController endDateFieldController = TextEditingController();

  DateTime? _selectedStartDate;
  DateTime? _selectedEndDate;
  static const daySelector = ['Today', 'Last 7 Days', 'Last 30 Days'];
  String dropDownValue = daySelector.first;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: const Text("Explore"),
          centerTitle: true,
        ),
        body: Consumer<HomeViewModel>(
          builder: (context, model, child) {
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,

                    ),
                    Row(
                      children: [
                        Text(
                          "Dashboard",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text(
                          "Explore all data captured by the device so far",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Colors.grey
                          ),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                    Wrap(
                      children: [
                        _buildDropDownButton(),
                        ButtonBar(
                          children: [
                            IconButton(onPressed: () {
                              
                            }, icon: Icon(Icons.search)),
                            FilledButton(
                              onPressed: () async {
                                print(DateTime(2001).millisecondsSinceEpoch~/1000);
                                await model.getCaptureEvent(DateTime(2001).millisecondsSinceEpoch~/1000, DateTime.now().millisecondsSinceEpoch~/1000, 0, 0);

                              }, child: Text("Custom Query"),
                              
                              
                            ),
                            FilledButton(onPressed: null, child: Text("Download"), style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),)
                          ],
                        )
                      ],
                    ),
                    Wrap(
                      children: model.capturedEvents.map((e) => CapturedEventView(event: e, baseUrl: model.webAddress)).toList(),
                    )

                  ],
                ),
              )
            );
          },
        ));
  }

  DropdownButtonFormField<String> _buildDropDownButton(){
      return DropdownButtonFormField<String>(
        value: dropDownValue,

        onChanged: (value) {

        },
        items: daySelector.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        decoration: InputDecoration(
          border: OutlineInputBorder()
        ),
      );
  }
}

class CapturedEventView extends StatelessWidget {
  final CaptureEvent event;
  final String baseUrl;

  const CapturedEventView({super.key, required this.event, required this.baseUrl});

  Color getWashedOutColor(Color themeColor) {
    return Color.fromARGB(
        255,
        themeColor.red + 170 > 255 ? 255 : themeColor.red + 170,
        themeColor.green + 170 > 255 ? 255 : themeColor.green + 170,
        themeColor.blue + 170 > 255 ? 255 : themeColor.blue + 170);
  }

  String resolveImageUrl(){
    return "${baseUrl}/files/download/images/${this.event.image}";
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double _height = 250.0;
    double _width = 270.0;
    return Container(
      width: _width,
      child: GestureDetector(
        onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: [
                          FilledButton(onPressed: null, child: Text("Download")),
                          CloseButton(),

                        ],
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          resolveImageUrl(),
                          width: _width,
                          height: _height - 100,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ],
                  ),
                )  ;
              },
            );
        },
        child: Card(

          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  resolveImageUrl(),
                  width: _width,
                  height: _height - 80,
                  fit: BoxFit.fill,
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  FilledButton.tonalIcon(
                    onPressed: () {},

                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          getWashedOutColor(Colors.red)),

                    ),
                    icon: Icon(Icons.thermostat, color: Colors.red,),
                    label: Text(
                      "${event.temperature} *C",
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),

                  FilledButton.tonalIcon(
                    onPressed: () {},

                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),

                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                          getWashedOutColor(Colors.blue)),

                    ),
                    icon: Icon(Icons.waves, color: Colors.blue,),
                    label: Text(
                      "${event.humidity} %",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



}
