import 'package:flutter/material.dart';
import 'package:tomatoapp/screens/CameraPage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    const HomePage(),
    const CameraPage(),
  ];
  void onTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: onTapped,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt_rounded),
            label: 'Camera',
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      // Background
      color: const Color(0xFF38384E),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 16),
          ), //10% from the total screen size
          const Text('Instructions',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          Row(
            children: [
              Image.asset(
                'assets/images/scanner.png',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              const SizedBox(width: 30),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Capture Photo',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Use your device\'s camera to snap or upload a picture of the tomato leaf.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          Row(
            children: [
              Image.asset(
                'assets/images/approved.png',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              const SizedBox(width: 30),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Classify',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                        'The app will analyze the image to identify and display the tomato leaf disease.',
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height / 25),
          Row(
            children: [
              Image.asset(
                'assets/images/note.png',
                width: 32,
                height: 32,
                color: Colors.white,
              ),
              const SizedBox(width: 30),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Show Results',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    Text(
                      'Review the results for disease details and follow any suggested treatment or remedies provided by the app.',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
