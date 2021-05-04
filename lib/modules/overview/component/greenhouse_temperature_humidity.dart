import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/candy_colors.dart';
import 'package:smart_farm/config/dimens.dart';
import 'package:smart_farm/config/svg.dart';
import 'package:smart_farm/modules/overview/controllers/message_controller.dart';

class GreenHouseTH extends GetView<MessageController> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 4.0,
        vertical: Dimens.gap_dp4,
      ),
      child: Column(
        children: [
          Text(
            '大棚空气温湿度',
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
            color: CandyColors.candyCyan,
          ),
          SizedBox(
            height: 8,
          ),
          Obx(() {
            return Text(
              '${controller.insideTemp}/${controller.insideHum}',
              style: TextStyle(
                color: AppColors.accent,
                fontWeight: FontWeight.bold,
                fontSize: Dimens.font_sp18,
              ),
            );
          }),
        ],
      ),
    );
  }
}
