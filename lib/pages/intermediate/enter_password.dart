import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EnterPassword extends StatefulWidget {
  final FirebaseUser user;
  EnterPassword({this.user});

  @override
  _EnterPasswordState createState() => _EnterPasswordState();
}

class _EnterPasswordState extends State<EnterPassword> {
  //Form key
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  // text editing controller for passwod fields
  TextEditingController controller1 = new TextEditingController();
  bool _showPassword = false;
// Function to update user information.
  void updateUserPassword() async {
    await widget.user.updatePassword(password);
    Navigator.pushReplacementNamed(context, '/home');
  }

  //Password for the user will be stored in this string.
  String password;

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
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                child: Text("Create a password",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontSize: 15.0,
                    )),
              ),
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 0.0, 40.0, 0.0),
                child: Form(
                  key: _formkey,
                  child: Column(children: <Widget>[
                    SizedBox(
                      child: TextFormField(
                        controller: controller1,
                        validator: (String value) {
                          if (value.length < 8) {
                            controller1.clear();
                            return "Password must be atleast 8 characters long";
                          }
                          return null;
                        },
                        showCursor: true,
                        onSaved: (String str) {
                          setState(() {
                            password = str;
                          });
                        },
                        decoration: InputDecoration(
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                            ),
                            hintText: "Enter a new password",
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                child: Icon(
                                  !_showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ))),
                        autofocus: true,
                        cursorColor: Colors.black,
                        obscureText: !_showPassword,
                      ),
                    ),
                  ]),
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 0.0, 0.0),
                  child: Text(
                    "Secure passwords are atleast 8 characters long and includes numbers and characters",
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 11.0,
                    ),
                  ))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_formkey.currentState.validate()) {
            return;
          } else {
            _formkey.currentState.save();
            updateUserPassword();
          }
        },
        backgroundColor: Colors.black,
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
