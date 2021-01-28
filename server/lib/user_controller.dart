import 'package:server/server.dart';

import 'aes_encrypt.dart';
import 'config.dart';
import 'model/user_info.dart';

class UserController extends ResourceController {
  UserController(this.context);

  static Map<int, String> tokenMap = {};
  final ManagedContext context;

  bool hasAuthorization(int id) {
    final headers = request.raw.headers;
    final token = headers.value('Authorization');
    print('token->$token');
    if (token == null) {
      return false;
    }
    return tokenMap[id] == token;
  }

  @Operation.get() //获取文章列表
  FutureOr<Response> getArticle() async {
//查询文章，并根据createDate进行排序
// UserInfo().createData;
    logger.log(Level.INFO, 'message');
    final query = Query<User>(context)
      ..sortBy((User e) => e.createDate, QuerySortOrder.ascending);
    final List<User> articles = await query.fetch();
    return Response.ok(articles);
  }

  @Operation.post()
  FutureOr<Response> register(
    @Bind.body(ignore: ["createData", 'mobile']) User newUser,
  ) async {
    if (newUser.username == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '缺少用户名'}; //内容
      return response;
    }
    if (newUser.password == null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '缺少密码'}; //内容
      return response;
    }
    newUser.createDate = DateTime.now();
    final query = Query<User>(context)
      ..where((a) => a.username).equalTo(newUser.username);
    final user = await query.fetchOne();
    if (user != null) {
      final Response response = Response.badRequest(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '该账号已被注册'}; //内容
      return response;
    }

    final dbResult = await context.insertObject<User>(newUser);
    final Map<String, dynamic> result = dbResult.asMap();
    result.remove('password');
    return Response.ok(result);
    // Response.badRequest()
  }

  @Operation.get('id')
  Future<Response> getUserInfo(
    @Bind.path('id') int id,
  ) async {
    if (!hasAuthorization(id)) {
      final Response response = Response.unauthorized(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '账号未登录'}; //内容
      return response;
    }
//根据id查询一条数据
    final query = Query<User>(context)..where((a) => a.id).equalTo(id);
    final article = await query.fetchOne();
    // article.password = '';
    if (article != null) {
      return Response.ok(article);
    } else {
      return Response.ok({'msg': 'user not found'});
    }
  }

  @Operation.put('id')
  Future<Response> updateUserInfo(
    @Bind.body(ignore: ["createData"]) User user,
    @Bind.path('id') int id,
  ) async {
    if (!hasAuthorization(id)) {
      final Response response = Response.unauthorized(); //404的状态码
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'msg': '账号未登录'}; //内容
      return response;
    }
    final query = Query<User>(context)
      ..values.email = user.email
      ..values.mobile = user.mobile
      ..values.qq = user.qq
      ..where((a) => a.id).equalTo(id);
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
