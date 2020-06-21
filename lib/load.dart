import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class Load extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(181, 154, 87, 1),
      child: Center(
        child: SpinKitWanderingCubes(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }
}
