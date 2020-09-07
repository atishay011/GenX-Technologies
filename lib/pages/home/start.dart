import 'package:flutter/material.dart';
import 'package:a2b/services/SetLocation.dart';
import 'package:a2b/services/sizes_helpers.dart';

class Start extends StatefulWidget {
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
//Using provider for checking authState

  void setupLocation() async {
    Location currentLocation = Location();
    await currentLocation.getLocation();
   String currentAddress = await currentLocation.getAddressFromLatLng();
    Navigator.pushReplacementNamed(context, '/wrapper' , arguments: currentAddress);
  }

  @override
  void initState() {
    super.initState();
    setupLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
            padding: EdgeInsets.fromLTRB(
                0.0, 300.0 * 0.00115 * displayHeight(context), 0.0, 0.0),
            child: Center(
                child: Column(
              children: <Widget>[
                Text("a2b",
                    style: TextStyle(
                      fontSize: 80.0,
                      fontFamily: 'Orbitron',
                      color: Colors.white,
                      letterSpacing: 4.0,
                    )),
                SizedBox(
                  height: 6.0 * 0.00115 * displayHeight(context),
                ),
                Text(
                  "Get anything delivered instantly!!",
                  //not added a font, might add a font in future.
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ))));
  }
}
