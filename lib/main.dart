import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:signale/signale.dart';
import 'global/mqtt_instance.dart';
import 'modules/control/pages/control_page.dart';
import 'modules/login/pages/login_page.dart';
import 'modules/navigator_page.dart';
import 'modules/overview/pages/overview_page.dart';
import 'routes/app_pages.dart';
import 'themes/default_theme_data.dart';

void main() {
  runApp(NiToastNew(
    child: MyApp(),
  ));
  Mqtt.instance;
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarDividerColor: Colors.transparent,
  ));
}

bool isMobilePhone() {
  return Platform.isAndroid || Platform.isIOS;
}

// 判断当前的设备是否是桌面设备
bool isDesktop() {
  return !isMobilePhone();
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (_, Orientation orientation) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          builder: (BuildContext context, Widget navigator) {
            print('builder');
            if (kIsWeb || isDesktop()) {
              ScreenUtil.init(
                context,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                allowFontScaling: false,
              );
            } else {
              if (orientation == Orientation.landscape) {
                ScreenUtil.init(
                  context,
                  width: 896,
                  height: 414,
                  allowFontScaling: false,
                );
              } else {
                ScreenUtil.init(
                  context,
                  width: 414,
                  height: 896,
                  allowFontScaling: false,
                );
              }
            }
            // // config中的Dimens获取不到ScreenUtil，因为ScreenUtil中用到的MediaQuery只有在
            // // WidgetApp或者MaterialApp中才能获取到，所以在build方法中处理主题
            final bool isDarkTheme =
                Theme.of(context).brightness == Brightness.dark;
            final ThemeData theme = isDarkTheme
                ? DefaultThemeData.dark()
                : DefaultThemeData.light();
            return Theme(
              data: theme,
              child: navigator,
            );
          },
        );
      },
    );
  }
}
