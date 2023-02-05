import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:flutter_animatons/advanced_animation.dart';

// create custom shortcuts same guy

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(brightness: Brightness.dark),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        home: const AdvancedAnimation() //const HomePage(),
        );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 2 * pi,
    ).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /* 
  0.0 = 0 degrees
  0.5 = 180 degrees
  1.0 = 360 degrees
  */
  // transform describe how and where tit child can go or how can go
  // you need to add something which animates depend on the controller
  // need to re render the screen with animated builder

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform(
              // alignment center means it draws a circle at the center and it rotate the object at cthe center
              // with origin: offset you an more specify where the middle of the rotating point should be (egy pntotállitasz be ami köré egy kört rajzol és az a pont lesz a köep a körül forog az object)
              // Offset(50,50) now it means th middle because our container is a 100 by 100 Offset(x,y)
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..rotateY(
                  _animation.value,
                ),
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.deepPurple,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
