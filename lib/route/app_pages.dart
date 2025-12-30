import 'package:get/get.dart';
import 'package:pos_app/app/auth/view/login_screen.dart';
import 'package:pos_app/app/settings/binding/settings_binding.dart';
import 'package:pos_app/app/pos/view/pos_screen.dart';
import 'package:pos_app/app/pos/bindings/pos_binding.dart';
import 'package:pos_app/route/app_routes.dart';

import '../app/auth/view/splash_screen.dart';
import '../app/dashboard/view/dashboard.dart';
import '../app/customer/view/customer_screen.dart';
import '../app/customer/bindings/customer_binding.dart';
import '../app/settings/view/settings_screen.dart';

class AppPages {
  static const INITIAL = AppRoutes.SPLASH;
  static final routes = [
    GetPage(name: AppRoutes.SPLASH, page: () => SplashScreen()),
    GetPage(name: AppRoutes.LOGIN, page: () => LoginScreen()),
    GetPage(name: AppRoutes.HOME, page: () => DashboardScreen()),
    GetPage(
      name: AppRoutes.CUSTOMERS,
      page: () => CustomerScreen(),
      binding: CustomerBinding(),
    ),
    GetPage(
      name: AppRoutes.SETTINGS,
      page: () => SettingsScreen(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: AppRoutes.POS,
      page: () => PosScreen(),
      binding: PosBinding(),
    ),
  ];
}
