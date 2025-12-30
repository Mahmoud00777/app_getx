// lib/app/dashboard/view/dashboard.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:pos_app/components/common_appbar.dart';
import '../../../route/app_routes.dart';
import '../../../utils/constants.dart';
import '../../../utils/controllers/data_controller.dart';

class DashboardScreen extends StatelessWidget {
  final DataController dataController = Get.find<DataController>();

  DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: CustomAppbarClass(
          title: 'posSystem'.tr,
          action: IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Get.dialog(
                AlertDialog(
                  title: Text('confirmation'.tr),
                  content: Text('areYouSureYouWantToLogout'.tr),
                  actions:[
                    TextButton(
                        onPressed: () => Get.back(),
                        child: Text('cancel'.tr),
                      ),
                      TextButton(
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed(AppRoutes.LOGIN);
                      },
                      child: Text('logout'.tr),
                    ),
                  ]
                ),

              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Obx(
                () => _buildWelcomeSection(),
              ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.2, end: 0),

              SizedBox(height: 24),

              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    _buildMenuCard(
                      icon: Icons.point_of_sale,
                      title: 'pos'.tr,
                      subtitle: 'pos'.tr,
                      color: primaryAppColor,
                      route: AppRoutes.POS,
                      delay: 100,
                    ),
                    // _buildMenuCard(
                    //   icon: Icons.inventory_2,
                    //   title: 'products'.tr,
                    //   subtitle: 'products'.tr,
                    //   color: Colors.blue,
                    //   route: AppRoutes.PRODUCTS,
                    //   delay: 200,
                    // ),
                    // _buildMenuCard(
                    //   icon: Icons.receipt_long,
                    //   title: 'orders'.tr,
                    //   subtitle: 'orders'.tr,
                    //   color: Colors.green,
                    //   route: AppRoutes.ORDERS,
                    //   delay: 300,
                    // ),
                    _buildMenuCard(
                      icon: Icons.people,
                      title: 'customers'.tr,
                      subtitle: 'customers'.tr,
                      color: Colors.orange,
                      route: AppRoutes.CUSTOMERS,
                      delay: 400,
                    ),
                    // _buildMenuCard(
                    //   icon: Icons.warehouse,
                    //   title: 'inventory'.tr,
                    //   subtitle: 'inventory'.tr,
                    //   color: Colors.purple,
                    //   route: AppRoutes.INVENTORY,
                    //   delay: 500,
                    // ),
                    // _buildMenuCard(
                    //   icon: Icons.assessment,
                    //   title: 'reports'.tr,
                    //   subtitle: 'reports'.tr,
                    //   color: Colors.teal,
                    //   route: AppRoutes.REPORTS,
                    //   delay: 600,
                    // ),
                    _buildMenuCard(
                      icon: Icons.settings,
                      title: 'settings'.tr,
                      subtitle: 'settings'.tr,
                      color: Colors.grey,
                      route: AppRoutes.SETTINGS,
                      delay: 700,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryAppColor, secondaryAppColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: primaryAppColor.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'welcome'.tr,
                  style: TextStyle(
                    color: white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  dataController.mySavedFullName.value.isNotEmpty
                      ? dataController.mySavedFullName.value
                      : dataController.mySavedName.value,
                  style: TextStyle(color: white.withOpacity(0.9), fontSize: 18),
                ),
                SizedBox(height: 8),
                Text(
                  dataController.myCurrentDate.value,
                  style: TextStyle(color: white.withOpacity(0.8), fontSize: 14),
                ),
              ],
            ),
          ),
          Icon(Icons.person, color: white, size: 48),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required String route,
    int delay = 0,
  }) {
    return Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () {
              Get.toNamed(route);
            },
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 1),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, size: 32, color: color),
                  ),
                  SizedBox(height: 12),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(fontSize: 12, color: grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(delay: delay.ms, duration: 300.ms)
        .scale(delay: delay.ms, begin: Offset(0.8, 0.8), duration: 300.ms);
  }
}
