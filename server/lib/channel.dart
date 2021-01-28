import 'package:server/login_controller.dart';

import 'app_config.dart';
import 'server.dart';
import 'token_controller.dart';
import 'user_controller.dart';
import 'model/user_info.dart';
import 'validate_controller.dart';

/// This type initializes an application.
///
/// Override methods in this class to set up routes and initialize services like
/// database connections. See http://aqueduct.io/docs/http/channel/.
class ServerChannel extends ApplicationChannel {
  ManagedContext context; //可通过该实例操作数据库

  @override
  Future prepare() async {
    logger.onRecord.listen(
        (rec) => print("$rec ${rec.error ?? ""} ${rec.stackTrace ?? ""}"));
    //执行初始化任务的方法
    final AppConfig _config = AppConfig(options.configurationFilePath);
    options.port = _config.port;
//new
    final dataModel = ManagedDataModel.fromCurrentMirrorSystem(); //描述应用程序的数据模型
    final psc = PostgreSQLPersistentStore.fromConnectionInfo(
        _config.database.username,
        _config.database.password,
        _config.database.host,
        _config.database.port,
        _config.database.databaseName); //管理与单个数据库的连接
    context = ManagedContext(dataModel, psc);
//new
  }

  /// Construct the request channel.
  ///
  /// Return an instance of some [Controller] that will be the initial receiver
  /// of all [Request]s.
  ///
  /// This method is invoked after [prepare].
  @override
  Controller get entryPoint {
    final router = Router();

    // Prefer to use `link` instead of `linkFunction`.
    // See: https://aqueduct.io/docs/http/request_controller/
    router
        .route("/version")
        .link(() => ValidateController())
        .linkFunction((request) async {
      return Response.ok({
        "versionName": "1.0.0-dev",
        "versionCode": 2,
      });
    });
    router
        .route("/user/[:id]")
        .link(() => ValidateController())
        .link(() => UserController(context));
    router
        .route("/login")
        .link(() => ValidateController())
        .link(() => LoginController(context));
    return router;
  }
}
