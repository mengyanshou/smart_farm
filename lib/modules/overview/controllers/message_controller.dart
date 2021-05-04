import 'dart:async';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:signale/signale.dart';
import 'package:smart_farm/global/mqtt_instance.dart';

class DeviceType {
  // 空气温湿度传感器 air temperature humidity
  static const int airTH = 101;
  static const int rainfall = 108;
  static const int pm25 = 103;
  static const int windSpeed = 105;
}

/// 这是消息的控制器
class MessageController extends GetxController {
  StreamSubscription subscription;

  final airTemp = 0.0.obs;
  final airHum = 0.0.obs;

  final insideTemp = 0.0.obs;
  final insideHum = 0.0.obs;

  final rainfall = 0.0.obs;

  final pm25 = 0.0.obs;

  final windSpeed = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    Log.d('$this onInit');
    subscription = Mqtt.instance.messageStream.listen((
      Map<String, dynamic> event,
    ) {
      final int deviceType = int.tryParse(event['typeID'].toString());
      switch (deviceType) {
        case DeviceType.airTH:
          if (event['deviceID'] == '2012') {
            airTemp.value = double.tryParse(event['temperature'].toString());
            airHum.value = double.tryParse(event['humidity'].toString());
          } else if (event['deviceID'] == '2010') {
            insideTemp.value = double.tryParse(event['temperature'].toString());
            insideHum.value = double.tryParse(event['humidity'].toString());
          }
          break;
        case DeviceType.rainfall:
          rainfall.value = double.tryParse(event['rainsnow'].toString());
          break;
        case DeviceType.pm25:
          pm25.value = double.tryParse(event['pm2.5'].toString());
          break;
        case DeviceType.windSpeed:
          windSpeed.value = double.tryParse(event['windspeed'].toString());
          break;
        default:
      }
      // Log.d('$deviceType');
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    Log.d('$this dispose');
  }
}
