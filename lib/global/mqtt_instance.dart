import 'package:mqtt_client/mqtt_client.dart';
import 'package:typed_data/typed_buffers.dart';

class Mqtt {
  factory Mqtt() => _getInstance();
  Mqtt._internal() {
    Mqtt._();
  }
  String server = 'broker.emqx.io';
  int port = 1883;
  String clientIdentifier = 'd7016608e17b4190a20e60450ac8dafa';
  // 测试
  String subTopic = 'nightmare';
  String publishTopic = 'nightmare';
  MqttQos qos = MqttQos.atLeastOnce;
  MqttClient mqttClient;
  static Mqtt _instance;

  Mqtt._() {
    mqttClient = MqttClient.withPort(server, clientIdentifier, port);
    mqttClient.logging(on: true);

    ///连接成功回调
    mqttClient.onConnected = _onConnected;

    ///连接断开回调
    mqttClient.onDisconnected = _onDisconnected();

    ///订阅成功回调
    mqttClient.onSubscribed = _onSubscribed;

    ///订阅失败回调
    mqttClient.onSubscribeFail = _onSubscribeFail;
  }
  static Mqtt get instance => _getInstance();

  static Mqtt _getInstance() {
    _instance ??= Mqtt._internal();
    return _instance;
  }

  ///连接
  connect() {
    mqttClient.connect();
    _log("connecting");
  }

  ///断开连接
  disconnect() {
    mqttClient.disconnect();
    _log("disconnect");
  }

  ///发布消息
  publishMessage(String msg) {
    ///int数组
    Uint8Buffer uint8buffer = Uint8Buffer();

    ///字符串转成int数组 (dart中没有byte) 类似于java的String.getBytes?
    var codeUnits = msg.codeUnits;
    //uint8buffer.add()
    uint8buffer.addAll(codeUnits);
    mqttClient.publishMessage(publishTopic, qos, uint8buffer);
  }

  ///消息监听
  _onData(List<MqttReceivedMessage<MqttMessage>> data) {
    Uint8Buffer uint8buffer = Uint8Buffer();
    var messageStream = MqttByteBuffer(uint8buffer);
    data.forEach((MqttReceivedMessage<MqttMessage> m) {
      ///将数据写入到messageStream数组中
      m.payload.writeTo(messageStream);

      ///打印出来
      print(uint8buffer.toString());
    });
  }

  _onConnected() {
    _log("_onConnected");

    ///连接成功的时候订阅消息
    mqttClient.subscribe(subTopic, qos);
  }

  _onDisconnected() {
    _log("_onDisconnect");
  }

  _onSubscribed(String topic) {
    _log("_onSubscribed");

    ///在订阅成功的时候注册消息监听
    mqttClient.updates.listen(_onData);
  }

  _onSubscribeFail(String topic) {
    _log("_onSubscribeFail");
  }

  _log(String msg) {
    print("MQTT-->$msg");
  }
}
