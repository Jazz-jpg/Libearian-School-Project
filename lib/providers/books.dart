import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutterloginproject/models/http_exceptions.dart';
import './book.dart';



class Books with ChangeNotifier {

  double RandomNumber(){
    Random r1 = new Random();
    return r1.nextDouble();
  }



  List<Book> _items = [
  ];


  List<Book> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }


  Book findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> fetchAndSetProducts() async {

    List<Book> _parseBookJson(String jsonStr) {
      final jsonMap = json.decode(jsonStr);
      final jsonList = (jsonMap['items'] as List);
      return jsonList.map((jsonBook) => Book(
        id: jsonBook['id'],
        title: jsonBook['volumeInfo']['title'],
        description: jsonBook['volumeInfo']['description'],//element.volumeInfo.description, //
        price: 7.99,//element.saleInfo.listPrice.amount,
        imageUrl: jsonBook['volumeInfo']['imageLinks']['thumbnail'].toString(), //element.volumeInfo.imageLinks.thumbnail,
        author: (jsonBook['volumeInfo']['authors'] as List).join(', '),
      )).toList();
    }


    List<Book> loadedBooks = [];

    const url = 'https://www.googleapis.com/books/v1/volumes?maxResults=40&q=subject:fiction';
    try {
      final response = await http.get(url);
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;
      loadedBooks = _parseBookJson(response.body);
      _items = loadedBooks;
      print('Google books api ran');
      //print(_items.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Book product) async {

  }

  Future<void> updateProduct(String id, Book newProduct) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url = 'https://flutter-update.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.price
          }));
      _items[prodIndex] = newProduct;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = 'https://flutter-update.firebaseio.com/products/$id.json';
    final existingProductIndex = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
  }

}

class Book2 {
  final String id;

  Book2({ this.id });

  final CollectionReference pageCollection = Firestore.instance.collection('purchasedBooks');

  Book _bookSnapshot(DocumentSnapshot snapshot) {
    return Book(
        id: id,
        title: snapshot.data['title'],
        author: snapshot.data['author'],
        description: snapshot.data['description'],
        price: snapshot.data['price'],
        imageUrl: snapshot.data['imageUrl']
    );
  }

  Stream<Book> get collection {
    return pageCollection.document(id).snapshots().map(_bookSnapshot);


  }

  List<Book> _items = [
  ];


  List<Book> get items {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._items];
  }

}
