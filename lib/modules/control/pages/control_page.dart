import 'package:flutter/material.dart';
import 'package:global_repository/global_repository.dart';
import 'package:smart_farm/config/app_colors.dart';

class ControllPage extends StatefulWidget {
  const ControllPage({Key key, this.controller}) : super(key: key);

  final PageController controller;

  @override
  _ControllPageState createState() => _ControllPageState();
}

class _ControllPageState extends State<ControllPage> {
  bool enableSpray = false;
  bool enableFan = false;
  bool enableLight = false;
  bool enableRollfilm = false;
  bool enableSunshade = false;
  bool enableBirdscarer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: SizedBox(),
        title: Text(
          '设备控制',
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Wrap(
            spacing: Dimens.gap_dp16,
            children: [
              buildItem(
                color: const Color(0xff1196db),
                title: '喷淋设备',
                imageAssets: 'assets/images/spray.png',
                enable: enableSpray,
                onChanged: (value) {
                  enableSpray = value;
                  setState(() {});
                },
              ),
              buildItem(
                color: const Color(0xff36aa5f),
                title: '环流风机',
                enable: enableFan,
                imageAssets: 'assets/images/icon_fan.png',
                onChanged: (value) {
                  enableFan = value;
                  setState(() {});
                },
              ),
              buildItem(
                color: const Color(0xffebb652),
                title: '照明设备',
                imageAssets: 'assets/images/icon_lighting.png',
                enable: enableLight,
                onChanged: (value) {
                  enableLight = value;
                  setState(() {});
                },
              ),
              buildItem(
                color: const Color(0xffd4237b),
                title: '大棚卷膜',
                imageAssets: 'assets/images/icon_rollfilm.png',
                enable: enableRollfilm,
                onChanged: (value) {
                  enableRollfilm = value;
                  setState(() {});
                },
              ),
              buildItem(
                color: const Color(0xffdf6531),
                title: '遮阳设备',
                imageAssets: 'assets/images/icon_sunshade.png',
                enable: enableSunshade,
                onChanged: (value) {
                  enableSunshade = value;
                  setState(() {});
                },
              ),
              buildItem(
                color: const Color(0xff82529c),
                title: '驱鸟器',
                imageAssets: 'assets/images/icon_birdscarer.png',
                enable: enableBirdscarer,
                onChanged: (value) {
                  enableBirdscarer = value;
                  setState(() {});
                },
              ),
            ],
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '当前未接入正式主题，随便点',
              // '请注意所有的控制都是真实生效的哦~',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }

  NiCardButton buildItem({
    String title,
    String imageAssets,
    bool enable = false,
    Color color,
    void Function(bool value) onChanged,
  }) {
    return NiCardButton(
      borderRadius: Dimens.gap_dp16,
      onTap: () {
        if (!enable) {
          showToast('没生效喔~');
        }
        onChanged?.call(!enable);
      },
      child: Container(
        color: enable ? color : null,
        height: Dimens.setWidth(160),
        width: Dimens.setWidth(160),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imageAssets,
              color: enable ? Colors.white : color,
              width: Dimens.gap_dp48,
            ),
            SizedBox(
              height: Dimens.gap_dp8,
            ),
            Text(
              title ?? '',
              style: TextStyle(
                color: enable ? Colors.white : AppColors.fontTitle,
                fontSize: Dimens.font_sp20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
