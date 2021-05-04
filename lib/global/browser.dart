import 'dart:html';

import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_client.dart';

void alarm([String text]) {
  window.alert(text ?? '');
  // stderr.writeln(text ?? message);
}

String get message => 'Hello World from the WEB!';

MqttClient setup(String serverAddress, String uniqueID, int port) {
  return MqttBrowserClient.withPort(serverAddress, uniqueID, port);
}
