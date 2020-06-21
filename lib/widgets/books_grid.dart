import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/books.dart';
import './book_item.dart';

class BooksGrid extends StatelessWidget {


  BooksGrid();

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Books>(context);

    final products =  productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: BookItem(
          // products[i].id,
          // products[i].title,
          // products[i].imageUrl,
        ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 0,
      ),
    );
  }
}