import 'package:flutter/material.dart';

 class SetAddress extends StatefulWidget {
   @override
   _SetAddressState createState() => _SetAddressState();
 }
 
 class _SetAddressState extends State<SetAddress> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.white,
       appBar: AppBar(
       backgroundColor: Colors.white,
       title : Text("Set Delivery Location",
       style : Theme.of(context).textTheme.headline6.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Muli')
       ),
       ),
       body: Column(
         children: <Widget>[
      //      Expanded(

        //    )
         ],

       ),
     );
   }
 }