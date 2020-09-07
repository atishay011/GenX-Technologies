import 'package:geolocator/geolocator.dart';
class User{
  final String uid;
  final String firstname;
  final String lastname;
  final String emailAddress;
  final String phoneNumber;
  final Position currentLocation;
  final String password;
  User({this.uid , this.firstname , this.lastname , this.emailAddress , this.phoneNumber , this.currentLocation , this.password});
}
