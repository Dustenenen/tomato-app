import 'package:flutter/material.dart';
import 'package:tomatoapp/screens/MyHomePage.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Container(
              // Background
              color: const Color(0xFF53624F),
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              // Logo
              top: MediaQuery.of(context).size.height / 10,
              left: MediaQuery.of(context).size.width / 2 - 100,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height / 5,
              left: MediaQuery.of(context).size.width * 0.3,
              right: MediaQuery.of(context).size.width * 0.3,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Add button click logic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyHomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFFD2E3C8), // Set the background color
                  ),
                  child: const Text(
                    'Start',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'K2D',
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
