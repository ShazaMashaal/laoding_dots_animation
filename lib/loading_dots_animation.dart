import 'package:flutter/material.dart';

class LoadingDotsAnimation extends StatefulWidget {
  const LoadingDotsAnimation({super.key});

  @override
  State<LoadingDotsAnimation> createState() => _LoadingDotsAnimationState();
}

class _LoadingDotsAnimationState extends State<LoadingDotsAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Animation<double> _buildAnimation(double start, double end) {
    return Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(start, end, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final dot1 = _buildAnimation(0.0, 0.3);
    final dot2 = _buildAnimation(0.3, 0.6);
    final dot3 = _buildAnimation(0.6, 1.0);

    return Scaffold(
      appBar: AppBar(title: const Text("Loading Dots")),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Dot(animation: dot1),
            const SizedBox(width: 8),
            _Dot(animation: dot2),
            const SizedBox(width: 8),
            _Dot(animation: dot3),
          ],
        ),
      ),
    );
  }
}

class _Dot extends AnimatedWidget {
  const _Dot({required Animation<double> animation})
    : super(listenable: animation);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: animation.value,
      child: Transform.scale(
        scale: animation.value,
        child: Container(
          height: 16,
          width: 16,
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
