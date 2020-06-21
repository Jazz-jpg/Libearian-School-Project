import 'package:flutter/material.dart';
import 'package:flutterloginproject/favorites.dart';
import 'package:flutterloginproject/providers/student_books.dart';
import 'package:flutterloginproject/rentals.dart';
import 'package:flutterloginproject/screens/book_details_screen.dart';
import 'package:flutterloginproject/user.dart';
import 'auth.dart';
import 'root.dart';
import 'package:provider/provider.dart';
import 'package:flutterloginproject/Profile_page.dart';
import 'providers/books.dart';



void main() {

  runApp(new MyApp());


}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Books(),
        ),
        ChangeNotifierProvider.value(
          value: StudentBooks(),
        )
      ],
      child: StreamProvider<User>.value(
        value: Auth().user,
        child: new MaterialApp(
            debugShowCheckedModeBanner: false,
          title: 'Loogin page',
          routes: {
              '/Profile' : (context) => Profile(),
            '/Rentals' : (context) => Rentals(),
            '/Favorites' : (context) => Favorites(),
            BookDetailScreen.routeName: (ctx) => BookDetailScreen()
          },
          theme: new ThemeData(

          ),
          home: new RootPage(auth: new Auth())
        ),
      ),
    );
  }
}

