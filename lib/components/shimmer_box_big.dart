import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../utils/constants.dart';

class ShimmerCardBig extends StatelessWidget {
  const ShimmerCardBig({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Animate(
      onPlay: (controller) => controller.repeat(),
      effects: [ShimmerEffect(color: Colors.white, duration: 1500.ms)],
      child: Container(
        height: 200,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: textSubWhite,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.35),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 2)),
          ],
        ),
      ),
    );
  }
}
