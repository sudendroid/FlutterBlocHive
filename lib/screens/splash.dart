import 'dart:async';

import 'package:flutter/material.dart';
import 'package:psi/screens/product_list.dart';

class SplashScreen extends StatefulWidget {
  
  static const ROUTE = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds:2), timerCallback);
  }

  void timerCallback(){
    Navigator.popAndPushNamed(context, ProductList.ROUTE);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.asset('assets/images/logo.jpg'),
              ),
              Text(
                'Hungry Bird',
                style: TextStyle(
                  fontSize: 40.0,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 3
                    ..color = Colors.pink,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
