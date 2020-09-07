import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:a2b/services/Facebooklogin.dart';      //0.00115*displayHeight(context) for height
import 'package:a2b/services/sizes_helpers.dart';      // 0.00243*displayWidth(context) for width
import 'package:a2b/services/googleLogin.dart'; 
import 'package:a2b/pages/intermediate/numberinput.dart';
class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
 void loginWithFacebook ()async{
   Facebook instance = new Facebook();
    await instance.initiateLogin(context);
  }
   void loginWithGoogle ()async{
     Google instance = new Google();
    await instance.initiateLogin(context);
   }

  @override
  Widget build(BuildContext context) {
    
    
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(

       statusBarColor: Colors.black,
       
    ));
    return Scaffold(
      body :SingleChildScrollView(child : SafeArea(child : Padding(padding: EdgeInsets.fromLTRB(0.0, 1.0*0.00115*displayHeight(context), 0.0, 0.0),
          child : Column(
            children: <Widget>[    
           Container(
            height :500*0.00115*displayHeight(context),
            width: 1000*0.00243*displayWidth(context),
            color : Colors.blue[800],
            child: Column(
              children : <Widget>[
                SizedBox(height : 250*0.00115*displayHeight(context)),
                Padding(padding: EdgeInsets.fromLTRB(40.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
                child : Text("Instant courier service at your door.",
                style : TextStyle(
                  color : Colors.white,
                  fontSize : 40.0*0.00115*displayHeight(context),
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Muli',
                  letterSpacing: 2.0*0.00243*displayWidth(context),
                ),
                ),
                ),]
            ),
           ),
           SizedBox(height: 40.0*0.00115*displayHeight(context),),
           Row(
              children: <Widget>[
                Padding(padding: EdgeInsets.fromLTRB(30.0*0.00243*displayWidth(context),0.0 , 0.0, 0.0),
                child: Container(
                  height : 30.0*0.00115*displayHeight(context),
                  width : 50.0*0.00243*displayWidth(context),
                  decoration :  BoxDecoration(
                    image: DecorationImage(
                      image: ExactAssetImage('assets/images/india.png'),
                      fit : BoxFit.cover,
                    ),
                  ),
                ),
                ),
                SizedBox(width: 10.0*0.00243*displayWidth(context),),
                Text("+91",
                style : TextStyle(
                  fontSize: 28.0,
                  color: Colors.black,
                  fontFamily: 'Muli',
                ),                        
                       ),
            SizedBox(width : 10.0*0.00243*displayWidth(context)),
            SizedBox(
              height :50.0*0.00115*displayHeight(context),
              width: 240*0.00243*displayWidth(context),
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  hintText: "Enter your mobile number",
                 border: InputBorder.none,

                ),
                keyboardType: TextInputType.phone,
                onTap: (){
                   Navigator.push(context,  MaterialPageRoute(
            builder: (context) => EnterMoblieNumber(signInUsingPhoneNumber: true,)
     ));
                },
              ),
            )
              ],
           ),
          SizedBox(height : 60*0.00115*displayHeight(context)),
          Row(
    children: <Widget>[
        Expanded(
            child: Divider(
              color: Colors.black,
            )
        ),       

        Text("Or connect with social"),        

        Expanded(
            child: Divider(
              color : Colors.black
            )
        ),
    ]
),
SizedBox(height:20*0.00115*displayHeight(context)),
    ListTile(
      title: Text("Facebook"),
      leading :  CircleAvatar(backgroundImage : AssetImage('assets/images/facebook.png')),
      onTap: (){
        loginWithFacebook();
      //  Navigator.pushNamed(context, '/confirm_details');
      },                                                                                           
    ),
    SizedBox(height : 20.0*0.00115*displayHeight(context)),
    ListTile(
      title: Text("Google"),
      leading :  CircleAvatar(backgroundImage : AssetImage('assets/images/google.jpg')),
      onTap: (){
        loginWithGoogle();
      },                                                                                            
    )
            ]
          )
      )
      )
      ),
    );
  }
}


                
                      
                    

       