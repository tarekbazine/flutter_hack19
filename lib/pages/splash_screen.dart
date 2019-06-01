import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SplashScreen extends StatelessWidget {
  Timer _timer;

  SplashScreen();

  @override
  Widget build(BuildContext context) {
    _timer = Timer(Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed('/main_list');
    });

    return Container(
      color: Colors.blue,
      child: Text("splash"),
    );
  }
}
