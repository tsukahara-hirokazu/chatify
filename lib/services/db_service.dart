import 'package:cloud_firestore/cloud_firestore.dart';

class DBService {
  static DBService instance = DBService();

  Firestore _db;

  DBService() {
    _db = Firestore.instance;
  }

  String _userCollection = "Users";

  Future<void> createUserInDB(
      String _uid, String _name, String _email, String _imageURL) async {
    try {
      return await _db.collection(_userCollection).document(_uid).setData({
        "name": _name,
        "email": _email,
        "password": _imageURL,
        "lastSeen": DateTime.now(),
      });
    } catch (e) {
      print(e);
    }
  }
}
