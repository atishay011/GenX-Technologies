
import 'package:a2b/pages/wrapper.dart';
import 'package:a2b/pages/intermediate/enter_password.dart';
import 'package:flutter/material.dart';
import 'package:a2b/pages/home/start.dart';
import 'package:a2b/pages/home/home.dart';
import 'package:a2b/pages/home/sign_up.dart';
import 'package:a2b/pages/intermediate/numberinput.dart';
import 'package:a2b/pages/intermediate/enterotp.dart';
import 'package:a2b/pages/intermediate/something_went_wrong.dart';
import 'package:a2b/pages/intermediate/enter_details.dart';
import 'package:a2b/pages/intermediate/confirm_details.dart';


void main() => runApp(
  MaterialApp(
    initialRoute: '/',
    routes : {
    '/' : (context){return Start();},
    '/sign_up'  : (context){return SignUp();},
    '/home'  : (context){return Home();},
    '/mobile_input' : (context){
          return EnterMoblieNumber();},
    '/otp_verification' : (context){ return Otpverification();},
    '/try_again'  : (context){return TryAgain();},
    '/enter_details' : (context){return EnterDetails();},
    '/enter_password' : (context){return EnterPassword();},
    '/confirm_details'  : (context){return ConfirmDetails();},
    '/wrapper' : (context){return Wrapper();}
    }
  )
);

