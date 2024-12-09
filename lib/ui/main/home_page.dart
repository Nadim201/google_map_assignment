import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_map_assignment/ui/google_map_permission.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class GoogleMapsAssignment extends StatefulWidget {
  @override
  State<GoogleMapsAssignment> createState() => _GoogleMapsAssignmentState();
}

class _GoogleMapsAssignmentState extends State<GoogleMapsAssignment> {
  final Completer<GoogleMapController> _controller = Completer();
  final List<LatLng> _polylineCoordinates = [];
  final Set<Polyline> _polylines = {};
  final Set<Marker> _markers = {};
  Timer? _locationUpdateTimer;

  late LatLng _currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
    _startRealTimeLocationUpdates();
  }

  @override
  void dispose() {
    _locationUpdateTimer?.cancel();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    Position position = await getLocation();
    _currentLocation = LatLng(position.latitude, position.longitude);

    _addMarker(_currentLocation, "My Current Location");
    _animateToLocation(_currentLocation);
  }

  void _startRealTimeLocationUpdates() {
    _locationUpdateTimer = Timer.periodic(
      const Duration(seconds: 10),
      (timer) async {
        Position position = await getLocation();
        LatLng newLocation = LatLng(position.latitude, position.longitude);

        _addPolyline(_currentLocation, newLocation);
        _addMarker(newLocation, "My Current Location");
        _animateToLocation(newLocation);
        setState(
          () {
            _currentLocation = newLocation;
          },
        );
      },
    );
  }

  //Animate camera when move any place
  Future<void> _animateToLocation(LatLng location) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: location, zoom: 16),
    ));
  }

//add Marker
  void _addMarker(LatLng position, String title) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId(title),
        position: position,
        infoWindow: InfoWindow(
          title: "My Current Location",
          snippet: "Lat: ${position.longitude}, Lng: ${position.longitude}",
        ),
      ),
    );
  }

  //add polyline section
  void _addPolyline(LatLng oldLocation, LatLng newLocation) {
    _polylineCoordinates.add(newLocation);
    _polylines.add(
      Polyline(
        polylineId: const PolylineId("tracking_polyline"),
        points: _polylineCoordinates,
        color: Colors.blue,
        width: 5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Google Maps Assignment"),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(0, 0), // Default position before loading
          zoom: 2,
        ),
        markers: _markers,
        polylines: _polylines,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Position position = await getLocation();
          LatLng location = LatLng(position.latitude, position.longitude);
          _animateToLocation(location);
        },
        child: Icon(Icons.my_location),
      ),
    );
  }
}
