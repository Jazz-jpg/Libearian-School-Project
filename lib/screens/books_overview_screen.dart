import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginproject/providers/student_books.dart';
import 'package:provider/provider.dart';
import '../NavDrawer.dart';
import '../StudentNavDrawer.dart';
import '../database.dart';
import '../user.dart';
import '../widgets/books_grid.dart';
import '../providers/books.dart';
import 'package:flutterloginproject/database.dart';
import 'package:flutterloginproject/user.dart';
import 'package:flutterloginproject/widgets/student_books_grid.dart';

import '../widgets/books_grid.dart';
import '../widgets/books_grid.dart';

enum FilterOptions {
  Favorites,
  All,
}

class BooksOverviewScreen extends StatefulWidget {
  @override
  _BooksOverviewScreenState createState() => _BooksOverviewScreenState();
}

class _BooksOverviewScreenState extends State<BooksOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;

  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<StudentBooks>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      Provider.of<Books>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {

          UserData userData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: userData.isAdmin ? Text('Purchase Books') : Text('Hello, ${userData.name}'),
              backgroundColor: Color.fromRGBO(181, 154, 87, 1),
            ),
            drawer: userData.isAdmin ? NavDrawer() : StudentNavDrawer(),
            body: userData.isAdmin ? BooksGrid() : StudentBooksGrid(),
          );
        }
    );
  }
}
