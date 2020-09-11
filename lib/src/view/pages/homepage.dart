import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../../model/helpers/service_locator.dart';
import '../../model/services/database.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('RideApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        child: Column(
          children: [
            FutureBuilder(
              future:
                  getCurrentPosition(desiredAccuracy: LocationAccuracy.high),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text("${snapshot.data}");
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            FutureBuilder(
              future: sl<LocationDatabase>().retriveLocationDb(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
        // child: FutureBuilder(
        //   future: sl<LocationDatabase>().retriveLocationDb(),
        //   builder: (BuildContext context,
        //       AsyncSnapshot<List<LocationModel>> snapshot) {
        //     print(snapshot.data);
        //     if (snapshot.hasData && snapshot.data.length > 0) {
        //       return ListView.builder(
        //         itemCount: snapshot.data.length,
        //         itemBuilder: (context, index) {
        //           return ListTile(
        //             title: Text(
        //               snapshot.data[index].dateTime.toString(),
        //             ),
        //             subtitle: Text(
        //               "${snapshot.data[index].latitude}-${snapshot.data[index].longitude}",
        //             ),
        //           );
        //         },
        //       );
        //     } else {
        //       return Center(
        //         child: Text('Nothing to display'),
        //       );
        //     }
        //   },
        // ),
      ),
    );
  }
}
