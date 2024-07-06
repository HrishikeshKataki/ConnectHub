import 'package:connecthub/bottom_navbar.dart';
import 'package:connecthub/pages/home/home.dart';
import 'package:connecthub/pages/search_screen.dart';
import 'package:connecthub/pages/signing%20in_up/customer_or_freelancer.dart';
import 'package:connecthub/pages/signing%20in_up/freelancer_form.dart';
import 'package:connecthub/pages/signing%20in_up/signUp_Customer.dart';
import 'package:connecthub/pages/signing%20in_up/signup_freelancer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:connecthub/pages/signing%20in_up/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyAHcGbVblnMCSs6RNRvVi-41RRD-Wio8Fs",
      appId: "1:105894020552:web:7a34e8ef46ddc51538ecfd",
      messagingSenderId: "105894020552",
      projectId: "connecthub-7c7cf",
      authDomain: "connecthub-7c7cf.firebaseapp.com",
      storageBucket: "connecthub-7c7cf.appspot.com",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const LoginScreen(userData: {},),
      routes: {
        'Login': (context) => const LoginScreen(userData: {},),
        'SignUpCustomer': (context) => const SignUpCustomer(userData: {},),
        'SignUpFreelancer': (context) => const SignUpFreelancer(userData: {},),
        'Search': (context) => const Search(),
        '/Join': (context) => const JoinButtons(),
        'FreelancerForm': (context) => const FreelancerForm(),
        'home': (context) => const home(),
        'navbar': (context) => BottomNavBar(),
      },
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const home()),
    );
  }
}