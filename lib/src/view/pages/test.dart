import 'package:flutter/material.dart';
import 'package:rideapp/src/model/services/notification.dart';
import '../../model/services/services.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification check'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            onPressed: () {
              showNotification();
            },
            child: Text('Show NOtification'),
          ),
        ),
      ),
    );
  }
}
