import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async {
  bool serviceEnable;
  LocationPermission permission;
  serviceEnable = await Geolocator.isLocationServiceEnabled();

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location Permission are denied');
    }
    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openLocationSettings();
      return Future.error('Location Permission are denied Permanently');
    }
  }
  return await Geolocator.getCurrentPosition();
}
