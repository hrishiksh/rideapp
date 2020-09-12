import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.white,
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
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
      ),
      child: Stack(
        alignment: AlignmentDirectional.centerStart,
        children: [
          Positioned(
            right: 0,
            child: Image.asset(
              'assets/card.png',
              height: 130,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Today',
                style: Theme.of(context).primaryTextTheme.headline1,
              ),
              Text(
                '3 Km',
                style: Theme.of(context).textTheme.headline2,
              ),
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
    );
  }
}
