// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:pos_app/components/common_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../components/common_button_icon.dart';
import '../../../components/common_text.dart';
import '../../../components/exit_dialog.dart';
import '../../../components/no_internet_dialog.dart';
import '../../../utils/app_size_config.dart';
import '../../../utils/constants.dart';
import '../../../utils/controllers/data_controller.dart';
// ignore: unused_import
import '../components/error_url_dialog.dart';
import '../components/login_textfield.dart';
import '../controller/login_controller.dart';

// ألوان خاصة بهذه الشاشة
const Color kPrimaryTealDark = Color(0xFF004F53);
const Color kPrimaryTealLight = Color(0xFF007C84);
const Color kAccentText = Color(0xFFB2A58C);

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController urlController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final DataController dataController = Get.put(DataController());
  // final GoogleSheetController googleSheetController = Get.put(
  //   GoogleSheetController(),
  // );

  String selectedProtocol = 'https';
  var isLoading = true.obs;
  bool isValidForm = false;
  bool rememberMe = false;
  final _formkey = GlobalKey<FormState>();
  final LoginController loginController = Get.put(LoginController());
  String selectedLanguage = 'en';

  @override
  void initState() {
    super.initState();
    urlController.text = "102.219.227.2:8027";
    // urlController.text = "demo7.ababeel.ly";
    checkConnectivity(context);
    _loadData();
    loadGetxData();
  }

  @override
  void dispose() {
    loginController.dispose();
    // googleSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HeightWidth(context);
    final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return UpgradeAlert(
      upgrader: Upgrader(durationUntilAlertAgain: Duration(hours: 12)),
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) {
            return;
          }
          await exitDialog(context);
        },
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kPrimaryTealDark, kPrimaryTealLight],
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 16,
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // زر تغيير اللغة أعلى يمين
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CommonButtonIcon(
                                  height: 44,
                                  width: 44,
                                  onPress: () {
                                    _pickLanguage(context);
                                  },
                                  color: Colors.white.withOpacity(0.95),
                                  icon: CupertinoIcons.globe,
                                  iconColor: kPrimaryTealLight,
                                  shadowColor: Colors.black12,
                                ),
                              ],
                            ),
                            SizedBox(height: h * 0.03),

                            // اللوجو + الاسم في المنتصف
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ClipRRect(
                                  child:
                                      Image(
                                            height: 180,
                                            width: 180,
                                            image: AssetImage(
                                              "assets/Azzakah.png",
                                            ),
                                            fit: BoxFit.contain,
                                          )
                                          .animate()
                                          .fadeIn(
                                            delay: 150.ms,
                                            duration: 700.ms,
                                          )
                                          .scale(
                                            begin: const Offset(0.9, 0.9),
                                            end: const Offset(1, 1),
                                            duration: 400.ms,
                                          ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CommonText(
                                      text: "Employee",
                                      weight: FontWeight.w300,
                                      fontSize: 16,
                                      color: kAccentText,
                                    ),
                                    CommonText(
                                      text: " HUB",
                                      weight: FontWeight.w600,
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            SizedBox(height: h * 0.04),

                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 1),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                border: Border.all(
                                  color: kAccentText, // 0xFFB2A58C
                                  width: 4,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.18),
                                    blurRadius: 20,
                                    offset: const Offset(0, 10),
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(26),
                                child: Container(
                                  color: Colors
                                      .white, // 🔹 جعل الخلفية البيضاء للتوب بالكامل
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // الشريط العلوي
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              kPrimaryTealDark,
                                              kPrimaryTealLight,
                                            ],
                                          ),
                                        ),
                                      ),

                                      // 🔹 المساحة العلوية صارت بيضاء وثابتة
                                      const SizedBox(height: 20),

                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 18,
                                        ),
                                        child: Form(
                                          key: _formkey,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              // عنوان تسجيل الدخول
                                              Align(
                                                alignment:
                                                    selectedLanguage == 'ar' ||
                                                        selectedLanguage == 'ur'
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Directionality(
                                                  textDirection:
                                                      (selectedLanguage ==
                                                              'ar' ||
                                                          selectedLanguage ==
                                                              'ur')
                                                      ? TextDirection.rtl
                                                      : TextDirection.ltr,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      CommonText(
                                                        text: 'Login!'.tr,
                                                        fontSize: 26,
                                                        weight: FontWeight.w600,
                                                        color: kPrimaryTealDark,
                                                      ),
                                                      const SizedBox(height: 4),
                                                      CommonText(
                                                        text: 'enterERPCred'.tr,
                                                        fontSize: 14,
                                                        weight: FontWeight.w300,
                                                        color: kAccentText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: h * 0.02),

                                              // حقل URL ثابت
                                              TextField(
                                                controller: urlController,
                                                readOnly: true,
                                                enableInteractiveSelection:
                                                    false,
                                                decoration: InputDecoration(
                                                  labelText: "URL",
                                                  prefixIcon: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      const SizedBox(width: 10),
                                                      Icon(
                                                        Icons.language_outlined,
                                                        color:
                                                            kPrimaryTealLight,
                                                      ),
                                                      const SizedBox(width: 4),
                                                      Text(
                                                        "http://",
                                                        style: TextStyle(
                                                          color:
                                                              kPrimaryTealDark,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  filled: true,
                                                  fillColor:
                                                      Colors.grey.shade200,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              18,
                                                            ),
                                                        borderSide: BorderSide(
                                                          width: 0.7,
                                                          color: kAccentText
                                                              .withOpacity(0.6),
                                                        ),
                                                      ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                              Radius.circular(
                                                                18,
                                                              ),
                                                            ),
                                                        borderSide: BorderSide(
                                                          width: 1.6,
                                                          color:
                                                              kPrimaryTealLight,
                                                        ),
                                                      ),
                                                ),
                                              ),

                                              const SizedBox(height: 12),

                                              // Username + Password
                                              LoginTextField(
                                                myController:
                                                    usernameController,
                                                isPass: false,
                                              ),
                                              const SizedBox(height: 12),
                                              LoginTextField(
                                                myController: passController,
                                                isPass: true,
                                              ),
                                              const SizedBox(height: 6),

                                              // Remember me
                                              Row(
                                                children: [
                                                  CommonText(
                                                    text: "rememberMe".tr,
                                                    color: kAccentText
                                                        .withOpacity(0.9),
                                                  ),
                                                  const Spacer(),
                                                  Switch(
                                                    activeTrackColor:
                                                        kAccentText,
                                                    value: rememberMe,
                                                    onChanged: (value) {
                                                      setState(
                                                        () =>
                                                            rememberMe = value,
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),

                                              SizedBox(height: h * 0.01),

                                              // 🔹 الأزرار في منتصف الشاشة تمامًا
                                              Center(
                                                child: Column(
                                                  children: [
                                                    CommonButton(
                                                      text: "login".tr,
                                                      onPress: () {
                                                        if (_formkey
                                                            .currentState!
                                                            .validate()) {
                                                          checkConnectivity(
                                                            context,
                                                          );
                                                          loginController.fetchLogin(
                                                            "http",
                                                            "102.219.227.2:8027/",
                                                            usernameController
                                                                .text
                                                                .trim(),
                                                            passController.text,
                                                          );
                                                        }
                                                      },
                                                    ),
                                                    const SizedBox(height: 6),
                                                    // CommonOutlineButton(
                                                    //   outlineColor:
                                                    //       kPrimaryTealDark,
                                                    //   textColor:
                                                    //       kPrimaryTealDark,
                                                    //   text: "demo".tr,
                                                    //   onPress: () {
                                                    //     checkConnectivity(
                                                    //         context);
                                                    //     loginController
                                                    //         .fetchLogin(
                                                    //       "https",
                                                    //       "demo.codessoft.com",
                                                    //       "testemployee@codessoft.com",
                                                    //       "Abc@123",
                                                    //     );
                                                    //   },
                                                    // ),
                                                  ],
                                                ),
                                              ),

                                              const SizedBox(height: 14),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showFloatingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: const [
              BoxShadow(blurRadius: 10, color: Colors.black26, spreadRadius: 5),
            ],
          ),
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: Material(
            color: white,
            child: Wrap(
              children: [
                CommonText(
                  text: "selectProtocol".tr,
                  weight: FontWeight.w500,
                  fontSize: 18,
                  color: kPrimaryTealDark,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.globe,
                    color: kPrimaryTealLight,
                  ),
                  title: const Text('http'),
                  onTap: () {
                    setState(() {
                      selectedProtocol = 'http';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.globe,
                    color: kPrimaryTealLight,
                  ),
                  title: const Text('https'),
                  onTap: () {
                    setState(() {
                      selectedProtocol = 'https';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  final List<Map<String, dynamic>> urlList = [
    // الآن غير مستخدمة فعليًا، تقدر تمسحها لو حاب
  ];

  Future<void> apiCall() async {
    // googleSheetController.fetchSheet();
  }

  Future<void> loadGetxData() async {
    await dataController.loadMyData();
    await dataController.getCurrentDate();
    await dataController.getCurrentTime();
    await apiCall();
    await setArgs();
  }

  Future<void> setArgs() async {
    setState(() {
      selectedLanguage = dataController.langCode.value;
    });
  }

  // ignore: unused_element
  void _launchURL(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching $url: $e');
    }
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonData = prefs.getString('urlData');
    if (jsonData != null) {
      setState(() {
        urlList.clear();
        urlList.addAll(List<Map<String, dynamic>>.from(json.decode(jsonData)));
      });
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('urlData', json.encode(urlList));
  }

  void addUrl() {
    String newUrl = urlController.text;
    String newUsername = usernameController.text;
    String newPassword = passController.text;
    String newProtocol = selectedProtocol;

    int existingUrlIndex = urlList.indexWhere(
      (element) => element['url'] == newUrl,
    );
    bool urlExists = existingUrlIndex != -1;

    if (urlExists) {
      urlList[existingUrlIndex]['username'] = newUsername;
      urlList[existingUrlIndex]['password'] = newPassword;
      urlList[existingUrlIndex]['protocol'] = newProtocol;
    } else {
      urlList.add({
        'url': newUrl,
        'username': newUsername,
        'password': newPassword,
        'protocol': newProtocol,
      });
    }

    _saveData();
  }

  //// Bottomsheet Picker //
  //////////////////////////////////////////////////////

  void _pickLanguage(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showModalBottomSheet(
      backgroundColor: Colors.grey.shade200,
      showDragHandle: true,
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Wrap(
              children: [
                Column(
                  children: [
                    const SizedBox(height: 10),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: langList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Material(
                              color: transparent,
                              child: ListTile(
                                onTap: () async {
                                  var locale = Locale(
                                    langList[index]["code"],
                                    langList[index]["country"],
                                  );
                                  Get.updateLocale(locale);
                                  selectedLanguage = langList[index]["code"];
                                  await prefs.setString(
                                    'langCode',
                                    langList[index]["code"],
                                  );
                                  await prefs.setString(
                                    'langCountry',
                                    langList[index]["country"],
                                  );
                                  Navigator.of(context).pop();
                                },
                                leading: Image(
                                  image: AssetImage(langList[index]["image"]),
                                  height: 25,
                                ),
                                title: CommonText(
                                  text: langList[index]["name"],
                                  weight: FontWeight.w500,
                                  color: kPrimaryTealDark,
                                ),
                                trailing: Checkbox(
                                  activeColor: kPrimaryTealDark,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5),
                                    ),
                                  ),
                                  side: BorderSide(color: grey, width: 0.5),
                                  value:
                                      selectedLanguage ==
                                      langList[index]["code"],
                                  onChanged: (bool? value) async {
                                    await prefs.setString(
                                      'langCode',
                                      langList[index]["code"],
                                    );
                                    await prefs.setString(
                                      'langCountry',
                                      langList[index]["country"],
                                    );
                                    setState(() {
                                      var locale = Locale(
                                        langList[index]["code"],
                                        langList[index]["country"],
                                      );
                                      Get.updateLocale(locale);
                                      selectedLanguage =
                                          langList[index]["code"];
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                              ),
                            ),
                            const Divider(color: Colors.black12),
                          ],
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
