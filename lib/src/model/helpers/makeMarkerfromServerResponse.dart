import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rideapp/src/view/components/primary_btn.dart';
import '../core/marker_info.dart';
import '../services/services.dart';
import '../../controllers/blocs/blocs.dart';
import './service_locator.dart';
import 'package:flutter/material.dart';
import '../../view/components/components.dart';

void requestLatestData() {
  //TODO: to get data authenticate with jwt or any other authentication
  // Check if it is local request or police request
  SocketConnect.instance.getsocketInstance.emit('data-request', "jwt");
  SocketConnect.instance.getsocketInstance.on(
    'data-response',
    (data) {
      sl<ServerStream>().addServerStream(
        jsonDecode(data),
      );
    },
  );
}

Set<Marker> getmarkers({List<MarkerInfo> markers, BuildContext context}) {
  List<Marker> modifiedMarkers = [];
  markers.forEach(
    (e) {
      Marker newmarker = Marker(
          markerId: MarkerId(e.id),
          position: LatLng(e.latitude, e.longitude),
          infoWindow: InfoWindow(title: e.name, snippet: e.contact),
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 200,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: ${e.name}',
                          style: Theme.of(context).textTheme.headline4),
                      Text('Contact: ${e.contact}',
                          style: Theme.of(context).textTheme.headline4),
                      Text('Address: ${e.address}',
                          style: Theme.of(context).textTheme.headline4),
                      Text('Latitude: ${e.latitude}',
                          style: Theme.of(context).textTheme.headline4),
                      Text('Longitude: ${e.longitude}',
                          style: Theme.of(context).textTheme.headline4),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: PrimaryBtn(
                                title: 'Contact',
                                //TODO: impliment call feature
                                ontap: () {},
                              ),
                            ),
                            RoundedBtn(icon: Icons.share_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          });
      modifiedMarkers.add(newmarker);
    },
  );
  return Set.of(modifiedMarkers);
}
