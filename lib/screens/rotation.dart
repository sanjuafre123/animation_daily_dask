import 'package:flutter/material.dart';

class PlanetRotation extends StatefulWidget {
  const PlanetRotation({super.key});

  @override
  State<PlanetRotation> createState() => _PlanetRotationState();
}

class _PlanetRotationState extends State<PlanetRotation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  int duration = 1;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: duration),
      lowerBound: 0,
      upperBound: 1,
    )..repeat();
  }

  void updateDuration(int change) {
    setState(() {
      duration = (duration + change).clamp(1, 60);
      initialize();
      print(duration);
    });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return RotationTransition(
                turns: animationController,
                child: Center(
                  child: Container(
                    height: 280,
                    width: 280,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/earth.png'))),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 29.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              heroTag: 2,
              onPressed: () {
                updateDuration(1); // Decrease duration
              },
              child: const Icon(Icons.remove),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (animationController.isAnimating) {
                    animationController.stop();
                  } else {
                    animationController.repeat();
                  }
                });
              },
              child: Text(animationController.isAnimating ? 'Stop' : 'Start'),
            ),
            const SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              heroTag: 1,
              onPressed: () {
                updateDuration(-1); // Increase duration
              },
              child: const Icon(Icons.add),
            ),

          ],
        ),
      ),
    );
  }
}
