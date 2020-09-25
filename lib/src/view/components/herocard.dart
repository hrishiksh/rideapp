import 'package:flutter/material.dart';
import '../../controllers/blocs/blocs.dart';

class HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 30),
      child: Stack(
        overflow: Overflow.visible,
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Positioned(
            bottom: -20,
            child: StreamBuilder(
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
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  padding: EdgeInsets.only(
                    top: 25,
                    left: 20,
                  ),
                  height: 50,
                  width: MediaQuery.of(context).size.width - 60,
                  decoration: BoxDecoration(
                    color: Color(snapshot.data["color"]),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    snapshot.data["msg"],
                    maxLines: 1,
                    overflow: TextOverflow.fade,
                    style: Theme.of(context).primaryTextTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor, width: 1),
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
            margin: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      'Today',
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Text(
                      '3 Km',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Speed',
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Text(
                      '10 km/h',
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
