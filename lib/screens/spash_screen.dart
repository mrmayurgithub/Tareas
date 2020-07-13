import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:tareas/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
  }

  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      height: _height,
      color: Colors.white,
      child: Center(
        child: Container(
          width: _height / 2,
          height: _height / 2,
          child: Column(
            children: [
              Flexible(
                flex: 2,
                child: Image(
                  image: AssetImage('assets/tareas.png'),
                  width: 220,
                  height: 220,
                ),
              ),
              Flexible(
                flex: 1,
                child: FlareActor(
                  'assets/loading.flr',
                  alignment: Alignment.center,
                  animation: 'active',
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
