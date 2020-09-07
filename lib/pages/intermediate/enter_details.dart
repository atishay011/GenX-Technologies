import 'package:a2b/pages/intermediate/enter_password.dart';
import 'package:flutter/material.dart';
import 'package:a2b/services/sizes_helpers.dart';   // *0.00243*displayWidth(context) for width     // *0.00115*displayHeight(context) for height
import 'package:firebase_auth/firebase_auth.dart';
class EnterDetails extends StatefulWidget {
  final FirebaseUser user;
    EnterDetails({Key key ,   this.user}) : super(key:key);

  @override
  _EnterDetailsState createState() => _EnterDetailsState();
}

class _EnterDetailsState extends State<EnterDetails> {
  // declaration of key for form
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  FocusNode focusNode = new FocusNode();
  String firstName;
  String lastName;
  UserUpdateInfo info = UserUpdateInfo();


  saveUserDetails(UserUpdateInfo info)async{
      info.displayName = firstName + ' ' + lastName;
      await widget.user.updateProfile(info);
      Navigator.push(context , MaterialPageRoute( builder: (context) => EnterPassword( user: widget.user,)
     ));
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
      body:SingleChildScrollView( child : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children : <Widget>[
          Padding(
            padding : EdgeInsets.fromLTRB(30.0*0.00243*displayWidth(context), 20.0 *0.00115*displayHeight(context), 0.0, 0.0),
            child : Text("Hey there, what's your name?",
            style : TextStyle(
              color : Colors.grey[800],
              fontSize : 20.0 *0.00115*displayHeight(context),
            )                               
      )
          ),
          SizedBox(height : 60.0*0.00115*displayHeight(context),),
          Padding(padding : EdgeInsets.fromLTRB(30.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
         child : Form(
           key : _formkey,
           child : Row(
           children : <Widget>[
              SizedBox(
              height :50.0*0.00115*displayHeight(context),
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
               FocusScope.of(context).requestFocus(focusNode);
              },
              onSaved: (String str){
                firstName = str;
              },                              
                decoration: InputDecoration( 
                   focusedBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.black),   
                            ),  
                  hintText: "First Name",                  
                ),
                textCapitalization: TextCapitalization.sentences,         
                autofocus: true,
                cursorColor: Colors.black, 
                
              ),
            ),
            SizedBox(width : 20.0*0.00243*displayWidth(context)),
              SizedBox(
              height :50.0*0.00115*displayHeight(context),
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
                lastName = str;
              },                      
              showCursor: true,
              focusNode: focusNode,                                
                decoration: InputDecoration( 
                   focusedBorder: UnderlineInputBorder(      
                            borderSide: BorderSide(color: Colors.black),   
                            ),  
                  hintText: "Last Name"           
                ),
               // autofocus: true,
                cursorColor: Colors.black, 
              ),
            )
            
           ]
         )
          ),
          )

        ]
      )
      ),
        floatingActionButton: FloatingActionButton(onPressed: (
      ){
         if(!_formkey.currentState.validate()){
          return;
          }
        else{
          _formkey.currentState.save();
          saveUserDetails(info);
          }
      },
      backgroundColor: Colors.black,
      child: Icon(
        Icons.arrow_forward
      ),
      ),    
    );
  }
}