import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/constants.dart';

class CustomLoadingWidget extends StatelessWidget {
  final String? text;
  const CustomLoadingWidget({
    this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: white,
          border: Border.all(
            color: white,
            width: 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
          borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // SpinKitCircle(color: primaryBlueApp, size: 45.0),
            Container(
                height: 60,
                width: 60,
                color: transparent,
                child: Lottie.asset('assets/animations/loading.json',
                    fit: BoxFit.cover, frameRate: FrameRate(120))),
            SizedBox(height: 5),
            Text(text ?? "Loading")
          ],
        ),
      ),
    );
  }
}
