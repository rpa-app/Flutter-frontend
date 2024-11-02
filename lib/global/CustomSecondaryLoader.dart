import 'package:flutter/material.dart';

class CustomLoader extends StatefulWidget {
  @override
  _CustomLoaderState createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      upperBound: 1.2, // Scale up to 1.2 times
    )..repeat(reverse: true); // Repeat the animation

    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(), // Loading indicator
          SizedBox(height: 16), // Spacing
          ScaleTransition(
            scale: _animation, // Apply the scale animation
            child: Image.asset(
              'Asset/Logo/ic_launcher.png',
              height: 80, // Adjusted height for smaller logo
            ),
          ),
          SizedBox(height: 16), // Spacing
          Text(
            "Signing in...",
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
