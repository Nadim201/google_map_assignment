import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _markerPosition = const LatLng(24.74076542685144, 89.40966855034364);
  late GoogleMapController _mapController;

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
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
      drawer: Drawer(
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
      ),
      body: Stack(
        children: [
          // Google Map
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _markerPosition,
              zoom: 14.0,
            ),
            markers: {
              Marker(
                markerId: const MarkerId('1'),
                position: _markerPosition,
                draggable: true,
                // Make marker draggable
                onDragEnd: (newPosition) {
                  // Update marker position after dragging ends
                  setState(() {
                    _markerPosition = newPosition;
                  });
                  print('New Marker Position: $newPosition');
                },
                infoWindow: const InfoWindow(
                  title: 'My Home',
                  snippet: 'This is my childhood playground',
                ),
              ),
            },
          ),
          Positioned(
            top: 10.0,
            left: 15.0,
            right: 15.0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(10),
                  suffixIcon:
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
                  icon: const Icon(Icons.search),
                  hintText: 'Search here',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Floating Action Buttons
          Positioned(
            bottom: 120.0,
            right: 15.0,
            child: Column(
              children: [
                FloatingActionButton(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  onPressed: () {},
                  child: const Icon(Icons.navigation),
                ),
                const SizedBox(height: 10),
                FloatingActionButton(
                  backgroundColor: Colors.greenAccent,
                  onPressed: () {},
                  child: const Icon(Icons.location_searching),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
