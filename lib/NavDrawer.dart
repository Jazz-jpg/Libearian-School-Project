import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginproject/user.dart';
import 'package:provider/provider.dart';
import 'package:flutterloginproject/database.dart';

import 'load.dart';

class NavDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) => Load(); //signout error
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {

        UserData userData = snapshot.data;

        if(snapshot.hasData){

          return Drawer(

              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Color.fromRGBO(181, 154, 87, 1),
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 100,
                            margin: EdgeInsets.only(
                              top: 30,
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(userData.pic),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            userData.name,
                            style: TextStyle(
                              fontSize: 22,
                            ),
                          ),
                          Text(userData.email),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    leading:Icon(Icons.home),
                    title: Text(
                      'Home',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: (){
                      Navigator.popUntil(context, ModalRoute.withName("/"));// Creates a route that blocks interaction with previous routes
                      print('You have succesfully returned to home');

                      // Clears all current routes and pushes to homepage, I am unsure if it actually clears all the routes but it says it does in the syntax i looked up
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/Profile');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text(
                      'Logout',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();

                      print('you have successfully logged out');
                      Navigator.of(context).pushReplacementNamed('/'); // This might be causing a problem?
                    },
                  ),
                ],
              )
          );
        } else {
          return Load();
        }
      }
    );
  }
}
