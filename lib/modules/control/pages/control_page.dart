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
          NiCardButton(
            onTap: () {},
            child: SizedBox(
              height: Dimens.setWidth(100),
              width: Dimens.setWidth(200),
              child: Text(
                '喷淋设备',
                style: TextStyle(
                  color: AppColors.fontTitle,
                  fontSize: Dimens.font_sp20,
                ),
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              '请注意所有的控制都是真实生效的哦~',
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
