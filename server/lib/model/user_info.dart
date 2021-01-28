import 'package:server/server.dart';

class User extends ManagedObject<_User> implements _User {
  User() {
    emali ??= '';
    mobile ??= '';
    qq ??= '';
  }
}

class _User {
  @primaryKey //作为主键 == @
  int id;
  String username;
  String password;
  String mobile;
  String qq;
  String emali;

  @Column(indexed: true) //添加索引
  DateTime createDate;
}
