import 'package:server/server.dart';

import '../config.dart';
import '../model/user_info.dart';

class RegisterController extends ResourceController {
  RegisterController(this.context);

  final ManagedContext context;

  @Operation.post()
  FutureOr<Response> register(
    @Bind.body(ignore: ["createData", 'mobile']) User newUser,
  ) async {
    if (newUser.username == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'error': '缺少用户名'}; //内容
      return response;
    }
    if (newUser.password == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'error': '缺少密码'}; //内容
      return response;
    }
    newUser.createDate = DateTime.now();
    newUser.hashedPassword = AuthUtility.generatePasswordHash(
      newUser.password,
      newUser.salt,
    );
    print('newUser.hashedPassword ->${newUser.hashedPassword}');
    final query = Query<User>(context)
      ..where((a) => a.username).equalTo(newUser.username);
    final user = await query.fetchOne();
    if (user != null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'error': '该账号已被注册'}; //内容
      return response;
    }
    final dbResult = await context.insertObject<User>(newUser);
    final Map<String, dynamic> result = dbResult.asMap();
    result.remove('password');
    return Response.ok(result);
    // Response.badRequest()
  }

  // @Operation.delete('id')//删除一篇文章
//   Future<Response> deleteArticleById(@Bind.path('id') int id) async {
//     final query = Query<Article>(context)..where((a) => a.id).equalTo(id);
// //删除一条数据
//     final result = await query.delete();
//     if (result != null && result == 1) {
//       return Result.successMsg("删除成功");
//     } else {
//       return Result.errorMsg("删除失败，数据不存在");
//     }
//   }
}
