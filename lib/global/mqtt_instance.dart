import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:global_repository/global_repository.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:signale/signale.dart';
import 'package:typed_data/typed_buffers.dart';

String _randomBit(int len) {
  const String scope = '123456789abcdefghijklmnopqrstuvwxyz'; //首位
  String result = '';
  for (int i = 0; i < len; i++) {
    result = result + scope[Random().nextInt(scope.length)];
  }
  return result;
}

/// 这是Mqtt的一个单例，跟MQTT相关的东西都会在这个类里面
class Mqtt {
  factory Mqtt() => _getInstance();
  Mqtt._internal() {
    // print(Random().nextInt(99).toRadixString(16));
    Log.i('clientIdentifier -> $clientIdentifier');
    if (kIsWeb) {
      mqttClient = MqttBrowserClient.withPort(
        'ws://47.108.198.192',
        clientIdentifier,
        8083,
      );
    } else {
      mqttClient = MqttServerClient.withPort(server, clientIdentifier, port);
    }
    // mqttClient.connect();
    mqttClient.logging(on: false);
    mqttClient.onConnected = onConnected;
    mqttClient.onDisconnected = onDisconnected;
    mqttClient.onUnsubscribed = onUnsubscribed;
    mqttClient.onSubscribed = onSubscribed;
    mqttClient.onSubscribeFail = onSubscribeFail;
    mqttClient.pongCallback = pong;
    messageStream = streamController.stream.asBroadcastStream();
    connect();
  }

  Future<void> connect() async {
    // final connMessage = MqttConnectMessage()
    //     .keepAliveFor(60)
    //     .startClean()
    //     .withWillQos(MqttQos.atLeastOnce);
    // mqttClient.connectionMessage = connMessage;
    try {
      await mqttClient.connect();
    } catch (e) {
      print('Exception: $e');
      mqttClient.disconnect();
    }
    mqttClient.subscribe(subTopic, MqttQos.atLeastOnce);
    mqttClient.updates.listen(_onData);
  }

  String server = '47.108.198.192';
  int port = 1883;
  String clientIdentifier = _randomBit(18);
  // 测试
  String subTopic = 'nightmare/test';
  String publishTopic = 'nightmare/control/test';
  MqttQos qos = MqttQos.atLeastOnce;
  MqttClient mqttClient;
  static Mqtt _instance;

  static Mqtt get instance => _getInstance();

  static Mqtt _getInstance() {
    _instance ??= Mqtt._internal();
    return _instance;
  }

  Stream<Map<String, dynamic>> messageStream;

  StreamController<Map<String, dynamic>> streamController =
      StreamController<Map<String, dynamic>>(
    onListen: () {
      print('onListen');
    },
    onCancel: () {
      print('onCancel');
    },
  );

  ///发布消息
  void publishMessage(String msg) {
    ///int数组
    Uint8Buffer uint8buffer = Uint8Buffer();

    ///字符串转成int数组 (dart中没有byte) 类似于java的String.getBytes?
    var codeUnits = msg.codeUnits;
    //uint8buffer.add()
    uint8buffer.addAll(codeUnits);
    mqttClient.publishMessage(publishTopic, qos, uint8buffer);
  }

  /// 发布消息到已经鼎业的主题，主要用来模拟数据
  void publishMessageToSubTopic(String msg) {
    ///int数组
    final Uint8Buffer uint8buffer = Uint8Buffer();

    ///字符串转成int数组 (dart中没有byte) 类似于java的String.getBytes?
    final codeUnits = msg.codeUnits;
    //uint8buffer.add()
    uint8buffer.addAll(codeUnits);
    mqttClient.publishMessage(subTopic, qos, uint8buffer);
  }

  ///消息监听
  void _onData(List<MqttReceivedMessage<MqttMessage>> data) {
    for (final MqttReceivedMessage<MqttMessage> message in data) {
      final MqttPublishMessage recMess = message.payload as MqttPublishMessage;
      // final pt = MqttPublishPayload.bytesToStringAsString(
      //   recMess.payload.message,
      // );
      final String messageString = utf8.decode(recMess.payload.message);
      // showToast(messageString);
      // Log.e(messageString);
      final Map<String, dynamic> dataMap =
          json.decode(messageString) as Map<String, dynamic>;
      streamController.sink.add(dataMap);
      Log.w(dataMap);
    }
  }

// 连接成功
  void onConnected() {
    print('Connected');
  }

// 连接断开
  void onDisconnected() {
    print('Disconnected');
  }

// 订阅主题成功
  void onSubscribed(String topic) {
    print('Subscribed topic: $topic');
  }

// 订阅主题失败
  void onSubscribeFail(String topic) {
    print('Failed to subscribe $topic');
  }

// 成功取消订阅
  void onUnsubscribed(String topic) {
    print('Unsubscribed topic: $topic');
  }

// 收到 PING 响应
  void pong() {
    print('Ping response client callback invoked');
  }
}
