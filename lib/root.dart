import 'package:flutter/material.dart';
import 'package:flutterloginproject/screens/books_overview_screen.dart';
import 'login_page.dart';
import 'auth.dart';
import 'load.dart';

class RootPage extends StatefulWidget {
  RootPage({this.auth});
  final BaseAuth auth;
  @override
    State<StatefulWidget> createState() => new _RootPageState();
  }

  enum AuthStatus {
  notSignedIn,
    signedIn
  }


class _RootPageState extends State<RootPage> {

  AuthStatus _authStatus = AuthStatus.notSignedIn;

  @override
  void initState() {
    // Checks for current user status when app is started
    super.initState();
    widget.auth.currentUser().then((userId) {
      setState(() {
        _authStatus =
        userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      _authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      _authStatus = AuthStatus.notSignedIn;
    });
  }


  Widget build(BuildContext context) {
    ErrorWidget.builder = (FlutterErrorDetails details) => Load();
    switch (_authStatus) {
      case AuthStatus.notSignedIn:
        return new Loginpage(auth: widget.auth, onSignedIn: _signedIn);
      case AuthStatus.signedIn:
        return new BooksOverviewScreen();
    }
    return new Loginpage(auth: widget.auth);
  }
}