import 'package:encrypt/encrypt.dart';

class Cryption {
  final Key key = Key.fromLength(32);
  final IV iv = IV.fromLength(8);
  late Encrypter encrypter = Encrypter(Salsa20(key));

  String encrypt(String text) => encrypter.encrypt(text, iv: iv).base64;
  decrypt(String encrypted) =>
      encrypter.decrypt(Encrypted.fromBase64(encrypted), iv: iv);
}
