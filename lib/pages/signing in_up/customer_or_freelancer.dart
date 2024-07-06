import 'package:connecthub/pages/signing%20in_up/signUp_Customer.dart';
import 'package:connecthub/pages/signing%20in_up/signup_freelancer.dart';
import 'package:connecthub/utils/my_colors.dart';
import 'package:flutter/material.dart';
class JoinButtons extends StatefulWidget {
  const JoinButtons({Key? key}) : super(key: key);

  @override
  _JoinButtonsState createState() => _JoinButtonsState();
}

class _JoinButtonsState extends State<JoinButtons> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Row(
            children: [
              Image.asset(
                'assets/connecthub-high-resolution-logo-black-removebg-preview.png',
                height: 100,
              ),
              const Text(
                'Join ConnectHub!',
                style: TextStyle(
                    fontSize: 30, color: primary, fontWeight: FontWeight.bold),
              )
            ],
          ),
          Image.asset(
            "assets/login&registration/vector-2.png",
            width: MediaQuery.sizeOf(context).width * 1,
            height: 300,
          ),
          const SizedBox(
            height: 10,
          ),
          
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isPressed = true;
              });
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpCustomer(userData: {},)));
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: const Color(0xFF5634FE).withAlpha(50)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: primary,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: _isPressed ? 220 : 250,
              height: 56,
              child: const Center(
                child: Text(
                  'Join as a Customer',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _isPressed = true;
              });
              Future.delayed(const Duration(milliseconds: 200), () {
                Navigator.push(context,  MaterialPageRoute(builder: (context) => const SignUpFreelancer(userData: {},)));
              });
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: const Color(0xFF5634FE).withAlpha(50)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              elevation: 0,
              shadowColor: Colors.transparent,
              backgroundColor: white,
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              width: _isPressed ? 220 : 250,
              height: 56,
              child: const Center(
                child: Text(
                  'Join as a Freelancer',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          
        ],
      ),
    );
  }
}
