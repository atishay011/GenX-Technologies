import 'package:a2b/pages/home/home.dart';
import 'package:a2b/pages/home/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   String currentAddress = ModalRoute.of(context).settings.arguments;
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.hasData)
    return Home(currentAddress: currentAddress,);
          
        else
          return SignUp();
      },
    );
  }
}
