import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/dimens.dart';
import 'package:smart_farm/global/mqtt_instance.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('设置'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SettingTitle(
              title: '开发者设置',
            ),
            Text(
              '  整个数据模拟操作同样可以应用到web端',
              style: TextStyle(
                color: AppColors.fontDetail,
              ),
            ),
            SettingItem(
              title: '室外空气温湿度数据模拟',
              onTap: () {
                Mqtt().publishMessageToSubTopic(json.encode({
                  "messageclass": "sensorData",
                  "deviceID": "2012",
                  "typeID": "101",
                  "temperature": [6.54, 3.23, 4.56, 5.48][Random().nextInt(4)],
                  "humidity": [90.35, 89.34, 78.96, 90.56][Random().nextInt(4)],
                  "voletage": 3.757,
                  "timestamp": "2020-12-12 08:27:51"
                }));
              },
            ),
            SettingItem(
              title: '大棚空气温湿度数据模拟',
              onTap: () {
                Mqtt().publishMessageToSubTopic(json.encode({
                  "messageclass": "sensorData",
                  "deviceID": "2010",
                  "typeID": "101",
                  "temperature": [6.54, 3.23, 4.56, 5.48][Random().nextInt(4)],
                  "humidity": [90.35, 89.34, 78.96, 90.56][Random().nextInt(4)],
                  "voletage": 3.757,
                  "timestamp": "2020-12-12 08:27:51"
                }));
              },
            ),
            SettingItem(
              title: '雨量',
              onTap: () {
                Mqtt().publishMessageToSubTopic(json.encode({
                  "messageclass": "sensorData",
                  "deviceID": "7010",
                  "typeID": "108",
                  "rainsnow": [
                    0.0,
                    1.2,
                    1.3,
                    1.4,
                    1.5,
                    1.6
                  ][Random().nextInt(6)],
                  "voletage": 3.72,
                  "timestamp": "2020-12-12 08:47:47"
                }));
              },
            ),
            SettingItem(
              title: 'PM2.5数据模拟',
              onTap: () {
                Mqtt().publishMessageToSubTopic(json.encode({
                  "messageclass": "sensorData",
                  "deviceID": "8011",
                  "typeID": "103",
                  "pm2.5": 6.44,
                  "voletage": 3.779,
                  "timestamp": "2020-12-12 08:51:34"
                }));
              },
            ),
            SettingItem(
              title: '风速数据模拟',
              onTap: () {
                Mqtt().publishMessageToSubTopic(json.encode({
                  "messageclass": "sensorData",
                  "deviceID": "3010",
                  "typeID": "106",
                  "windspeed": 0.52,
                  "voletage": 3.689,
                  "timestamp": "2020-12-12 08:57:00"
                }));
              },
            ),
            SettingItem(
              title: '风向数据模拟',
              onTap: () {
                // TODO
              },
            ),
            SettingItem(
              title: '光照强度数据模拟',
              onTap: () {
                // TODO
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatefulWidget {
  const SettingItem({Key key, this.title, this.onTap, this.subTitle})
      : super(key: key);

  final String title;
  final String subTitle;
  final void Function() onTap;
  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
        ),
        child: SizedBox(
          height: 68,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.headline6.copyWith(
                        // color: Theme.of(context).colorScheme.primaryVariant,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Builder(builder: (_) {
                  String content = '空';
                  if (widget.subTitle != null && widget.subTitle.isNotEmpty) {
                    content = widget.subTitle;
                  }
                  return Text(
                    content,
                    style: Theme.of(context).textTheme.subtitle1.copyWith(
                          color: Colors.black54,
                          fontWeight: FontWeight.w400,
                        ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingTitle extends StatefulWidget {
  const SettingTitle({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingTitleState createState() => _SettingTitleState();
}

class _SettingTitleState extends State<SettingTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 10,
      ),
      child: Text(
        widget.title,
        style: Theme.of(context).textTheme.headline6.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
