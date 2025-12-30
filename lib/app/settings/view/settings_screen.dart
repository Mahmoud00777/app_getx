
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../components/common_appbar.dart';
import '../../../components/common_text.dart';
import '../../../utils/constants.dart';
import '../controller/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  final SettingsController controller = Get.put(SettingsController());

  SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(title: 'settings'.tr),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildSectionTitle('language'.tr),
          SizedBox(height: 12),
          _buildLanguageSection(),

          SizedBox(height: 32),

          _buildSectionTitle('themeColor'.tr),
          SizedBox(height: 12),
          _buildThemeColorSection(),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return CommonText(
      text: title,
      fontSize: 18,
      weight: FontWeight.bold,
      color: black,
    );
  }

  Widget _buildLanguageSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: langList.length,
        itemBuilder: (context, index) {
          final lang = langList[index];

          return Obx(() {
            final isSelected =
                controller.selectedLanguage.value == lang['code'];

            return Column(
              children: [
                ListTile(
                  leading: Image(
                    image: AssetImage(lang['image']),
                    height: 25,
                    width: 25,
                  ),
                  title: CommonText(text: lang['name'], fontSize: 16),
                  trailing: isSelected
                      ? Icon(Icons.check_circle, color: primaryAppColor)
                      : Icon(Icons.radio_button_unchecked, color: grey),
                  onTap: () {
                    controller.changeLanguage(lang['code'], lang['country']);
                  },
                ),
                if (index < langList.length - 1) Divider(height: 1),
              ],
            );
          });
        },
      ),
    );
  }

  Widget _buildThemeColorSection() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: controller.themeColors.length,
          itemBuilder: (context, index) {
            final theme = controller.themeColors[index];
            final color = theme['color'] as Color;
            final code = theme['code'] as String;

            return Obx(() {
              final isSelected =
                  controller.selectedThemeColorCode.value == code;

              return InkWell(
                onTap: () {
                  controller.changeThemeColor(color, code);
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.black : Colors.transparent,
                      width: isSelected ? 3 : 0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.3),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (isSelected)
                        Icon(Icons.check_circle, color: Colors.white, size: 24),
                      SizedBox(height: 8),
                      CommonText(
                        text: theme['name'],
                        fontSize: 14,
                        color: Colors.white,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              );
            });
          },
        ),
      ),
    );
  }
}
