import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/candy_colors.dart';
import 'package:smart_farm/config/svg.dart';
import 'package:smart_farm/modules/home/pages/device_detail_page.dart';
import 'package:smart_farm/modules/overview/component/greenhouse_temperature_humidity.dart';
import 'package:smart_farm/modules/overview/component/outside_soil_th.dart';
import 'package:smart_farm/modules/overview/component/outside_temperature_humidity.dart';
import 'package:smart_farm/modules/overview/controllers/message_controller.dart';

class OverviewPage extends StatefulWidget {
  @override
  _OverviewPageState createState() => _OverviewPageState();
}

class _OverviewPageState extends State<OverviewPage> {
  MessageController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // 不让这个box会有一个返回的按钮，没必要
        leading: SizedBox(),
        centerTitle: true,
        title: Text('概览'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: OpenContainerItem(
                  child: OutsideTH(),
                ),
              ),
              Expanded(
                child: OpenContainerItem(
                  child: GreenHouseTH(),
                ),
              ),
            ],
          ),
          OpenContainerItem(
            child: OutsideSoilTH(),
          ),
          OpenContainerItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Text(
                    '大棚土壤温湿度',
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
                    width: Dimens.gap_dp40,
                    height: Dimens.gap_dp40,
                    color: CandyColors.candyPink,
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
          OpenContainerItem(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 4.0,
                vertical: 8.0,
              ),
              child: Column(
                children: [
                  Text(
                    '大棚土壤酸碱度',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SvgPicture.asset(
                    'assets/icon/酸碱度.svg',
                    width: Dimens.gap_dp40,
                    height: Dimens.gap_dp40,
                    color: CandyColors.indigo,
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
          Row(
            children: [
              Expanded(
                child: OpenContainerItem(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '降雨量',
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
                          width: Dimens.gap_dp40,
                          height: Dimens.gap_dp40,
                          color: CandyColors.candyPurpleAccent,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return Text(
                            '${controller.rainfall}',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.font_sp18,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: OpenContainerItem(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'PM2.5',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          'assets/icon/PM2.5.svg',
                          width: 50,
                          height: 50,
                          // color: Theme.of(context).accentColor,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return Text(
                            '${controller.pm25}',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.font_sp18,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: OpenContainerItem(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '风速',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          'assets/icon/风速.svg',
                          width: 50,
                          height: 50,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Obx(() {
                          return Text(
                            '${controller.windSpeed}',
                            style: TextStyle(
                              color: AppColors.accent,
                              fontWeight: FontWeight.bold,
                              fontSize: Dimens.font_sp18,
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: OpenContainerItem(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '风向',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          'assets/icon/风向.svg',
                          width: 50,
                          height: 50,
                          // color: Theme.of(context).accentColor,
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
              ),
              Expanded(
                child: OpenContainerItem(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 8.0,
                    ),
                    child: Column(
                      children: [
                        Text(
                          '光照强度',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        SvgPicture.asset(
                          'assets/icon/Light-intensity.svg',
                          width: Dimens.gap_dp40,
                          height: Dimens.gap_dp40,
                          color: CandyColors.deepPurple,
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
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class OpenContainerItem extends StatelessWidget {
  const OpenContainerItem({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      useRootNavigator: true,
      tappable: true,
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, _) {
        return DeviceDetailPage();
      },
      transitionDuration: const Duration(milliseconds: 500),
      openColor: Colors.transparent,
      closedElevation: 0.0,
      openElevation: 0.0,
      closedColor: Colors.transparent,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return NiCardButton(
          margin: EdgeInsets.symmetric(
            horizontal: Dimens.gap_dp8,
            vertical: Dimens.gap_dp6,
          ),
          onTap: () {
            openContainer();
          },
          spreadRadius: 0,
          child: child,
        );
      },
    );
  }
}
