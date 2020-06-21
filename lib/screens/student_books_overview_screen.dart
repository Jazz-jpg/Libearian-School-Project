import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../NavDrawer.dart';
import '../widgets/books_grid.dart';
import '../providers/books.dart';

enum FilterOptions {
  Favorites,
  All,
}

class StudentBooksOverviewScreen extends StatefulWidget {
  @override
  _StudentBooksOverviewScreenState createState() => _StudentBooksOverviewScreenState();
}

class _StudentBooksOverviewScreenState extends State<StudentBooksOverviewScreen> {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Student'),
        backgroundColor: Color.fromRGBO(181, 154, 87, 1),
      ),
      drawer: NavDrawer(),
      body: BooksGrid(),
    );
  }
}
