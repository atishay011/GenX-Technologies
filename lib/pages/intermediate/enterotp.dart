import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:a2b/services/Auth.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'dart:async';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:a2b/services/sizes_helpers.dart';   // 0.00243*displayWidth(context) for width     // *0.00115*displayHeight(context) for height
class Otpverification extends StatefulWidget {
  final String phoneNumber;
  final Authenticate instance;
  Otpverification({Key key , this.phoneNumber , this.instance}) : super(key:key);
  @override
  _OtpverificationState createState() => _OtpverificationState();
}

class _OtpverificationState extends State<Otpverification> { 
  Timer timer;
    StreamController<ErrorAnimationType> errorController;
  int counter = 15;
    String phoneNumber;
  List <FocusNode> focusnode   = new List(6);
    List <TextEditingController> controller  = new List(6);
    TextEditingController currcontroller = new TextEditingController();
    List<String> otp = new List(6);  
    double height2;    
    String currentText = "";
    String smsCode;
    bool visible = true;
    double get height =>  visible?340*0.00115*displayHeight(context):600*0.00115*displayHeight(context);
    set height(double height){
      height = height;
    }
    
  void dispose(){
    errorController.close();
    timer.cancel();
    super.dispose();
    
  }
           
  setTimer(){
    if(counter > 0){
    setState(() {
      counter--;
    });}
  }
  
    @override
    void initState() {
    timer =   Timer.periodic(Duration(seconds : 1) ,  (timer) { 
      return setTimer();     
    });   
    KeyboardVisibilityNotification().addNewListener(   
      onChange: (bool visible) {
     print('keyboard $visible');
     setState(() {
         this.visible = visible;
    height2 = visible?300*0.00115*displayHeight(context):560*0.00115*displayHeight(context);
     });

      },   
    );
        errorController = StreamController<ErrorAnimationType>();
    super.initState();
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
            padding : EdgeInsets.fromLTRB(30.0*0.00243*displayWidth(context), 20.0*0.00115*displayHeight(context), 0.0, 0.0),
            child : FutureBuilder(
            builder: (context , snapshot){
              if(counter <= 0){
                return    RichText(
              text :   TextSpan(
              style: TextStyle(
              color : Colors.grey[800],
              fontSize : 22.0*0.00115*displayHeight(context),
              letterSpacing: 2.0*0.00243*displayWidth(context)
            ),
                children: <TextSpan>[
       TextSpan(text: 'Enter the 6-digit code sent to you at  '),
       TextSpan(text: '+91 ${widget.phoneNumber.substring(3,7)} ${widget.phoneNumber.substring(7,10)} ${widget.phoneNumber.substring(10,13)}', style:  TextStyle(fontWeight: FontWeight.bold , 
       color : Colors.orange)),
       TextSpan(text : " Did you enter the correct mobile number?" , style: TextStyle(
         color: Colors.orangeAccent,
         letterSpacing: 2.0*0.00243*displayWidth(context),
         fontSize: 20.0*0.00115*displayHeight(context),
       ))                             
                ]
            )
            );
              }
              else{
        return  RichText(
              text :   TextSpan(
              style: TextStyle(
              color : Colors.grey[800],
              fontSize : 22.0*0.00115*displayHeight(context),
              letterSpacing: 2.0*0.00243*displayWidth(context),
            ),
                children: <TextSpan>[
       TextSpan(text: 'Enter the 6-digit code sent to you at  '),
       TextSpan(text: '+91 ${widget.phoneNumber.substring(3,7)} ${widget.phoneNumber.substring(7,10)} ${widget.phoneNumber.substring(10,13)}', style:  TextStyle(fontWeight: FontWeight.bold , 
       color : Colors.orange)),                               
                ]
            )
            );
              }
            }
            )
          ),
          Row(
            children : <Widget>[
              Padding(
              padding : EdgeInsets.fromLTRB(30.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
              child : SizedBox(
              height: 50.0*0.00115*displayHeight(context),
              width: 300*0.00243*displayWidth(context),
              
   child : PinCodeTextField(
  length: 6, 
  autoFocus: true,
   borderWidth: 2.0,
  obsecureText: false,
  animationType: AnimationType.none,
  shape: PinCodeFieldShape.underline,
  animationDuration: Duration(milliseconds: 300),
  borderRadius: BorderRadius.circular(5),
  fieldHeight: 50*0.00115*displayHeight(context),
  fieldWidth: 40*0.00243*displayWidth(context),  
  textInputType: TextInputType.number,
  inputFormatters :  [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
                
              ], 
  textStyle: TextStyle(fontWeight: FontWeight.normal,
  fontSize: 20.0*0.00115*displayHeight(context),),
  activeColor : Colors.black,
  selectedColor :   Colors.black,
  inactiveColor: Colors.grey[400], 
   
  onChanged: (value) {
 print(value);
 setState(() {
currentText = value;
   }
 );
  },
  onCompleted: (value){
    setState(() {
      print("code writing completed");
      smsCode = value;
    //  widget.instance.manualVerification(smsCode , context);   
    });
  
  },
)
              ),
              ),
            ]
          ),
          FutureBuilder(
            builder:  (context , snapshot){
            if(counter <= 0)  {  
        return  AnimatedContainer(duration: Duration(),
          width : double.infinity,
          height : height2,      
          ); } 
          else{ 
            return AnimatedContainer(duration: Duration(),
          width : double.infinity,
          height : height,        
          );
          }          
          }       
           ),                  
       Padding(padding: EdgeInsets.fromLTRB(20.0*0.00243*displayWidth(context), 0.0, 0.0, 0.0),
       child : Container(
      width: 240*0.00243*displayWidth(context),
       child :  FutureBuilder(
         builder :  (context , snapshot){ 
           if(counter <= 0 ) 
           { return Text("I'm having trouble",
        style: TextStyle(
          color : Colors.grey[700],
          letterSpacing: 1.3*0.00243*displayWidth(context),
        ),
        );
        }
         else{
     return Text("Resend code in 00:${counter.toString().padLeft(2 , '0')}" , 
            style: TextStyle(
          color : Colors.grey[700],
          letterSpacing: 1.3*0.00243*displayWidth(context),
        ),        
           );
         }
         }
       ),
        ), 
          ),
      
        ] 
        ),
        ),

      floatingActionButton: FloatingActionButton(onPressed: (
      ){
       // Navigator.pushReplacementNamed(context, '/enter_details');
        
      },
      backgroundColor: Colors.black,
      child: Icon(
        Icons.arrow_forward
      ),
      ),    

    );
     
  }
 
}