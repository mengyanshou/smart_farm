import 'package:server/server.dart';

class User extends ManagedObject<_User> implements _User {
  User() {
    email ??= '';
    mobile ??= '';
    qq ??= '';
    role ??= 0;
  }
}

class _User {
  @primaryKey //作为主键 == @
  int id;
  String username;
  String password;
  String mobile;
  String qq;
  String email;
  int role;

  @Column(indexed: true) //添加索引
  DateTime createDate;
}
