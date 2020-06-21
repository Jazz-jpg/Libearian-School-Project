import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/student_books.dart';
import './book_item.dart';

class StudentBooksGrid extends StatelessWidget {


  StudentBooksGrid();

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<StudentBooks>(context);
    final products =  productsData.studentitems;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // builder: (c) => products[i],
        value: products[i],
        child: BookItem(
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