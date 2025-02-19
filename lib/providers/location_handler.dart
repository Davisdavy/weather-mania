
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';


abstract class LocationHandler{

  static Position defaultCity = Position(
    latitude:-1.2999792,
    longitude: 36.7728897,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
    altitudeAccuracy: 0,
    headingAccuracy: 0

  );

  static Future<bool> handleLocationPermission() async{
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return false;

    permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied)
        return false;
    }
    if (permission == LocationPermission.deniedForever)
      return false;
    return true;
  }
  static Future<Position?> getCurrentPosition() async{
   try{
     final hasPermission = await handleLocationPermission();
     if (!hasPermission) return defaultCity;

     return await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.high,
     );
   }
   catch(e){
     return null;
   }
  }
  static Future<String?> getCityFromLatLong(Position position) async{
    try{
      List<Placemark> placeMarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude
      );
      return placeMarks[0].locality;
    }
    catch(e){
      return null;
    }
  }
}