import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/global/widget/custom_card.dart';

import 'global/mqtt_instance.dart';
import 'module/control/pages/control_page.dart';
import 'module/home/pages/device_detail_page.dart';
import 'module/login/pages/login_page.dart';
import 'themes/default_theme_data.dart';

void main() {
  runApp(MyApp());
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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      builder: (BuildContext context, Widget navigator) {
        if (kIsWeb || isDesktop()) {
          ScreenUtil.init(
            context,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
        // // config中的Dimens获取不到ScreenUtil，因为ScreenUtil中用到的MediaQuery只有在
        // // WidgetApp或者MaterialApp中才能获取到，所以在build方法中处理主题
        final bool isDarkTheme =
            Theme.of(context).brightness == Brightness.dark;
        final ThemeData theme =
            isDarkTheme ? DefaultThemeData.dark() : DefaultThemeData.light();
        return Theme(
          data: theme,
          child: navigator,
        );
      },
      home: LoginPage(),
    );
  }
}

class SmartFarm extends StatefulWidget {
  @override
  _SmartFarmState createState() => _SmartFarmState();
}

class _SmartFarmState extends State<SmartFarm> {
  PageController controller = PageController();
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    Mqtt mqtt = Mqtt();
    await Future<void>.delayed(Duration(milliseconds: 100));
    mqtt.connect();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller,
            children: [
              Stack(
                children: [
                  Wrap(
                    alignment: WrapAlignment.spaceAround,
                    runAlignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.end,
                    runSpacing: 10,
                    children: [
                      // Image.network(
                      //   'http://nightmare.fun/File/MToolkit/hong.jpg',
                      //   width: 64,
                      //   height: 64,
                      // ),
                      for (int index in List.generate(10, (index) => index))
                        OpenContainer(
                          useRootNavigator: true,
                          tappable: true,
                          transitionType: ContainerTransitionType.fade,
                          openBuilder: (BuildContext context, _) {
                            return DeviceDetailPage();
                          },
                          transitionDuration: const Duration(milliseconds: 500),
                          openColor: Colors.transparent,

                          // tappable: false,
                          closedElevation: 0.0,
                          openElevation: 0.0,
                          // openShape: ,
                          // closedShape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.all(
                          //     Radius.circular(_fabDimension / 2),
                          //   ),
                          // ),
                          closedColor: Colors.transparent,
                          closedBuilder: (BuildContext context,
                              VoidCallback openContainer) {
                            return NiCardButton(
                              onTap: () {
                                openContainer();
                              },
                              child: SizedBox(
                                width: 120,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 8.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        '空气温湿度${index}',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      SvgPicture.asset(
                                        'assets/icon/Temperature-humidity.svg',
                                        width: 50,
                                        height: 50,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'XX/XX',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey,
                                          // color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      tooltip: '点击进入控制页',
                      iconSize: 48,
                      onPressed: () {
                        controller.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.bounceOut,
                        );
                      },
                      icon: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
              ControllPage(
                controller: controller,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
