import 'package:animation_daily_dask/screens/airoplane_screen.dart';
import 'package:animation_daily_dask/screens/greeting_animation.dart';
import 'package:animation_daily_dask/screens/hero_animation.dart';
import 'package:animation_daily_dask/screens/puzzle.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
