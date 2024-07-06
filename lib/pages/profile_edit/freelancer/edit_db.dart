import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<Map<String, dynamic>> getUserData(String uid) async {
    final doc = await _db.collection('freelancer').doc(uid).get();
    return doc.data() ?? {};
  }

  Future<void> updateUserData(String uid, Map<String, dynamic> data) async {
    await _db.collection('freelancer').doc(uid).set(data, SetOptions(merge: true));
  }
}
