import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp(String email, String password) async {
    return await _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> updateDisplayName(User customer, String name) async {
    await customer.updateDisplayName(name);
  }

  Future<void> saveUserDataToCustomer(String uid, String name, String email, String password) async {
    await _firestore.collection('customer').doc('data').collection('users').doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  Future<List<String>> fetchSignInMethodsForEmail(String email) async {
    return await _auth.fetchSignInMethodsForEmail(email);
  }
}
