import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void alarm([String text]) {
  print(text ?? message);
}

String get message => 'Hello World from the VM!';

MqttClient setup(String serverAddress, String uniqueID, int port) {
  return MqttServerClient.withPort(serverAddress, uniqueID, port);
}
