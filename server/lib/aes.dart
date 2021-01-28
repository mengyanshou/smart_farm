import 'package:encrypt/encrypt.dart';

void main() {
  final plainText = 'nightmare';
  final key = Key.fromLength(32);
  final iv = IV.fromLength(16);
  final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

  final encrypted = encrypter.encrypt(plainText, iv: iv);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);

  print(decrypted); // Lorem ipsum dolor sit amet, consectetur adipiscing elit
  print(encrypted
      .base64); // CR+IAWBEx3sA/dLkkFM/orYr9KftrGa7lIFSAAmVPbKIOLDOzGwEi9ohstDBqDLIaXMEeulwXQ==
}
