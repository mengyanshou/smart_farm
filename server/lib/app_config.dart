import 'package:server/server.dart';

class AppConfig extends Configuration {
  AppConfig(String path) : super.fromFile(File(path));
  int port;
//new
  DatabaseConfiguration database;
//new
}
