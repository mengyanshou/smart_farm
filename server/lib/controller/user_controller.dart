import 'package:server/server.dart';

import '../config.dart';
import '../model/user_info.dart';

class UserController extends ResourceController {
  UserController(this.context);

  final ManagedContext context;

  // bool hasAuthorization(int id) {
  //   final headers = request.raw.headers;
  //   final token = headers.value('Authorization');
  //   print('token->$token<-');
  //   print('缓存token->${Global.instance.tokenMap} id ->$id');
  //   if (token == null) {
  //     return false;
  //   }
  //   return Global.instance.tokenMap[id] == token;
  // }

  @Operation.get()
  Future<Response> getUserInfo() async {
    final forUserID = request.authorization.ownerID;
    // if (!hasAuthorization(id)) {
    //   final Response response = Response.unauthorized();
    //   response.contentType = ContentType.json; //内容类型
    //   response.body = {'code': -1, 'msg': '账号未登录'}; //内容
    //   return response;
    // }
//根据id查询一条数据
    final query = Query<User>(context)..where((a) => a.id).equalTo(forUserID);
    final article = await query.fetchOne();
    // article.password = '';
    if (article != null) {
      return Response.ok(article);
    } else {
      return Response.ok({'msg': '未找到该用户'});
    }
  }

  @Operation.put()
  Future<Response> updateUserInfo(
    @Bind.body(ignore: ["createData"]) User user,
  ) async {
    final forUserID = request.authorization.ownerID;
    // if (!hasAuthorization(id)) {
    //   final Response response = Response.unauthorized(); //404的状态码
    //   response.contentType = ContentType.json; //内容类型
    //   response.body = {'code': -1, 'msg': '账号未登录'}; //内容
    //   return response;
    // }
    final query = Query<User>(context)
      ..values.role = user.role
      ..values.username = user.username
      ..values.email = user.email
      ..values.mobile = user.mobile
      ..values.qq = user.qq
      ..where((a) => a.id).equalTo(forUserID);
//更新一条数据
    final result = await query.updateOne();
//    final article = await query.fetchOne();
    if (result != null) {
      return Response.ok({'msg': '更新成功'});
    } else {
      return Response.ok({'msg': '更新失败'});
    }
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
