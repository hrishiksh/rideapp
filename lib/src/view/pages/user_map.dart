import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controllers/blocs/blocs.dart';
import '../../model/helpers/helpers.dart';
import '../../model/core/marker_info.dart';

class UserMap extends StatefulWidget {
  final List<MarkerInfo> markers;

  UserMap({this.markers});

  @override
  _UserMapState createState() => _UserMapState();
}

class _UserMapState extends State<UserMap> {
  @override
  void initState() {
    super.initState();
    requestLatestData();
  }

  GoogleMapController _googleMapController;

  Map<String, double> latlngvalue =
      sl<UserLocationStream>().locationStreamController.value;

  @override
  Widget build(BuildContext context) {
    // Determining the screen width & height
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).primaryColorDark,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'RIDE APP',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: Container(
        height: height,
        width: width,
        child: Scaffold(
          body: Stack(
            alignment: Alignment.bottomRight,
            children: <Widget>[
              StreamBuilder(
                  stream: sl<ServerStream>().serverstream,
                  builder: (context, AsyncSnapshot<List> snapshot) {
                    print(snapshot);
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return GoogleMap(
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
                        markers: getmarkers(
                          context: context,
                          markers: snapshot.data
                              .map(
                                (e) => MarkerInfo(
                                  id: e["socketid"],
                                  name: e["name"],
                                  contact: e["contact"],
                                  address: e["address"],
                                  latitude: e["latitude"],
                                  longitude: e["longitude"],
                                ),
                              )
                              .toList(),
                        ),
                        onMapCreated: (GoogleMapController controller) {
                          _googleMapController = controller;
                        },
                      );
                    } else {
                      return Container(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                  }),
              Positioned(
                bottom: 10,
                right: 10,
                child: Column(
                  children: [
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // inkwell color
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.zoom_in_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                          onTap: () {
                            _googleMapController.animateCamera(
                              CameraUpdate.zoomIn(),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ClipOval(
                      child: Material(
                        color: Theme.of(context).primaryColor, // button color
                        child: InkWell(
                          splashColor: Colors.orange, // inkwell color
                          child: SizedBox(
                            width: 56,
                            height: 56,
                            child: Icon(
                              Icons.zoom_out_outlined,
                              color: Colors.white,
                              size: 25,
                            ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
