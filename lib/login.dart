import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:focuswork/homepage.dart';
import 'package:focuswork/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 155),
            Text(
              "LOGIN",
              style: GoogleFonts.bebasNeue(
                letterSpacing: 2.0,
                color: Color.fromARGB(255, 255, 255, 255),
                fontWeight: FontWeight.w600,
                fontSize: 55,
              ),
            ),
            Text(
              " Let’s get you setup with a new account!",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 55),
            GestureDetector(
              onTap: () async {
                try {
                  final userCredential = await Authentication().signingoogle();

                  if (userCredential != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Homepage()),
                    );
                  }
                } catch (e) {
                  print('Sign-in failed: $e');
                }
              },
              child: Container(
                height: 105,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 6,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/google.png",
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(width: 10),
                    Text(
                      "LOGIN WITH GOOGLE ",
                      style: GoogleFonts.bebasNeue(
                        letterSpacing: 2.0,
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontWeight: FontWeight.w600,
                        fontSize: 26,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
