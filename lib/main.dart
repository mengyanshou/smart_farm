import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smart_farm/global/widget/custom_card.dart';

import 'global/mqtt_instance.dart';
import 'page/control_page.dart';
import 'page/device_detail_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SmartFarm(),
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
    Mqtt();
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
                      for (int index in List.generate(10, (index) => null))
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
                                        '空气温湿度',
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
