import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../shared/config/app_environment.dart';
import 'rsa_encryptor.dart';

class AuthService {
  AuthService({
    http.Client? client,
    AppEnvironment? environment,
  })  : _client = client ?? http.Client(),
        _environment = environment ?? AppEnvironment.current;

  final http.Client _client;
  final AppEnvironment _environment;

  Future<void> requestSmsCode(String phoneNumber) async {
    final uri = Uri.parse(
      '${_environment.loginBaseUrl}mobile/sms.do?phoneNo=$phoneNumber',
    );
    final response = await _client.get(uri);
    _ensureSuccess(response);
  }

  Future<void> loginWithPassword({
    required String userCode,
    required String password,
  }) async {
    final response = await _client.post(
      Uri.parse('${_environment.loginBaseUrl}mobile/getToken.do'),
      body: <String, String>{
        'userCode': userCode,
        'password': RsaEncryptor.encryptPassword(password),
      },
    );
    _ensureSuccess(response);
  }

  Future<void> loginWithVerificationCode({
    required String userCode,
    required String verificationCode,
  }) async {
    final response = await _client.post(
      Uri.parse('${_environment.loginBaseUrl}mobile/getToken.do'),
      body: <String, String>{
        'userCode': userCode,
        'password': verificationCode,
        'loginType': 'verificationCode',
      },
    );
    _ensureSuccess(response);
  }

  void _ensureSuccess(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthException('请求失败，请稍后重试');
    }

    if (response.body.isEmpty) {
      return;
    }

    final dynamic decodedBody = jsonDecode(response.body);
    if (decodedBody is! Map<String, dynamic>) {
      return;
    }

    final bool isSuccess = decodedBody['success'] == true ||
        decodedBody['code'] == 200 ||
        decodedBody['code'] == '200' ||
        decodedBody['status'] == 200 ||
        decodedBody['status'] == '200' ||
        decodedBody['ret'] == 1 ||
        decodedBody['ret'] == '1' ||
        decodedBody['result'] == 'success';

    if (!isSuccess) {
      throw AuthException(
        decodedBody['message']?.toString() ??
            decodedBody['msg']?.toString() ??
            '操作失败，请稍后重试',
      );
    }
  }
}

class AuthException implements Exception {
  AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}
