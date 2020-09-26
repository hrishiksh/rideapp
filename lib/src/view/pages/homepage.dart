import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rideapp/src/model/core/marker_info.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../components/components.dart';
import '../../model/helpers/helpers.dart';
import '../../model/services/services.dart';
import './user_map.dart';
import '../../controllers/blocs/blocs.dart';

class HomePage extends StatelessWidget {
  Widget _seeInMapBtn(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColorDark.withOpacity(0.25),
              offset: Offset(2, 2),
              blurRadius: 5,
            ),
            BoxShadow(
              color: Theme.of(context).primaryColorLight,
              offset: Offset(-2, -2),
              blurRadius: 5,
            ),
          ],
        ),
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Maps',
              style: Theme.of(context).textTheme.headline3,
            ),
            IconButton(icon: Icon(Icons.keyboard_arrow_right), onPressed: null),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserMap(
              //TODO: delete these markers
              markers: [
                MarkerInfo(
                    id: '1',
                    latitude: 26.185175,
                    longitude: 91.754264,
                    name: 'Demo1',
                    address: 'DemoAddrres',
                    contact: '123456'),
                MarkerInfo(
                    id: '2',
                    latitude: 26.184175,
                    longitude: 91.753264,
                    name: 'Demo1',
                    address: 'DemoAddrres',
                    contact: '123456'),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _timeline(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: sl<LocationDatabase>().retriveLocationDb(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData && snapshot.data.length > 0) {
            return SizedBox(
              height: 170.0 * snapshot.data.length,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 170,
                    child: TimelineTile(
                      alignment: TimelineAlign.manual,
                      lineX: .2,
                      isFirst:
                          snapshot.data[index]["id"] == snapshot.data.length
                              ? true
                              : false,
                      isLast: snapshot.data[index]["id"] == 1 ? true : false,
                      rightChild: LocationDetailTile(
                        location1latitude: snapshot.data[index]["prevlatitude"],
                        location1longitude: snapshot.data[index]
                            ["prevlongitude"],
                        location2latitude: snapshot.data[index]["latitude"],
                        location2longitude: snapshot.data[index]["longitude"],
                        startDate: snapshot.data[index]["prevdateTime"] != null
                            ? DateTime.parse(
                                snapshot.data[index]["prevdateTime"])
                            : null,
                        endDate:
                            DateTime.parse(snapshot.data[index]["dateTime"]),
                      ),
                      leftChild: Container(
                        margin: EdgeInsets.only(left: 20),
                        child: Text(
                          '${DateTime.parse(snapshot.data[index]["dateTime"]).hour}:${DateTime.parse(snapshot.data[index]["dateTime"]).minute}',
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 200),
              child: Text(
                'Your timeline will appear here',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _directLocationShare(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Share your location',
              style: Theme.of(context).textTheme.subtitle1),
          StreamBuilder(
            stream: ToggleLocationSharing.instance.toggleLocationStream,
            initialData: false,
            builder: (context, snapshot) {
              return Switch(
                value: snapshot.data,
                onChanged: (value) {
                  ToggleLocationSharing.instance.addToggleLocation(value);
                  if (value) {
                    shareLocationDirectly(cancelstream: false);
                    StatusStream.instance.addStatus(
                      {
                        "status": "greenzone",
                        "color": 0xFFFF3A3A,
                        "msg": "Your location is shared with police",
                        "sl": "20kmph"
                      },
                    );
                  } else {
                    shareLocationDirectly(cancelstream: true);

                    //TODO: Make this correct
                    StatusStream.instance.addStatus(
                      {
                        "status": "greenzone",
                        "color": 0xFFFF3A3A,
                        "msg": "Drive slow",
                        "sl": "20kmph"
                      },
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }

  List<Widget> _columnChildren(BuildContext context) {
    return [
      StreamBuilder(
        stream: StatusStream.instance.statusStream,
        initialData: {
          "status": "normal",
          "color": 0xFF657ED4,
          "msg": "Moderate traffic. Obey traffic rules",
          "sl": "100kmph"
        },
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          return Container(
            child: Container(
              margin: EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 20,
                      ),
                      FutureBuilder(
                        future: currentAddress(),
                        initialData: 'Getting your location...',
                        builder: (BuildContext context,
                            AsyncSnapshot<String> snapshot) {
                          return Text(
                            snapshot.data,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headline4,
                          );
                        },
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      'Speed Limit: ${snapshot.data["sl"]}',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      HeroCard(),
      _directLocationShare(context),
      sl<SharedPreferences>().getBool("isPolice")
          ? _seeInMapBtn(context)
          : Container(),
      _timeline(context),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RIDE APP',
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: _columnChildren(context),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Running');
        },
        child: Icon(Icons.share_outlined),
      ),
    );
  }
}
