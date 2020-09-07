import 'package:geolocator/geolocator.dart';

class Location {
  // variables used for getting current location
  String country;
  String currentAddress;

  Future<Position> getLocation() async {
    //code to get current location
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    return position;
  }

  getAddressFromLatLng() async {
    try {
      Position currentPosition = await getLocation();
      List<Placemark> p = await Geolocator().placemarkFromCoordinates(
          currentPosition.latitude, currentPosition.longitude);
      Placemark place = p[0];
      currentAddress = "${place.name}, ${place.locality} - ${place.postalCode}";
      return currentAddress;
    } catch (e) {
      print(e);
    }
  }
}
