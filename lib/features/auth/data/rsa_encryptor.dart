import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:pointycastle/asymmetric/api.dart';

class RsaEncryptor {
  const RsaEncryptor._();

  static const String _publicKey = '''
-----BEGIN PUBLIC KEY-----
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC8Zt/Ngbil9NG1Y0/8uZDIL5eRWWn3
O9zlPBsVwDcgS2lQXNnZ5hl2CryGe9SbG4gUb1EO7cgizzQl8N1yYmVzwO4kcyOEtA1H
HdBLjC8xvTOGL1G62j6nyOjJE3CMNyCDxEPHSYwuQVMzNko/kg5KyTrNSQt62hwRYbIK
+BRwEQIDAQAB
-----END PUBLIC KEY-----
''';

  static final encrypt.Encrypter _encrypter = encrypt.Encrypter(
    encrypt.RSA(
      publicKey:
          encrypt.RSAKeyParser().parse(_publicKey) as RSAPublicKey,
      encoding: encrypt.RSAEncoding.PKCS1,
    ),
  );

  static String encryptPassword(String value) {
    return _encrypter.encrypt(value).base64;
  }
}
