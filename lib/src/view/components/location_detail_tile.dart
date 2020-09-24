import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import '../../model/helpers/helpers.dart';
import '../../model/services/services.dart';

class LocationDetailTile extends StatelessWidget {
  final double location1latitude;
  final double location2latitude;
  final double location1longitude;
  final double location2longitude;
  final DateTime startDate;
  final DateTime endDate;

  LocationDetailTile({
    this.location1latitude,
    this.location1longitude,
    this.location2latitude,
    this.location2longitude,
    this.startDate,
    this.endDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: FutureBuilder(
                  future: getPlacefromCoordinate(
                      latitude: location1latitude,
                      longitude: location1longitude),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Placemark>> snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return Text(
                        snapshot.data[0].locality ?? '...',
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return Text(
                        '...',
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  },
                ),
              ),
              SizedBox(width: 10),
              Icon(
                Icons.compare_arrows_rounded,
                size: 25,
                color: Theme.of(context).iconTheme.color,
              ),
              SizedBox(width: 10),
              Expanded(
                child: FutureBuilder(
                  future: getPlacefromCoordinate(
                      latitude: location2latitude,
                      longitude: location2longitude),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Placemark>> snapshot) {
                    if (snapshot.hasData && snapshot.data.length > 0) {
                      return Text(
                        snapshot.data[0].locality ?? '...',
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      );
                    } else {
                      return Text(
                        '...',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    }
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Distance : ',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(width: 10),
              Text(
                '${calculateDistance(startlatitude: location1latitude, startlongitude: location1longitude, endlatitude: location2latitude, endlongitude: location2longitude)} KM',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Time Taken : ',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(width: 10),
              Text(
                '${calculateTime(startDate: startDate, endDate: endDate)} hr',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Av.speed : ',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(width: 10),
              Text(
                '${calculateValocity(startlatitude: location1latitude, startlongitude: location1longitude, endlatitude: location2latitude, endlongitude: location2longitude, startDate: startDate, endDate: endDate)} Km/h',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
