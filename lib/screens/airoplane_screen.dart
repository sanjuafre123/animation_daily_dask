import 'package:flutter/material.dart';

class FlightScreen extends StatefulWidget {
  const FlightScreen({super.key});

  @override
  State<FlightScreen> createState() => _FlightScreenState();
}

class _FlightScreenState extends State<FlightScreen> {
  Alignment _alignment = Alignment.bottomCenter; // Start at bottom center
  bool isBooked = false; // Track booking status

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isBooked ? Colors.teal : Colors.blueAccent,
        centerTitle: true,
        title: Text(
          'Animated Container',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          // Animated Container for the movement
          AnimatedAlign(
            duration: Duration(seconds: 2),
            curve: Curves.easeInOut,
            alignment: _alignment, // Animate alignment from bottom to center
            child: Container(
              height: 100,
              width: 100,
              child: Image.asset(
                'assets/sign.png',
                color: isBooked ? Colors.teal : Colors.blueAccent,
              ),
            ),
          ),
          // Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  // Toggle position and update booking state
                  _alignment = _alignment == Alignment.bottomCenter
                      ? Alignment.topLeft
                      : Alignment.bottomCenter;
                  isBooked = !isBooked;
                  if(_alignment==Alignment.topRight)
                    {
                      _alignment = _alignment == Alignment.bottomCenter
                          ? Alignment.topLeft
                          : Alignment.bottomCenter;
                    }
                });
              },
              child: Container(
                height: 50,
                width: 250,
                margin: EdgeInsets.only(bottom: 10),
                // Adjust spacing if needed
                decoration: BoxDecoration(
                  color: isBooked ? Colors.teal : Colors.blueAccent,
                  // Change color
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (isBooked)
                        ? Icon(
                            Icons.check,
                            color: Colors.white,
                          )
                        : Image.asset(
                            'assets/sign.png',
                            color: Colors.white,
                          ),
                    SizedBox(width: 8),
                    Text(
                      isBooked
                          ? 'Success! Ticket is Booked' // Change text
                          : 'Book your Tickets',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
