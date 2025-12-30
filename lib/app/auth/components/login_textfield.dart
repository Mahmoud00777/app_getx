import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/utils/constants.dart';

// ignore: must_be_immutable
class LoginTextField extends StatefulWidget {
  bool isPass;
  LoginTextField({super.key, required this.isPass, required this.myController});

  final TextEditingController myController;

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool _isObscure = true;
  // bool isValidForm = false;

  @override
  Widget build(BuildContext context) {
    return widget.isPass
        ? TextFormField(
            controller: widget.myController,
            obscureText: _isObscure,
            // textAlign: TextAlign.center,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              isDense: true, // Added this
              filled: true,
              fillColor: Colors.white38,
              hintStyle: TextStyle(color: grey),
              prefixIcon: Icon(
                Icons.lock_outline_rounded,
                color: secondaryAppColor,
              ),
              suffixIcon: IconButton(
                color: grey,
                icon: Icon(
                  _isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: _isObscure ? grey : secondaryAppColor,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              ),

              hintText: "password".tr,
              // label: Text("Password"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 0.5, color: grey),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(20.0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: secondaryAppColor),
              ),
            ),
            validator: (inputValue) {
              if (inputValue!.isEmpty) {
                return "enterPassword".tr;
              }
              return null;
            },
          )
        : TextFormField(
            controller: widget.myController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: TextStyle(fontSize: 13),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: Colors.white38,
              hintStyle: TextStyle(color: grey),
              prefixIcon: Icon(
                Icons.person_outline_rounded,
                color: secondaryAppColor,
              ),

              hintText: "username".tr,
              // label: Text("Username"),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(width: 0.5, color: grey),
              ),
              focusedBorder: OutlineInputBorder(
                // borderRadius: BorderRadius.circular(15.0),
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(width: 2, color: secondaryAppColor),
              ),
            ),
            validator: (inputValue) {
              if (inputValue!.isEmpty) {
                return "enterUsername".tr;
              }
              return null;
            },
          );
  }
}

// ignore: must_be_immutable
// class LoginTextFieldURL extends StatefulWidget {
//   LoginTextFieldURL({
//     super.key,
//     required this.urlController,
//     required this.userController,
//     required this.passController,
//   });

//   final TextEditingController urlController;
//   final TextEditingController userController;
//   final TextEditingController passController;
//   final 

//   @override
//   State<LoginTextFieldURL> createState() => _LoginTextFieldURL();
// }

// class _LoginTextFieldURL extends State<LoginTextFieldURL> {
//   bool isValidForm = false;

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadFormField(
//                               noItemsFoundBuilder: (context) {
//                                 return Container(height: 0.0);
//                               },
//                               textFieldConfiguration: TextFieldConfiguration(
//                                 onTap: () {
//                                   // widget.myController.text = "https://";
//                                   widget.urlController.text =
//                                       "https://erp.hadeedpakistan.com/";
//                                 },
//                                 keyboardType: TextInputType.url,
//                                 textInputAction: TextInputAction.next,
//                                 controller: widget.urlController,
//                                 decoration: InputDecoration(
//                                   hintStyle: TextStyle(color: grey),
//                                   prefixIcon:
//                                       Icon(CupertinoIcons.globe, color: grey),
//                                   hintText: "URL",
//                                   enabledBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(40.0),
//                                     borderSide: BorderSide(
//                                       width: 0.5,
//                                       color: grey,
//                                     ),
//                                   ),
//                                   focusedBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(40.0),
//                                     borderSide:
//                                         BorderSide(width: 2, color: grey),
//                                   ),
//                                 ),
//                               ),
//                               validator: (inputValue) {
//                                 if (inputValue!.isEmpty) {
//                                   return "Enter URL";
//                                 }
//                                 return null;
//                               },
//                               suggestionsCallback: (pattern) async {
//                                 return urlList
//                                     .where((data) => data['url']!
//                                         .toLowerCase()
//                                         .contains(pattern.toLowerCase()))
//                                     .toList();
//                               },
//                               itemBuilder: (context, suggestion) {
//                                 return ListTile(
//                                   title: Text(suggestion['url'].toString()),
//                                 );
//                               },
//                               onSuggestionSelected: (suggestion) {
//                                 urlController.text =
//                                     suggestion['url'].toString();
//                                 usernameController.text =
//                                     suggestion['username'].toString();
//                                 passController.text =
//                                     suggestion['password'].toString();
//                               },
//                             );
//   }
// }

