import 'package:aqueduct/managed_auth.dart';
import 'package:server/server.dart';

class User extends ManagedObject<_User>
    implements _User, ManagedAuthResourceOwner<_User> {
  User() {
    mobile ??= '';
    qq ??= '';
    role ??= 1;
    salt ??= '';
  }
}

class _User extends ResourceOwnerTableDefinition {
  @override
  @primaryKey //作为主键 == @
  int id;
  String password;
  String mobile;
  String qq;
  @Column(unique: true, nullable: true) //添加索引
  String email;
  int role;
  String realName;
  int studentNumer;
  String studentDepart;

  @Column(indexed: true) //添加索引
  DateTime createDate;
}
