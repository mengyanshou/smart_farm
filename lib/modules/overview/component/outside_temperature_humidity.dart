import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/candy_colors.dart';
import 'package:smart_farm/config/dimens.dart';
import 'package:smart_farm/config/svg.dart';
import 'package:smart_farm/modules/overview/controllers/message_controller.dart';

/// 室外空气温湿度
class OutsideTH extends GetView<MessageController> {
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
            '室外空气温湿度',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Dimens.font_sp18,
            ),
          ),
          SizedBox(
            height: Dimens.gap_dp8,
          ),
          SvgPicture.asset(
            SvgImages.temperatureHumidity,
            width: Dimens.gap_dp40,
            height: Dimens.gap_dp40,
            color: CandyColors.candyBlue,
          ),
          SizedBox(
            height: 8,
          ),
          Obx(() {
            return Text(
              '${controller.airTemp}/${controller.airHum}',
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
