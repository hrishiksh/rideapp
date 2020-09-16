import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/blocs/blocs.dart';
import '../../model/helpers/helpers.dart';

class UserMap extends StatefulWidget {
  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  GoogleMapController _googleMapController;

  Map<String, double> latlngvalue =
      sl<UserLocationStream>().locationStreamController.value;

  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height,
      width: width,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  latlngvalue["latitude"],
                  latlngvalue["longitude"],
                ),
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              mapType: MapType.normal,
              zoomGesturesEnabled: true,
              zoomControlsEnabled: false,
              markers: {
                Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(
                    latlngvalue["latitude"],
                    latlngvalue["longitude"],
                  ),
                  infoWindow: InfoWindow(title: 'This is info'),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _googleMapController = controller;
              },
            ),
            Column(
              children: [
                ClipOval(
                  child: Material(
                    color: Colors.orange[100], // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        _googleMapController.animateCamera(
                          CameraUpdate.zoomIn(),
                        );
                      },
                    ),
                  ),
                ),
                ClipOval(
                  child: Material(
                    color: Colors.orange[100], // button color
                    child: InkWell(
                      splashColor: Colors.orange, // inkwell color
                      child: SizedBox(
                        width: 56,
                        height: 56,
                        child: Icon(Icons.my_location),
                      ),
                      onTap: () {
                        _googleMapController.animateCamera(
                          CameraUpdate.zoomOut(),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
