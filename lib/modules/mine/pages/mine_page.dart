import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/routes/app_pages.dart';

import 'abouat_page.dart';
import 'setting_page.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NiCardButton(
                onTap: () {},
                color: AppColors.accent,
                borderRadius: Dimens.gap_dp26,
                child: SizedBox(
                  height: Dimens.setWidth(100),
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              buildItem(
                title: '软件更新',
                onTap: () {
                  showToast('待开发');
                },
              ),
              buildItem(
                title: '关于软件',
                onTap: () {
                  Get.to(AboutPage(), preventDuplicates: false);
                  // showToast('待开发');
                },
              ),
              buildItem(
                title: '设置',
                onTap: () {
                  Get.toNamed(Routes.settingPage, preventDuplicates: false);
                  // showToast('待开发');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding buildItem({
    void Function() onTap,
    String title = '',
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimens.gap_dp8,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            child: SizedBox(
              height: Dimens.gap_dp60,
              width: MediaQuery.of(context).size.width,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.fontTitle,
                      fontSize: Dimens.font_sp18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
