import 'package:a2b/models/user.dart';
import 'package:a2b/pages/intermediate/enter_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:a2b/pages/intermediate/enterotp.dart';
import 'dart:async';
import 'package:a2b/pages/intermediate/enter_details.dart';

//Authenticate using phone number
class Authenticate {
  Map finalProfileData;
  String verificationId;
  String smsCode;
  String phoneNumber;
  var firebaseAuth = FirebaseAuth.instance;
  //Function to store firebase information in User model
  void userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      User(
          uid: user.uid,
          firstname: finalProfileData['first_name'],
          lastname: finalProfileData['lastname'],
          emailAddress: finalProfileData['email'],
          phoneNumber: finalProfileData['phoneNumber']);
    } else
      return null;
  }

  //Strean which listens to auth changes.
  Stream<FirebaseUser> get user {
    return firebaseAuth.onAuthStateChanged;
  }

  // function which executes phone number verification.
  Future<void> verifyPhone(
      String phoneNumber,
      String smsCode,
      BuildContext context,
      bool signInUsingPhoneNumber,
      FirebaseUser googleFacebookUser) async {
    this.phoneNumber = phoneNumber;
    this.smsCode = smsCode;
    final PhoneCodeAutoRetrievalTimeout autoRetrive =
        (String verificationId) {};
    final PhoneCodeSent smsCodeSent =
        (String verificationId, [int forcedCodeResend]) {
      setVerificationCode(verificationId);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otpverification(
                    phoneNumber: phoneNumber,
                    instance: instance,
                  )));
    };
    final PhoneVerificationCompleted userVerification =
        (AuthCredential auth) async {
      if (signInUsingPhoneNumber) {
        AuthResult result = await firebaseAuth.signInWithCredential(auth);
        FirebaseUser user = result.user;
        if (user != null) {
          print("user verified  ${user.phoneNumber}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterDetails(
                        user: user,
                      )));
        }
      } else {
        await googleFacebookUser.updatePhoneNumberCredential(auth);
        await (await firebaseAuth.currentUser()).reload();
        final newUser = await firebaseAuth.currentUser();
        print("phone number :  ${newUser.phoneNumber}");
        if (newUser.phoneNumber != null) {
          print("user verified  ${newUser.phoneNumber}");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EnterPassword(
                        user: newUser,
                      )));
        } else {
          Navigator.pushNamed(context, '/try_again');
        }
      }
    };

    final PhoneVerificationFailed userFailed = (AuthException e) {
      Navigator.pushReplacementNamed(context, '/try_again.dart');
      var status = e.message;
      print("Error message :" + status);
      if (e.message.contains('not authorized'))
        status = 'Something has gone wrong, please try later';
      else if (e.message.contains('Network'))
        status = 'Please check your internet connection and try again';
      else
        status = 'Something has gone wrong, please try later';
    };

    await firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 15),
        verificationCompleted: userVerification,
        verificationFailed: userFailed,
        codeSent: smsCodeSent,
        codeAutoRetrievalTimeout: autoRetrive);
  }

  setVerificationCode(String verificationId) {
    this.verificationId = verificationId;
  }

  /*void manualVerification(String smsCode , BuildContext context) async{
  print("verification id :  $verificationId");
  this.smsCode = smsCode;
   AuthCredential credential = PhoneAuthProvider.getCredential(verificationId: verificationId, smsCode: smsCode);
     AuthResult result = await firebaseAuth.   
     signInWithCredential(credential);
     FirebaseUser user = result.user;
       if(user!=null){
     print("user verified  ${user.uid}");
      uid = user.uid;
     if(signInUsingPhoneNumber == true)
     Navigator.push(context , MaterialPageRoute( builder: (context) => EnterDetails(phoneNumber: phoneNumber,uid: user.uid,)
     ));
     else
      Navigator.push(context , MaterialPageRoute( builder: (context) => ConfirmDetails()          ));
  }

else{
  print("error");
}
}*/

  getFinalProfileData(Map finalProfileData) {
    this.finalProfileData = finalProfileData;
  }
}

Authenticate instance = Authenticate();
