import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class GreetingPage extends StatefulWidget {
  const GreetingPage({super.key});

  @override
  State<GreetingPage> createState() => _GreetingPageState();
}

class _GreetingPageState extends State<GreetingPage> {
  String name = "";
  bool showGreeting = false;
  bool showMessage = false;

  void resetAnimation() {
    setState(() {
      name = "";
      showGreeting = false;
      showMessage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          // Greeting Animation
          AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            alignment: showGreeting ? Alignment.topLeft : Alignment.center,
            child: showGreeting
                ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: AnimatedTextKit(
                totalRepeatCount: 1, // Ensure it animates only once
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Hello, $name!",
                    textStyle: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                onFinished: () {
                  setState(() {
                    showMessage = true;
                  });
                },
              ),
            )
                : const SizedBox.shrink(),
          ),

          // Input Field
          Center(
            child: showGreeting
                ? const SizedBox.shrink()
                : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: TextField(
                cursorColor: Colors.deepOrange,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.teal),
                decoration: const InputDecoration(
                  hintText: "Enter your name",
                  hintStyle: TextStyle(color: Colors.teal),
                  border: UnderlineInputBorder(),
                  focusedBorder: UnderlineInputBorder(
                    borderSide:
                    BorderSide(color: Colors.teal, width: 1.5),
                  ),
                ),
                onSubmitted: (value) {
                  setState(() {
                    name = value;
                    showGreeting = true;
                    Future.delayed(
                      const Duration(seconds: 5),
                          () {
                        resetAnimation();
                      },
                    );
                  });
                },
              ),
            ),
          ),

          // Motivational Message Box
          AnimatedAlign(
            duration: const Duration(seconds: 1),
            curve: Curves.easeInOut,
            alignment: Alignment.center,
            child: AnimatedContainer(
              duration: const Duration(seconds: 1),
              padding: const EdgeInsets.all(8),
              curve: Curves.easeInOut,
              width: showMessage ? MediaQuery.of(context).size.width * 0.8 : 0,
              height: showMessage ? 120 : 0,
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: showMessage
                  ? const Center(
                child: Text(
                  "Your potential is endless. Keep reaching for the stars!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }
}
