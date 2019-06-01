import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  Timer _timer;

  SplashScreen();

  @override
  Widget build(BuildContext context) {
    _timer = Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacementNamed('/main_list');
    });

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
//      color: Colors.blue,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white, Colors.blue])),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: Column(children: <Widget>[
          Image.asset(
            'assets/imgs/flutter.png',
            fit: BoxFit.contain,
            height: MediaQuery.of(context).size.width * 0.5,
            width: MediaQuery.of(context).size.width * 0.5,
          ),
          SizedBox(height: 30,),
          Text(
            'Flutter HELPER is here to serve you!',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
            ),
          )
        ]),
      ),
    );
  }
}
