// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'add_paymentfield.dart';
import 'common_text.dart';

class HalfRoundedDropDown extends StatefulWidget {
  TextEditingController? controller;
  List<String>? list;
  String? hintText;
  HalfRoundedDropDown({
    super.key,
    this.controller,
    this.list,
    this.hintText,
  });

  @override
  State<HalfRoundedDropDown> createState() => _HalfRoundedDropDownState();
}

class _HalfRoundedDropDownState extends State<HalfRoundedDropDown> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AddPaymentField(
        controller: widget.controller,
        hintText: widget.hintText,
        labelText: '',
        endIcon: Icon(Icons.arrow_drop_up_rounded),
        readOnly: true,
        onPress: () {
          mysheet(context, widget.list, widget.controller);
        },
      ),
    );
  }

  Future<dynamic> mysheet(BuildContext context, List<String>? list,
      TextEditingController? controller) {
    return showModalBottomSheet(
      backgroundColor: Colors.grey.shade200,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: list?.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      setState(() {
                        controller?.text = list[index];
                        Navigator.pop(context);
                      });
                    },
                    leading:
                        CommonText(text: list![index], weight: FontWeight.w500),
                  ),
                  Divider(color: Colors.black12),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
