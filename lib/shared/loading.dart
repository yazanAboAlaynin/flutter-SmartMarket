import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.blue[200],
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.0,),
              Image.asset('images/logo.png'),
              SizedBox(height: 60.0,),
              SpinKitThreeBounce(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
