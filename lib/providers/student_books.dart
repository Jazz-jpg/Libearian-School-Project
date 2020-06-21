import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutterloginproject/models/http_exceptions.dart';
import './book.dart';




class StudentBooks with ChangeNotifier {

  List<Book> _studentItems = [
  ];


  List<Book> get studentitems {
    // if (_showFavoritesOnly) {
    //   return _items.where((prodItem) => prodItem.isFavorite).toList();
    // }
    return [..._studentItems];
  }


  Book findById(String id) {
    return _studentItems.firstWhere((prod) => prod.id == id);
  }



  Future<void> fetchAndSetProducts() async {

    List<Book> _parseBookJson(String jsonStr) {
      final jsonMap = json.decode(jsonStr);
      final jsonList = (jsonMap['documents'] as List);
      return jsonList.map((jsonBook) => Book(
        id: jsonBook['fields']['id']['stringValue'],
        title: jsonBook['fields']['title']['stringValue'],
        description: jsonBook['fields']['description']['stringValue'],//element.volumeInfo.description,
        price: jsonBook['fields']['price']['doubleValue'],//element.saleInfo.listPrice.amount,
        imageUrl: jsonBook['fields']['imageUrl']['stringValue'], //element.volumeInfo.imageLinks.thumbnail,
        author: jsonBook['fields']['author']['stringValue'],
      )).toList();
    }


    List<Book> loadedBooks = [];

    const url = 'https://firestore.googleapis.com/v1beta1/projects/libearian-e8a24/databases/(default)/documents/purchasedBooks?key=AIzaSyD3uaTcD9DGw9WF_NPbPm9f4-H_UgZs528';
    try {
      final response = await http.get(url);
      //final extractedData = json.decode(response.body) as Map<String, dynamic>;
      loadedBooks = _parseBookJson(response.body);
      _studentItems = loadedBooks;
      //print(_studentItems.length);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addProduct(Book product) async {
  }























}
