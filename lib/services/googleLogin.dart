import 'package:a2b/pages/intermediate/confirm_details.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Google{
  // Instance for firebaseAuth
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Map userProfileData = {
     'first_name' : "Atishay",
  'last_name'  : 'Jain',
  'email'  : "atishayjain690@gmail.com"
  };
    //boolean variable to check login status
  bool isLoggedIn = false;
   void onLoginStatusChanged(bool isLoggedIn) {
          this.isLoggedIn = isLoggedIn;   
  }
  GoogleSignIn googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ]
  );
    //function to initiate google login
Future<void> initiateLogin(BuildContext context)async{
  
//function to handle google sign in
Future<void> handleSignIn()async{  
 GoogleSignInAccount currentUser;
 try{
 currentUser = await googleSignIn.signIn();
 
 }
 
 catch(error){
   print(error);
 }
 GoogleSignInAuthentication googleAuthentication = await currentUser.authentication;
AuthCredential credential = GoogleAuthProvider.getCredential(
  idToken: googleAuthentication.idToken, 
  accessToken: googleAuthentication.accessToken);
 AuthResult result = await firebaseAuth.signInWithCredential(credential);
FirebaseUser user = result.user;
 updateUserData(){
if(currentUser != null){
onLoginStatusChanged(true);
var fullname = currentUser.displayName;
var names = fullname.split(' ');
var firstName;
var lastName;
if(names.length < 2){
firstName = names.last;
 // updating data in Map
 userProfileData = {
  'first_name' : firstName,
  'last_name'  : lastName,
  'email'  : currentUser.email
 }; 
 
}
else if(names.length == 2){
  lastName = names.last;
  firstName = names.first;
   // updating data in Map
 userProfileData = {
  'first_name' : firstName,
  'last_name'  : lastName,
  'email'  : currentUser.email
 };
}
else{
lastName = names.last;
for(int i = 0;i < names.length-1;i++){
  firstName = firstName + names[i] + ' ';
}

 // updating data in Map
 userProfileData = {
  'first_name' : firstName,
  'last_name'  : lastName,
  'email'  : currentUser.email
 };
}
   Navigator.push(context,  MaterialPageRoute(
            builder: (context) => ConfirmDetails(googleFacebookUser: user,userProfileData: userProfileData,)
     ));
}
else{
  debugPrint("Bye");
}
}
updateUserData();
}
handleSignIn();

}
Future<void> handleSignOut()async{
googleSignIn.disconnect();
onLoginStatusChanged(false);
}
}