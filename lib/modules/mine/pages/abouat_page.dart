import 'package:flutter/material.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/config.dart';
import 'package:smart_farm/config/dimens.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/icon_app.png',
                  width: Dimens.setWidth(120),
                  height: Dimens.setWidth(120),
                ),
                Text(
                  '智慧农场',
                  style: TextStyle(
                    color: AppColors.fontTitle,
                    fontSize: Dimens.setSp(30),
                  ),
                ),
                SizedBox(
                  height: Dimens.gap_dp4,
                ),
                Text(
                  'Version : ${Config.version}',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Dimens.font_sp16,
                  ),
                ),
                SizedBox(
                  height: Dimens.setSp(200),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment(0, 0.5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                '请注意这目前是一个测试版，是由 Flutter 框架开发的智慧农场客户端，优先完善数据展示，数据详情，设备控制功能。',
                style: TextStyle(
                  color: AppColors.fontDetail,
                  fontSize: Dimens.font_sp16,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment(0, 1),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Designed by Nightmare',
                style: TextStyle(
                  color: AppColors.fontDetail,
                  fontSize: Dimens.font_sp16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
