import 'package:get/get.dart';
import 'package:smart_farm/bindings/home_binding.dart';
import 'package:smart_farm/modules/login/pages/login_page.dart';
import 'package:smart_farm/modules/mine/pages/setting_page.dart';
import 'package:smart_farm/modules/navigator_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => NavigationPage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.settingPage,
      page: () => SettingPage(),
    ),
  ];
}
