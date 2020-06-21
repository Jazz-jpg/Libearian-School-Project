import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Book with ChangeNotifier {
  final String id;
  final String title;
  final String author;
  final String description;
  final double price;
  final String imageUrl;

  Book({
    @required this.id,
    @required this.title,
    @required this.author,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
  });

}