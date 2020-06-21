import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterloginproject/database.dart';
import 'package:provider/provider.dart';


import '../providers/books.dart';

class BookDetailScreen extends StatelessWidget {
  // final String title;
  // final double price;

  // ProductDetailScreen(this.title, this.price);
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final productId =
    ModalRoute.of(context).settings.arguments as String; // is the id!
    final loadedProduct = Provider.of<Books>(
      context,
      listen: false,
    ).findById(productId);
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 245, 240, 1),
      appBar: AppBar(
        title: Text(loadedProduct.title),
        backgroundColor: Color.fromRGBO(181, 154, 87, 1),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                loadedProduct.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${loadedProduct.title}',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height:1,
            ),
            Text(loadedProduct.author,textAlign: TextAlign.center,style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                loadedProduct.description,
                textAlign: TextAlign.left,
                softWrap: true,style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),

              ),
            ),

            Container(
              padding: new EdgeInsets.all(30),
              child: Row(children: <Widget>[
                new ButtonTheme(
                  height: 50.0,
                  minWidth: 170.0,
                  buttonColor: Colors.black,

                  child: new RaisedButton(
                    onPressed: null,
                    child: new Text('Favorite',
                        style: new TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15.0,
                          color: Color.fromRGBO(181, 154, 87, 1),)),
                  ),
                ),
                new SizedBox(width: 10.0,),
                new ButtonTheme(
                    height: 50.0,
                    minWidth: 170.0,
                    buttonColor: Color.fromRGBO(181, 154, 87, 1),

                    child: new RaisedButton(
                        onPressed: null,
                        child: new Text('Rent',
                            style: new TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 15.0,
                              color: Colors.white,)
                        )
                    )
                ),

              ],
              ),
            ),

            FlatButton(
              child: Text('purchase'),
              onPressed: () async {
                Database(uid: loadedProduct.id).updateBookData(loadedProduct.id, loadedProduct.title, loadedProduct.author, loadedProduct.description, loadedProduct.price, loadedProduct.imageUrl);
              },
            ),
          ],
        ),
      ),
    );
  }
}
