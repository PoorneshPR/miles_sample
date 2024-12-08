import 'package:flutter/material.dart';
import 'package:miles_sample/home/views/miles_home_screen.dart';
import 'package:miles_sample/theme/color_utils.dart';

class AnimatedGradientCircle extends StatefulWidget {
  final double size; // Diameter of the circle
  final Widget child;
  final bool isWatched;// Inner widget, e.g., profile image

  const AnimatedGradientCircle(
      {Key? key, required this.size, required this.child,required this.isWatched})
      : super(key: key);

  @override
  _AnimatedGradientCircleState createState() => _AnimatedGradientCircleState();
}

class _AnimatedGradientCircleState extends State<AnimatedGradientCircle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1), // Adjust for animation speed
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 0.1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return
    SizedBox(
      height: widget.size,
      width: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          widget.isWatched?  ShaderMask(
            shaderCallback: (rect) {
              return LinearGradient(

                // Full circle
                colors: const [

                  Colors.white30,
                  Colors.grey,
                  Colors.grey,
                  Colors.grey,
                  Colors.white30,


                ],
                stops: List.generate(5, (index) => index / 6.0)
                    .map((stop) => (stop + _animation.value) % 1.0)
                    .toList(),
              ).createShader(rect);
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white, // Inner content masked
              ),
            ),
          ):AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return ShaderMask(
                shaderCallback: (rect) {
                  return SweepGradient(
                    center: Alignment.center,
                    startAngle: 0.0,
                    endAngle: 2* 3.141592653589793,
                    // Full circle
                    colors: [

                      "#f279ad".toColor(),

                      "#221b1e".toColor(),
                      Colors.blue,
                      "#f279ad".toColor(),
                      "#f279ad".toColor(),
                    ],
                    stops: List.generate(5, (index) => index / 6.0)
                        .map((stop) => (stop + _animation.value) % 1.0)
                        .toList(),
                  ).createShader(rect);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white, // Inner content masked
                  ),
                ),
              );
            },
          ),

          Container(
            height: widget.size * 0.85,
            width: widget.size * 0.85,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // Background for the image
            ),
            child: ClipOval(
              child: widget.child, // Profile image
            ),
          ),
        ],
      ),
    );
  }
}
