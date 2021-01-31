import 'package:server/server.dart';

import '../config.dart';

class ValidateController extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final headers = request.raw.headers;

    final apiKey = headers.value('API-Key');
    // print('apikey $apiKey');
    if (apiKey == null) {
      final Response response = Response.unauthorized();
      response.contentType = ContentType.json; //内容类型
      response.body = {'code': -1, 'error': '未发现秘钥'}; //内容
      return response;
    }
    if (apiKey == Config.apiKey) {
      return request;
    }
    final Response response = Response.unauthorized();
    response.contentType = ContentType.json; //内容类型
    response.body = {'code': -1, 'error': '秘钥不正确'}; //内容
    return response;
  }
}
