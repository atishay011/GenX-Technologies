
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
class Facebook{
// Instance of FirebaseAuth
FirebaseAuth instance = FirebaseAuth.instance;
//Function which updates information if user is logged in or not.
    bool isLoggedIn = false;
   void onLoginStatusChanged(bool isLoggedIn) {
          this.isLoggedIn = isLoggedIn;   
  }
var facebookLogin = FacebookLogin();
 Future <void> initiateLogin(BuildContext context) async{
    final facebookLoginResult =  await facebookLogin.logIn(['email']);
     switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        onLoginStatusChanged(false);
        break;
      case FacebookLoginStatus.loggedIn:
      final token = facebookLoginResult.accessToken.token;
        final graphResponse = await get('https://graph.facebook.com/v2.12/me?fields=first_name,last_name,picture,email&access_token=$token');
        final Map profile = jsonDecode(graphResponse.body);
        Navigator.pushNamed(context, '/confirm_details' , arguments: profile);
        print("LoggedIn");
        print(profile);
        final credential = FacebookAuthProvider.getCredential(accessToken : token);
        AuthResult result = await instance.signInWithCredential(credential);
        FirebaseUser user = result.user;
        if(user != null){}
        onLoginStatusChanged(true);
        break;
    }
  }
  Future<void> handleLogOut()async{
    facebookLogin.logOut();
    onLoginStatusChanged(false);

  }
}