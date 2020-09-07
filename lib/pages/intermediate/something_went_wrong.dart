import 'package:flutter/material.dart';

class TryAgain extends StatefulWidget {
  @override
  _TryAgainState createState() => _TryAgainState();
}

class _TryAgainState extends State<TryAgain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body : SafeArea(child: 
      Text("Something went wrong.Please try again later."))
    );
  }
}