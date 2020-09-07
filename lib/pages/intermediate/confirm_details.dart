import 'package:a2b/pages/intermediate/numberinput.dart';
import 'package:a2b/services/Facebooklogin.dart';
import 'package:a2b/services/googleLogin.dart';
import 'package:flutter/material.dart';
import 'package:a2b/services/sizes_helpers.dart';       // 0.00243*displayWidth(context) for width
import 'package:a2b/services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfirmDetails extends StatefulWidget {
  final FirebaseUser googleFacebookUser;
  final Map userProfileData;
  ConfirmDetails({this.googleFacebookUser, this.userProfileData});
  @override
  _ConfirmDetailsState createState() => _ConfirmDetailsState();
}

class _ConfirmDetailsState extends State<ConfirmDetails> {
  // map where firstname , lastname and email are saved
  //Form key for text fields
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  // instace for authenticate class
    Authenticate instance = Authenticate();
    // function for pressing back button
  Future<bool>  onBackPressed()async{
      if(Google().isLoggedIn == true)
      {
      Google().handleSignOut();
      }
       if(Facebook().isLoggedIn)
       {
      Facebook().handleLogOut();
       }
      Navigator.pop(context);
      return null;
    }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: onBackPressed,
   child : Scaffold(
      backgroundColor: Colors.white,
      appBar : AppBar(
         iconTheme: IconThemeData(
            color: Colors.black, //back button color changes to black 
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
      ),
       body:SingleChildScrollView( child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget>[
          Padding(
            padding : EdgeInsets.fromLTRB(15.0*0.00243*displayWidth(context), 30.0 *0.00115*displayHeight(context), 0.0, 0.0),
            child : Text("Confirm your information",
            style : TextStyle(
              color : Colors.grey[800],
              fontSize : 20.0 *0.00115*displayHeight(context),
            )                               
      )
          ),
          SizedBox(height : 60.0*0.00115*displayHeight(context),),
        
          Padding(padding : EdgeInsets.fromLTRB(15.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
         child : Form(
           key : _formkey,
           child : Row(
           children : <Widget>[
              SizedBox(
              width: 150*0.00243*displayWidth(context),
              child:  TextFormField(
              validator: (String value){
            if(value.length == 0){
                return "Please enter your first name";
            }
            return null;
              },           
              showCursor: true,  
              onFieldSubmitted: (String str){
              },
              onSaved: (String str){
                widget.userProfileData['first_name'] = str;
              },                              
                decoration: InputDecoration( 
                   focusedBorder: UnderlineInputBorder(      
                  borderSide: BorderSide(color: Colors.black),   
                            ),
                  labelText :  "First",
                  labelStyle: TextStyle(
                    color :  Colors.grey[800],               
                  ),
                ),
                initialValue: widget.userProfileData['first_name'],
                textCapitalization: TextCapitalization.sentences,         
                autofocus: true,
                cursorColor: Colors.black, 
                
              ),
            ),
            SizedBox(width : 50.0*0.00243*displayWidth(context)),
              SizedBox(
              width: 150*0.00243*displayWidth(context),
              child: TextFormField(
              textCapitalization: TextCapitalization.sentences,         
              validator: (String value){
            if(value.length == 0){
                return "Please enter your last name";
            }
            return null;
              },
       onSaved: (String str){
                 widget.userProfileData['last_name'] = str;
              },                      
              showCursor: true,
                decoration: InputDecoration( 
                   focusedBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.black),   
                            ),  
                labelText: "Last",
                    labelStyle: TextStyle(
                    color :  Colors.grey[800],
                  ),
                ),
              initialValue: widget.userProfileData['last_name'],
                cursorColor: Colors.black, 
              ),
            )
            
           ]
         )
          ),
          ),
          SizedBox(height : 35.0*0.00115*displayHeight(context)),
      Padding(padding : EdgeInsets.fromLTRB(15.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
   child :  SizedBox(
              width: 350*0.00243*displayWidth(context),
              child:  TextFormField(
              validator: (String value){
            if(value.length == 0){
                return "Please enter a valid Email Address";
            }
            return null;
              },  
                       
              showCursor: true,  
              onFieldSubmitted: (String str){
              },
              onSaved: (String str){
                widget.userProfileData['email'] = str;
              },                              
                decoration: InputDecoration( 
                   focusedBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.black),   
                            ),
                  labelText :  "Email",
                  labelStyle: TextStyle(
                    color :  Colors.grey[800],               
                  ),
                    alignLabelWithHint: false,                                
                ),
                
                initialValue: widget.userProfileData['email'],
                textCapitalization: TextCapitalization.sentences,         
                autofocus: true,
                cursorColor: Colors.black, 
              ),
            ),
      ),
        ]     
      )
      ),
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           if(!_formkey.currentState.validate()){
        return;
      }
      else{
      _formkey.currentState.save();
      Navigator.push(context,  MaterialPageRoute(
            builder: (context) => EnterMoblieNumber( googleFacebookUser: widget.googleFacebookUser, signInUsingPhoneNumber: false, )
     ));
      }
         },       
      backgroundColor: Colors.black,
      child: Icon(
        Icons.arrow_forward
      ),
      ),
  ),    
    );
  }
}