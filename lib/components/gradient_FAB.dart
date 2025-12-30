import 'package:flutter/material.dart';
import 'package:pos_app/utils/constants.dart';
import 'dart:math' as math;

class GradientOutlineFAB extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const GradientOutlineFAB({
    super.key,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 63,
      height: 63,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: <Color>[primaryAppColor, secondaryAppColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(2, 2),
          ),
        ],
      ),
      child: Container(
        width: 60,
        height: 60,
        margin: EdgeInsets.all(1),
        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
        child: FloatingActionButton(
          shape: CircleBorder(),
          backgroundColor: Colors.white,
          onPressed: onPressed,
          elevation: 0,
          child: Icon(icon, color: secondaryAppColor),
        ),
      ),
    );
  }
}

//===============================================
class AnimatedOutline extends StatefulWidget {
  const AnimatedOutline({super.key});

  @override
  _AnimatedOutlineState createState() => _AnimatedOutlineState();
}

class _AnimatedOutlineState extends State<AnimatedOutline>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: 0.0, end: 360.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: GradientOutlinePainter(_animation.value),
            child: Container(
              width: 200,
              height: 200,
              alignment: Alignment.center,
              child: Text('Hello, Flutter!', style: TextStyle(fontSize: 20)),
            ),
          );
        },
      ),
    );
  }
}

class GradientOutlinePainter extends CustomPainter {
  final double hueShift;

  GradientOutlinePainter(this.hueShift);

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final paint = Paint()
      ..shader = SweepGradient(
        colors: [
          HSVColor.fromAHSV(1.0, hueShift, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, (hueShift + 90) % 360, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, (hueShift + 180) % 360, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, (hueShift + 270) % 360, 1.0, 1.0).toColor(),
          HSVColor.fromAHSV(1.0, hueShift, 1.0, 1.0).toColor(),
        ],
        startAngle: 0.0,
        endAngle: math.pi * 2,
      ).createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5.0;

    final borderRadius = BorderRadius.circular(10);
    final rrect = RRect.fromRectAndCorners(
      rect,
      topLeft: borderRadius.topLeft,
      topRight: borderRadius.topRight,
      bottomLeft: borderRadius.bottomLeft,
      bottomRight: borderRadius.bottomRight,
    );
    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant GradientOutlinePainter oldDelegate) {
    return oldDelegate.hueShift != hueShift;
  }
}
