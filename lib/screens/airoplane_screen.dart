import 'package:flutter/material.dart';

class PlaneAnimationPage extends StatefulWidget {
  const PlaneAnimationPage({Key? key}) : super(key: key);

  @override
  State<PlaneAnimationPage> createState() => _PlaneAnimationPageState();
}

class _PlaneAnimationPageState extends State<PlaneAnimationPage> {
  bool _isPlaneUp = false;
  int _index = 0;

  final List<Alignment> _alignments = [
    Alignment.bottomCenter,
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.topCenter
  ];

  void _toggleAnimation() {
    setState(() {
      _isPlaneUp = !_isPlaneUp;
      _index = (_index + 1) % _alignments.length; // Loop through alignments
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Plane Animation',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal,
      ),
      body: AnimatedContainer(
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        color: _isPlaneUp ? Colors.blue[300] : Colors.white,
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(seconds: 2),
              curve: Curves.easeInOut,
              alignment:
                  _isPlaneUp ? Alignment.bottomCenter : _alignments[_index],
              child: Image.asset(
                'assets/sign.png',
                height: 100,
                width: 100,
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width / 2 - 80,
              child: ElevatedButton(
                onPressed: _toggleAnimation,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                child: const Text(
                  "Toggle Animation",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
