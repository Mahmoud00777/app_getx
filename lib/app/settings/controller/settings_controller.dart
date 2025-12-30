import 'dart:ui';

import 'package:get/get.dart';
import 'package:pos_app/utils/constants.dart' as Colors;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/constants.dart';
import '../../../utils/controllers/data_controller.dart';

class SettingsController extends GetxController {
  final DataController dataController = Get.find<DataController>();
  final RxString selectedLanguage = 'ar'.obs;
  final RxString selectedThemeColorCode = 'green'.obs;
  final List<Map<String, dynamic>> themeColors = [
    {'name': 'أخضر', 'color': Color(0xFF004F53), 'code': 'green'},
    {'name': 'أزرق', 'color': Colors.blue, 'code': 'blue'},
    {'name': 'بنفسجي', 'color': Colors.grey, 'code': 'grey'},
    {'name': 'برتقالي', 'color': Colors.orange, 'code': 'orange'},
    {'name': 'أحمر', 'color': Colors.red, 'code': 'red'},
    {'name': 'تركواز', 'color': Colors.green, 'code': 'green'},
  ];

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    final savedLang = prefs.getString('langCode') ?? 'ar';
    selectedLanguage.value = savedLang;

    final savedTheme = prefs.getString('themeColor') ?? 'green';
    selectedThemeColorCode.value = savedTheme;
  }

  Future<void> changeLanguage(String langCode, String country) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('langCode', langCode);
      await prefs.setString('langCountry', country);

      selectedLanguage.value = langCode;

      final locale = Locale(langCode, country);
      Get.updateLocale(locale);

      dataController.langCode.value = langCode;

      Get.snackbar(
        'success'.tr,
        'languageChanged'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToChangeLanguage'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> changeThemeColor(Color color, String code) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('themeColor', code);

      selectedThemeColorCode.value = code;

      primaryAppColor = color;
      secondaryAppColor = color.withOpacity(0.7);

      Get.snackbar(
        'success'.tr,
        'themeChanged'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.forceAppUpdate();
    } catch (e) {
      Get.snackbar(
        'error'.tr,
        'failedToChangeTheme'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
