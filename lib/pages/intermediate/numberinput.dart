import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:a2b/services/PhoneNumberFormatter.dart';
import 'package:a2b/services/Auth.dart';
import 'package:a2b/services/sizes_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart'; // 0.00243*displayWidth(context) for width

//0.00115*displayHeight(context) for height
class EnterMoblieNumber extends StatefulWidget {
  @override
  _EnterMoblieNumberState createState() => _EnterMoblieNumberState();
  final bool signInUsingPhoneNumber;
  final FirebaseUser googleFacebookUser;
  EnterMoblieNumber(
      {Key key, this.signInUsingPhoneNumber, this.googleFacebookUser})
      : super(key: key);
}

class _EnterMoblieNumberState extends State<EnterMoblieNumber> {
  Authenticate instance = Authenticate();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String phoneNumber;
  final controller = TextEditingController();
  //  bool signInUsingPhoneNumber = true;

  // height variable for on screen keyboard
  bool visible = true;
  double get height => visible
      ? 270 * 0.00115 * displayHeight(context)
      : 550 * 0.00115 * displayHeight(context);
  set height(double height) {
    height = height;
  }

  String otptext =
      "By continuing you may recieve an SMS for verification. Message and data rates may apply.";
  //keyboard visiblity subscribe id
  var keyboardVisibilitySubscriberId;
  //function to auto-adjust height when using on-screen keyboard
  @override
  void initState() {
    super.initState();
    debugPrint("hello");
    keyboardVisibilitySubscriberId =
        KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print('keyboard $visible');
        setState(() {
          this.visible = visible;
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    KeyboardVisibilityNotification()
        .removeListener(keyboardVisibilitySubscriberId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //back button color changes to black
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(
                    30.0 * 0.00243 * displayWidth(context),
                    20.0 * 0.00115 * displayHeight(context),
                    0.0,
                    0.0),
                child: Text(
                  "Enter your mobile number",
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 20.0 * 0.00115 * displayHeight(context),
                  ),
                ),
              ),
              SizedBox(height: 30.0 * 0.00115 * displayHeight(context)),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                    child: Container(
                      height: 30.0 * 0.00115 * displayHeight(context),
                      width: 50.0 * 0.00243 * displayWidth(context),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: ExactAssetImage('assets/images/india.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0 * 0.00243 * displayWidth(context)),
                  Text(
                    "+91",
                    style: TextStyle(
                      fontSize: 24.0 * 0.00115 * displayHeight(context),
                      color: Colors.black,
                      fontFamily: 'Muli',
                    ),
                  ),
                  SizedBox(
                    width: 20.0 * 0.00243 * displayWidth(context),
                  ),
                  SizedBox(
                      height: 50.0 * 0.00115 * displayHeight(context),
                      width: 220 * 0.00243 * displayWidth(context),
                      child: Form(
                        key: _formkey,
                        child: TextFormField(
                          validator: (String value) {
                            if (value.length < 11) {
                              return 'Please enter a valid mobile number';
                            }
                            return null;
                          },
                          showCursor: true,
                          controller: controller,
                          inputFormatters: [
                            WhitelistingTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                            PhoneNumberInputFormatter()
                          ],
                          onSaved: (String str) {
                            phoneNumber = str;
                          },
                          decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "8840 011 784",
                          ),
                          keyboardType: TextInputType.phone,
                          autofocus: true,
                          cursorColor: Colors.black,
                        ),
                      )),
                ],
              ),
              AnimatedContainer(
                duration: Duration(),
                width: double.infinity,
                height: height,
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    20.0 * 0.00243 * displayWidth(context), 0.0, 0.0, 0.0),
                child: Container(
                    width: 240 * 0.00243 * displayWidth(context),
                    child: Text(
                      otptext,
                      style: TextStyle(
                        color: Colors.grey[700],
                        letterSpacing: 1.1,
                      ),
                    )),
              )
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_formkey.currentState.validate()) {
            controller.clear();
            return;
          } else {
            _formkey.currentState.save();
            phoneNumber =
                '${phoneNumber.substring(0, 4)}${phoneNumber.substring(5, 8)}${phoneNumber.substring(9, 12)}';
            print(" SignInUsingPhoneNumber : ${widget.signInUsingPhoneNumber}");
            instance.verifyPhone('+91$phoneNumber', instance.smsCode, context,
                widget.signInUsingPhoneNumber, widget.googleFacebookUser);
          }
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
