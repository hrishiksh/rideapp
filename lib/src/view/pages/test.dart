import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rideapp/src/model/core/location_model.dart';
import 'package:rideapp/src/model/services/database.dart';
import '../../model/helpers/service_locator.dart';

class TestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: LocationDatabase.instance.retriveLocationDb(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          print(snapshot.data);
          if (snapshot.hasData && snapshot.data.length > 0) {
            return ListView.builder(
              reverse: true,
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(
                    '${snapshot.data[index]["latitude"]} :${snapshot.data[index]["longitude"]} ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                  subtitle: Text(
                    '${snapshot.data[index]["prevlatitude"]} :${snapshot.data[index]["prevlongitude"]} ',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                );
              },
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
