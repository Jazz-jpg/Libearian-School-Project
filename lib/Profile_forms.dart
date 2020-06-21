import 'package:flutter/material.dart';
import 'package:flutterloginproject/user.dart';
import 'package:provider/provider.dart';
import 'package:flutterloginproject/database.dart';
import 'package:flutterloginproject/load.dart';

class ProfileName extends StatefulWidget {
  @override
  _ProfileNameState createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentEmail;
  String _currentPhone;
  String _currentPic;
  bool _isAdmin;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
      stream: Database(uid: user.uid).userData,
      builder: (context, snapshot) {

        if(snapshot.hasData) {

          UserData userData = snapshot.data;

          return Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Text('Update your name'),
                TextFormField(
                  decoration: InputDecoration(labelText: _currentName ?? userData.name, hintText: 'Name'),
                  validator: (value) => value.isEmpty ? 'Please enter a name' : null,
                  onChanged: (value) => setState(() => (_currentName = value)),
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                  color: Color.fromRGBO(181, 154, 87, 1),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () async {
                    if(_formKey.currentState.validate()) {
                      await Database(uid: user.uid).updateUserData(
                        _currentName ?? userData.name,
                        _currentEmail ?? userData.email,
                        _currentPhone ?? userData.phone,
                        _currentPic ?? userData.pic,
                        _isAdmin ?? userData.isAdmin,
                      );
                    }
                  },
                ),
              ],
            ),
          );
        } else {
          return Load();
        }
      }
    );
  }
}

class ProfileEmail extends StatefulWidget {
  @override
  _ProfileEmailState createState() => _ProfileEmailState();
}

class _ProfileEmailState extends State<ProfileEmail> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentEmail;
  String _currentPhone;
  String _currentPic;
  bool _isAdmin;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData) {

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your email'),
                  TextFormField(
                    decoration: InputDecoration(labelText: _currentEmail ?? userData.email, hintText: 'Email'),
                    validator: (value) => value.isEmpty ? 'Please enter an email address' : null,
                    onChanged: (value) => setState(() => (_currentEmail = value)),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Color.fromRGBO(181, 154, 87, 1),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await Database(uid: user.uid).updateUserData(
                          _currentName ?? userData.name,
                          _currentEmail ?? userData.email,
                          _currentPhone ?? userData.phone,
                          _currentPic ?? userData.pic,
                          _isAdmin ?? userData.isAdmin,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Load();
          }
        }
    );
  }
}

class ProfilePhone extends StatefulWidget {
  @override
  _ProfilePhoneState createState() => _ProfilePhoneState();
}

class _ProfilePhoneState extends State<ProfilePhone> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentEmail;
  String _currentPhone;
  String _currentPic;
  bool _isAdmin;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData) {

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your phone'),
                  TextFormField(
                    decoration: InputDecoration(labelText: _currentPhone ?? userData.phone, hintText: 'Phone'),
                    validator: (value) => value.isEmpty ? 'Please enter a phone number' : null,
                    onChanged: (value) => setState(() => (_currentPhone = value)),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Color.fromRGBO(181, 154, 87, 1),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await Database(uid: user.uid).updateUserData(
                          _currentName ?? userData.name,
                          _currentEmail ?? userData.email,
                          _currentPhone ?? userData.phone,
                          _currentPic ?? userData.pic,
                          _isAdmin ?? userData.isAdmin,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Load();
          }
        }
    );
  }
}

class ProfilePic extends StatefulWidget {
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {

  final _formKey = GlobalKey<FormState>();

  String _currentName;
  String _currentEmail;
  String _currentPhone;
  String _currentPic;
  bool _isAdmin;

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {

          if(snapshot.hasData) {

            UserData userData = snapshot.data;

            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text('Update your profile pic URL'),
                  TextFormField(
                    decoration: InputDecoration(labelText: _currentPhone ?? userData.pic, hintText: 'URL'),
                    validator: (value) => value.isEmpty ? 'Please enter a URL' : null,
                    onChanged: (value) => setState(() => (_currentPic = value)),
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    color: Color.fromRGBO(181, 154, 87, 1),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        await Database(uid: user.uid).updateUserData(
                          _currentName ?? userData.name,
                          _currentEmail ?? userData.email,
                          _currentPhone ?? userData.phone,
                          _currentPic ?? userData.pic,
                          _isAdmin ?? userData.isAdmin,
                        );
                      }
                    },
                  ),
                ],
              ),
            );
          } else {
            return Load();
          }
        }
    );
  }
}