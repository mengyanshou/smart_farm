// import 'package:server/server.dart';

// import 'config.dart';
// import 'model/user_info.dart';

// class TokenController extends Controller {
//   static Map<int, String> tokenMap = {};
//   @override
//   FutureOr<RequestOrResponse> handle(Request request) async {
//     final headers = request.raw.headers;
//     // User user = User.;
//     print(request.authorization);
//     print(request.body);
//     final apiKey = headers.value('Authorization');
//     print(apiKey);
//     if (apiKey == Config.apiKey) {
//       return request;
//     }
//     return Response.unauthorized();
//   }
// }
