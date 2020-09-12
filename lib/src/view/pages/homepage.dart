import 'package:flutter/material.dart';
import '../components/components.dart';
import 'package:timeline_tile/timeline_tile.dart';
import '../../model/helpers/current_address.dart';
import '../../model/services/location_conversion.dart';
import 'package:geolocator/geolocator.dart';
import '../../model/helpers/service_locator.dart';
import '../../model/services/database.dart';

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
      child: Column(
        children: [
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: .2,
            isFirst: true,
            rightChild: Container(
              height: 50,
              child: Column(
                children: [
                  Text(
                    'Uzanbaar',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ),
            leftChild: Container(
              child: Text(
                '12:22 pm',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
          TimelineTile(
            alignment: TimelineAlign.manual,
            lineX: .2,
            isFirst: true,
            rightChild: Container(
              height: 50,
              child: Column(
                children: [
                  Text(
                    'Uzanbaar',
                    style: Theme.of(context).textTheme.headline4,
                  )
                ],
              ),
            ),
            leftChild: Container(
              child: Text(
                '12:22 pm',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
          ),
        ],
      ),
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
        onPressed: null,
        child: Icon(Icons.share_outlined),
      ),
    );
  }
}
