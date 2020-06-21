import 'package:flutter/material.dart';
import 'package:flutterloginproject/screens/book_details_screen.dart';
import 'package:provider/provider.dart';
import '../providers/book.dart';

class BookItem extends StatelessWidget {
//  final String id;
//  final String title;
//  final String imageUrl;

  //BookItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context, listen: false);
    //final cart = Provider.of<Cart>(context, listen: false);
    return ClipRRect(
      child: GridTile(
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              BookDetailScreen.routeName,
              arguments: book.id,
            );
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 170,
                color: Colors.black,
                child: Image.network(
                  book.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              SingleChildScrollView(child: Text(book.title))
            ],
          ),
        ),
      ),
    );
  }
}