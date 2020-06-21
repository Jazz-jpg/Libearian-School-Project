import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterloginproject/user.dart';


class Database {
  final String uid;
  Database({ this.uid });


  final CollectionReference bookCollection = Firestore.instance.collection('bookData');

  Future updateUserData(String name, String email, String phone, String pic, bool isAdmin) async {
    return await bookCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'pic' : pic,
      'isAdmin' : isAdmin,
    });
  }


  Future updateLibrary (String book) async {
    DocumentReference docRef = Firestore.instance.collection('library').document('books');
    DocumentSnapshot doc = await docRef.get();
    List purchasedBooks = doc.data['Books'];
    if (purchasedBooks.contains(book) == true) {
      docRef.updateData({'Books': FieldValue.arrayRemove([book])});
    } else {
      docRef.updateData({'Books': FieldValue.arrayUnion([book])});
    }
  }

  UserData _userSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      phone: snapshot.data['phone'],
      pic: snapshot.data['pic'],
        isAdmin: snapshot.data['isAdmin']
    );
  }

  final CollectionReference pages = Firestore.instance.collection('purchasedBooks');

  Future updateBookData(String id, String title, String author, String description, double price, String imageUrl) async {
    return await pages.document(id).setData({
      'id' : id,
      'title' : title,
      'author' : author,
      'description' : description,
      'price' : price,
      'imageUrl' : imageUrl,
    });
  }

  Stream<UserData> get userData {
    return bookCollection.document(uid).snapshots().map(_userSnapshot);
  }




}

