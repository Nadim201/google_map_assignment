import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:google_map_assignment/ui/utils_files/text_format.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../google_map_permission.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  LatLng _currentLocation = const LatLng(24.74076542685144, 89.40966855034364);
  final Completer<GoogleMapController> _controller = Completer();

  List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    // marker.addAll(markerList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Tracker'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.account_circle),
          ),
        ],
      ),
      drawer: DrawerSection(),
      body: Stack(
        children: [
          // Google Map
          GoogleMapSection(),
          SearchingSection(),
          // Floating Action Buttons
          Positioned(
            bottom: 120.0,
            right: 15.0,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: () async {
                    GoogleMapController controller = await _controller.future;
                    final customPosition = LatLng(24.7661, 89.3838);
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          zoom: 16,
                          target: customPosition,
                        ),
                      ),
                    );
                    marker.clear();

                    //how to add marker
                    marker.add(
                      Marker(
                          draggable: true,
                          infoWindow: InfoWindow(title: 'This is my Upazila '),
                          markerId: MarkerId('Upzila Marker'),
                          position: customPosition,
                          icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueCyan)),
                    );
                    setState(() {});
                  },
                  child: const Icon(Icons.navigation),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  onPressed: () async {
                    Position position = await getLocation();
                    final controller = await _controller
                        .future;
                    controller.animateCamera(
                      CameraUpdate.newCameraPosition(
                        CameraPosition(
                          zoom: 14,
                          target: LatLng(position.latitude, position.longitude),
                        ),
                      ),
                    );
                    marker.clear();
                    marker.add(
                      Marker(
                        draggable: true,
                        infoWindow: InfoWindow(title: 'This is my home '),
                        markerId: const MarkerId('My Current Location'),
                        position: LatLng(position.latitude, position.longitude),
                      ),
                    );
                    setState(() {}); // Update the UI
                  },
                  child: const Icon(Icons.location_searching),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  GoogleMap GoogleMapSection() {
    return GoogleMap(
      markers: Set<Marker>.of(marker),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      initialCameraPosition: CameraPosition(
        target: _currentLocation,
        zoom: 14.0,
      ),
    );
  }

  Positioned SearchingSection() {
    return Positioned(
      top: 24,
      left: 15.0,
      right: 15.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(boxShadow: const [
          BoxShadow(blurRadius: 1, spreadRadius: 0.02),
        ], borderRadius: BorderRadius.circular(8), color: Colors.white),
        child: TextField(
          style: TextFile.header1TextStyle(),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 12),
            suffixIcon: Icon(
              Icons.mic,
              size: 30,
            ),
            prefixIcon: Icon(
              Icons.search,
              size: 30,
            ),
            hintText: 'Search Your Location',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Drawer DrawerSection() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Map Menu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.place),
            title: const Text('Your places'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.timeline),
            title: const Text('Your timeline'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
