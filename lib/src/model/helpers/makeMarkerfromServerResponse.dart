import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
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
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: 250,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
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
                          ],
                        ),
                      ),
                      SizedBox(height: 30),
                      Container(
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: PrimaryBtn(
                                title: 'Contact',
                                ontap: () async {
                                  await canLaunch('tel:${e.contact}')
                                      ? launch('tel:${e.contact}')
                                      : print('Can\'t launch this url');
                                },
                              ),
                            ),
                            RoundedBtn(
                              icon: Icons.share_outlined,
                              ontap: () {
                                Share.share(
                                    'Name: ${e.name} \n Contact: ${e.contact} \n Address: ${e.address} \n Latitude: ${e.latitude} \n Longitude: ${e.longitude} ');
                              },
                            ),
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
