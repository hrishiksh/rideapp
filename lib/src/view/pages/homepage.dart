import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../components/components.dart';
import '../../model/helpers/helpers.dart';
import '../../model/services/services.dart';

class HomePage extends StatelessWidget {
  Widget _seeInMapBtn(BuildContext context) {
    return Container(
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
    );
  }

  Widget _timeline(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: sl<LocationDatabase>().retriveLocationDb(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              height: 150.0 * snapshot.data.length,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 150,
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
            return Container();
          }
        },
      ),
      // child: Column(
      //   children: [
      //     TimelineTile(
      //       alignment: TimelineAlign.manual,
      //       lineX: .25,
      //       isFirst: true,
      //       rightChild: LocationDetailTile(
      //         location1: 'Guwahati',
      //         location2: 'Shillong',
      //         timetaken: 4.0,
      //         speed: 80.0,
      //         distance: 150.0,
      //       ),
      //       leftChild: Container(
      //         margin: EdgeInsets.only(left: 20),
      //         child: Text(
      //           '12:22 pm',
      //           style: Theme.of(context).textTheme.subtitle2,
      //         ),
      //       ),
      //     ),
      //     TimelineTile(
      //       alignment: TimelineAlign.manual,
      //       lineX: .25,
      //       rightChild: LocationDetailTile(
      //         location1: 'Guwahati',
      //         location2: 'Shillong',
      //         timetaken: 4.0,
      //         speed: 80.0,
      //         distance: 150.0,
      //       ),
      //       leftChild: Container(
      //         margin: EdgeInsets.only(left: 20),
      //         child: Text(
      //           '12:22 pm',
      //           style: Theme.of(context).textTheme.subtitle2,
      //         ),
      //       ),
      //     ),
      //     TimelineTile(
      //       alignment: TimelineAlign.manual,
      //       lineX: .2,
      //       rightChild: Container(
      //         height: 50,
      //         child: Column(
      //           children: [
      //             Text(
      //               'Uzanbaar',
      //               style: Theme.of(context).textTheme.headline4,
      //             )
      //           ],
      //         ),
      //       ),
      //       leftChild: Container(
      //         child: Text(
      //           '12:22 pm',
      //           style: Theme.of(context).textTheme.subtitle2,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  List<Widget> _columnChildren(BuildContext context) {
    return [
      Container(
        margin: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 10,
        ),
        child: Row(
          children: [
            Icon(
              Icons.location_on_outlined,
              size: 20,
            ),
            FutureBuilder(
              future: currentAddress(),
              initialData: 'Getting your location...',
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                return Text(
                  snapshot.data,
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
          ],
        ),
      ),
      HeroCard(),
      _seeInMapBtn(context),
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
