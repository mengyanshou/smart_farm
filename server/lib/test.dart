import 'dart:convert';

void main(List<String> args) {
  var clientID = "com.nightmare.termare";
  var clientSecret = "com.nightmare";
  var clientCredentials =
      Base64Encoder().convert("$clientID:$clientSecret".codeUnits);
  var header = "Basic $clientCredentials";
  print(header);
  print(Base64Encoder().convert("$clientSecret".codeUnits));
  // print('0');
  // print('O');
  // var clientID = "com.nightmare.termare";
  // var body = "username=nightmare&password=1234&grant_type=password";
  // var clientCredentials = Base64Encoder().convert("$clientID:".codeUnits);
  // print("Basic $clientCredentials");
  // print(body);
  // var response = await http.post("https://stablekernel.com/auth/token",
  //     headers: {
  //       "Content-Type": "application/x-www-form-urlencoded",
  //       "Authorization": "Basic $clientCredentials"
  //     },
  //     body: body);
}
