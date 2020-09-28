import 'package:flutter/material.dart';
import './pages.dart';

class ConsentPage extends StatelessWidget {
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
      body: Stack(
        alignment: AlignmentDirectional.topStart,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: 70,
              left: 40,
              right: 30,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _columnComponents(context),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              'assets/bottom.png',
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _columnComponents(BuildContext context) {
    return [
      Text(
        'Permission needed',
        style: Theme.of(context).textTheme.subtitle1,
      ),
      SizedBox(height: 20),
      Row(
        children: [
          Icon(
            Icons.location_on,
            size: 20,
          ),
          Text(
            'Location',
            style: Theme.of(context).textTheme.headline3,
          ),
        ],
      ),
      SizedBox(height: 10),
      Column(
        children: [
          Text(
            "We need location permission to calculate your speed and distance travelled",
            style: Theme.of(context).textTheme.headline4,
          ),
          SizedBox(height: 10),
          Text(
            "We don’t store your location. Your location will be shared if and only if you break any traffic rule. for details go to traffic rule section inside the app.",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
      SizedBox(height: 20),
      RaisedButton(
        color: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Login(),
            ),
          );
        },
        child: Text(
          'Accept and proceed',
          style: Theme.of(context).primaryTextTheme.subtitle1,
        ),
      ),
    ];
  }
}
