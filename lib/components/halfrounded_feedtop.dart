// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'add_paymentfield.dart';

class HalfRoundedFeedTop extends StatefulWidget {
  String? text;
  Function()? onPress;
  HalfRoundedFeedTop({
    super.key,
    this.text,
    this.onPress,
  });

  @override
  State<HalfRoundedFeedTop> createState() => _HalfRoundedDropDownState();
}

class _HalfRoundedDropDownState extends State<HalfRoundedFeedTop> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AddPaymentField(
        hintText: widget.text,
        labelText: '',
        endIcon: Icon(Icons.arrow_right),
        readOnly: true,
        onPress: widget.onPress,
      ),
    );
  }
}
