import 'package:encrypt/encrypt.dart';

class AesTool {
  static String aesEncrypt(String data) {
    final Key key = Key.fromUtf8('................................');
    final IV iv = IV.fromLength(16);
    final Encrypter encrypter = Encrypter(AES(key));
    final Encrypted encrypted = encrypter.encrypt(data, iv: iv);
    return encrypted.base64;
  }

  static String aesDecrypt(String base64) {
    final Key key = Key.fromUtf8('................................');
    final IV iv = IV.fromLength(16);
    final Encrypter encrypter = Encrypter(AES(key));
    final String decrypted = encrypter.decrypt(Encrypted.fromBase64(base64), iv: iv);
    return decrypted;
  }
}
