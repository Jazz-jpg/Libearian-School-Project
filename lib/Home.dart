import 'package:flutter/material.dart';
import 'package:flutterloginproject/screens/book_details_screen.dart';
import 'package:flutterloginproject/screens/books_overview_screen.dart';
import 'auth.dart';
import 'package:provider/provider.dart';
import 'package:flutterloginproject/providers/books.dart';
import 'package:flutterloginproject/Profile_page.dart';
import 'package:flutterloginproject/rentals.dart';

import 'favorites.dart';


class HomePage extends StatelessWidget {
  HomePage({this.auth, this.onSignedOut}); // <=== Class Homepage, Istantiates Constructor auth.dart, and voidcallback
  final BaseAuth auth;
  final VoidCallback onSignedOut; //

// When creating methods, if the method is NOT specific to the home screen, consider making a seperate file with methods that you can call in.
  // For example, the auth.dart file contains All of the current firebase methods that have been called. Those methods were then imported into login-page, main, and root, home
  // this allows those methods to be called in and used in those files.
  void signOut()async{// This is the sign-out method, this method is called with the FlatButton below, and will sign the user out it is an Asynch method
    try {
      await auth.signOut();
      onSignedOut();

    } catch(error) {
    print(error);
    }


  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Books(),
        ),
      ],
      child: MaterialApp(
          title: 'Libearian',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: BooksOverviewScreen(),
          routes: {
            '/Profile' : (context) => Profile(),
            '/Rentals' : (context) => Rentals(),
            '/Favorites' : (context) => Favorites(),
            BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
          }),
    );



  }
}