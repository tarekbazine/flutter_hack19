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
      color: Colors.blue,
      child: Center(
        child: Text(
          'Flutter HELPER is here to save you!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
