import 'package:flutter/material.dart';
import 'package:flutterloginproject/user.dart';
import 'package:provider/provider.dart';
import './NavDrawer.dart';
import 'database.dart';
import 'package:flutterloginproject/StudentNavDrawer.dart';

class Rentals extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData) {

            UserData userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text('Rental Page'),
                backgroundColor: Color.fromRGBO(181, 154, 87, 1),
              ),
              drawer: userData.isAdmin ? NavDrawer() : StudentNavDrawer(),
            );
          }
          else {
            return null; //loading page?
          }
        }
    );
  }
}
