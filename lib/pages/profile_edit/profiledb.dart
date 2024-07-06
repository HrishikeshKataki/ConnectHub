import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> updateUserData(
      String freelancerId, Map<String, dynamic> data) async {
    final firestore = FirebaseFirestore.instance;
    final freelancerRef = firestore.collection('freelancers').doc(freelancerId);
    await freelancerRef.update(data);
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      Map<String, dynamic> userData = {};

      // Fetch data from the 'freelancer' collection
      DocumentSnapshot freelancerSnapshot =
          await _firestore.collection('freelancer').doc(userId).get();
      if (freelancerSnapshot.exists) {
        userData.addAll(freelancerSnapshot.data() as Map<String, dynamic>);
      }

      // Fetch email from the 'users' collection
      DocumentSnapshot userSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        userData['email'] = userSnapshot.get('email');
      }

      return userData;
    } catch (error) {
      print('Error fetching user data: $error');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getYourservicesData(String userId) async {
    try {
      List<Map<String, dynamic>> yourservicesData = [];

      // Fetch data from the 'Yourservices' subcollection
      QuerySnapshot yourservicesSnapshot = await _firestore
          .collection('Service')
          .doc(userId)
          .collection('Yourservices')
          .get();

      for (var doc in yourservicesSnapshot.docs) {
        Map<String, dynamic> yourserviceData = {
          'title': doc.get('title'),
          'description': doc.get('description'),
          'price': doc.get('price'),
          'included': List.from(doc.get('included')),
        };
        yourservicesData.add(yourserviceData);
      }

      return yourservicesData;
    } catch (error) {
      print('Error fetching yourservices data: $error');
      return [];
    }
  }
}
