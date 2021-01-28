import 'package:server/server.dart';

import 'aes_encrypt.dart';
import 'config.dart';
import 'model/user_info.dart';
import 'user_controller.dart';

class LoginController extends ResourceController {
  LoginController(this.context);

  final ManagedContext context;

  @Operation.post() //获取文章列表
  FutureOr<Response> login(
      @Bind.body(ignore: ["createData", 'mobile']) User user) async {
//查询文章，并根据createDate进行排序
// UserInfo().createData;
    if (user.username == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '缺少用户名'}; //内容
      return response;
    }
    if (user.password == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '缺少密码'}; //内容
      return response;
    }
    final query = Query<User>(context)
      ..where((a) => a.username).equalTo(user.username);
    final localUser = await query.fetchOne();
    if (localUser != null) {
      if (user.password != localUser.password) {
        final Response response = Response.forbidden(); //404的状态码
        response.contentType = ContentType.json; //内容类型
        response.body = {'code': -1, 'msg': '密码错误'}; //内容
        return response;
      }
      final Map<String, dynamic> result = localUser.asMap();
      result.remove('password');
      String token = AesTool.aesEncrypt(DateTime.now().toString());
      UserController.tokenMap[localUser.id] = token;
      result['token'] = token;
      return Response.ok(result);
    }
    final Response response = Response.forbidden(); //404的状态码
    response.contentType = ContentType.json; //内容类型
    response.body = {'code': -1, 'msg': '没有该用户'}; //内容
    return response;
  }
}
