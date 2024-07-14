import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'permissions_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late GoogleMapController mapController;
  Position? currentPosition;
  String currentAddress = 'Buscando dirección...';
  final PermissionsService permissionsService = PermissionsService();
  late BitmapDescriptor customMarkerIcon;

  @override
  void initState() {
    super.initState();
    _loadCustomMarker();
    _getCurrentLocation();
  }

  void _loadCustomMarker() async {
    customMarkerIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/custom_marker.png',
    );
  }

  void _getCurrentLocation() async {
    bool hasPermission = await permissionsService.requestLocationPermission();
    if (hasPermission) {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentPosition = position;
        _getAddressFromLatLng(position);
      });
    }
  }

  void _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];
      setState(() {
        currentAddress =
            '${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}';
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                GoogleMap(
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                    zoom: 15.0,
                  ),
                  markers: {
                    Marker(
                      markerId: MarkerId('currentLocation'),
                      position: LatLng(currentPosition!.latitude, currentPosition!.longitude),
                      icon: customMarkerIcon,
                    ),
                  },
                ),
                Positioned(
                  bottom: 50,
                  left: 10,
                  child: ElevatedButton(
                    onPressed: _getCurrentLocation,
                    child: Text('Actualizar Ubicación'),
                  ),
                ),
                Positioned(
                  top: 50,
                  left: 10,
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 184, 167, 219),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black),
                        SizedBox(width: 3),
                        Text(currentAddress),
                      ],
                    ),
                    
                  ),
                ),
              ],
            ),
    );
  }
}
