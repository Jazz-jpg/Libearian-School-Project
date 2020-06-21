import 'package:flutter/material.dart';
import 'package:flutterloginproject/user.dart';
import 'package:provider/provider.dart';
import './NavDrawer.dart';
import 'database.dart';
import 'package:flutterloginproject/Profile_forms.dart';
import 'package:flutterloginproject/StudentNavDrawer.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    void _showProfileName() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProfileName(),
        );
      });
    }

    void _showProfileEmail() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProfileEmail(),
        );
      });
    }

    void _showProfilePhone() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProfilePhone(),
        );
      });
    }

    void _showProfilePic() {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: ProfilePic(),
        );
      });
    }

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData) {

            UserData userData = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text('Profile Page'),
                backgroundColor: Color.fromRGBO(181, 154, 87, 1),
              ),
              drawer: userData.isAdmin ? NavDrawer() : StudentNavDrawer(),
              body: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    color: Colors.black,
                    child: Center(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 150,
                            height: 150,
                            margin: EdgeInsets.only(
                              top: 10,
                              bottom: 10
                            ),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage(
                                  userData.pic
                                ),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      userData.name,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('Name'),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showProfileName(),
                  ),
                  ListTile(
                    title: Text(
                      userData.email,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('Email'),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showProfileEmail(),
                  ),
                  ListTile(
                    title: Text(
                      userData.phone,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text('Phone Number'),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showProfilePhone(),
                  ),
                  ListTile(
                    title: Text(
                      'Profile Picture',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    trailing: Icon(Icons.edit),
                    onTap: () => _showProfilePic(),
                  ),
                ],
              ),
            );
          }
          else {
            return null; //loading page?
          }
        }
    );
  }
}
