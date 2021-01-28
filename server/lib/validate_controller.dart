import 'package:server/server.dart';

import 'config.dart';

class ValidateController extends Controller {
  @override
  FutureOr<RequestOrResponse> handle(Request request) async {
    final headers = request.raw.headers;
    final apiKey = headers.value('API-Key');
    if (apiKey == Config.apiKey) {
      return request;
    }
    return Response.unauthorized();
  }
}
