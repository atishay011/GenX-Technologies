import 'package:cloud_firestore/cloud_firestore.dart';


class DatabaseService{
  // Constructor variables for Database service
  final String uid;
  final String firstname;
  final String lastname;
  DatabaseService({this.uid , this.firstname , this.lastname});
// create a collection reference
final CollectionReference  userData =  Firestore.instance.collection('Users');

Future updateUserData()async{
  //create a firestore user
  return await userData.document(uid).setData({
    'firstName' : firstname,
    'lastName'  : lastname,
  });
  
}

}
