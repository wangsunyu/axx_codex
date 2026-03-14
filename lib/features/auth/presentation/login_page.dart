import 'dart:async';

import 'package:flutter/material.dart';

import '../../../shared/widgets/app_message.dart';
import '../../../shared/widgets/debounced_buttons.dart';
import '../data/auth_service.dart';
import '../domain/auth_mode.dart';
import '../../home/presentation/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final FocusNode _accountFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final AuthService _authService = AuthService();

  AuthMode _mode = AuthMode.password;
  bool _isSubmitting = false;
  int _countdown = 0;
  Timer? _countdownTimer;

  bool get _isPhoneValid => RegExp(r'^1\d{10}$').hasMatch(_phoneController.text);
  bool get _canSubmitPasswordLogin =>
      _accountController.text.trim().length >= 6 &&
      _passwordController.text.length >= 6 &&
      !_isSubmitting;
  bool get _canSubmitCodeLogin =>
      _isPhoneValid && _codeController.text.trim().length == 6 && !_isSubmitting;
  bool get _canRequestCode => _countdown == 0 && !_isSubmitting;

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_refresh);
    _passwordController.addListener(_refresh);
    _phoneController.addListener(_refresh);
    _codeController.addListener(_refresh);
    _accountFocusNode.addListener(_refresh);
    _passwordFocusNode.addListener(_refresh);
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    _accountController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _codeController.dispose();
    _accountFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _requestCode() async {
    if (!_isPhoneValid) {
      _showMessage('请输入正确的手机号码');
      return;
    }
    try {
      setState(() {
        _isSubmitting = true;
      });
      await _authService.requestSmsCode(_phoneController.text.trim());
      _startCountdown();
      _showMessage('验证码已发送');
    } on AuthException catch (error) {
      _showMessage(error.message);
    } catch (_) {
      _showMessage('验证码发送失败，请稍后重试');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  Future<void> _submitLogin() async {
    try {
      setState(() {
        _isSubmitting = true;
      });
      if (_mode == AuthMode.password) {
        await _authService.loginWithPassword(
          userCode: _accountController.text.trim(),
          password: _passwordController.text,
        );
      } else {
        await _authService.loginWithVerificationCode(
          userCode: _phoneController.text.trim(),
          verificationCode: _codeController.text.trim(),
        );
      }
      if (!mounted) {
        return;
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute<void>(
          builder: (_) => const HomePage(),
        ),
      );
    } on AuthException catch (error) {
      _showMessage(error.message);
    } catch (_) {
      _showMessage('登录失败，请稍后重试');
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  void _startCountdown() {
    _countdownTimer?.cancel();
    setState(() {
      _countdown = 120;
    });
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown <= 1) {
        timer.cancel();
        if (mounted) {
          setState(() {
            _countdown = 0;
          });
        }
        return;
      }
      if (mounted) {
        setState(() {
          _countdown -= 1;
        });
      }
    });
  }

  void _showMessage(String message) {
    AppMessage.show(context, message);
  }

  void _switchMode() {
    setState(() {
      _mode = _mode == AuthMode.password
          ? AuthMode.verificationCode
          : AuthMode.password;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/login/top-bg@2x.png',
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).padding.top,
                color: Colors.white.withValues(alpha: 0.08),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  children: [
                    const SizedBox(height: 164),
                    _buildInputCard(),
                    const SizedBox(height: 52),
                    _buildLoginButton(),
                    const SizedBox(height: 16),
                    _buildFooterActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: _mode == AuthMode.password
            ? [
                _buildPasswordRow(
                  iconPath: _accountFocusNode.hasFocus
                      ? 'assets/login/icon-user-select.png'
                      : 'assets/login/icon-user@2x.png',
                  controller: _accountController,
                  focusNode: _accountFocusNode,
                  hintText: '学号/身份证号/手机号',
                  maxLength: 18,
                ),
                const Divider(height: 1, thickness: 0.6, color: Color(0xFFE9E9E9)),
                _buildPasswordRow(
                  iconPath: _passwordFocusNode.hasFocus
                      ? 'assets/login/icon-passward-select@2x.png'
                      : 'assets/login/icon-passward@2x.png',
                  controller: _passwordController,
                  focusNode: _passwordFocusNode,
                  hintText: '请输入密码',
                  maxLength: 20,
                  obscureText: true,
                ),
              ]
            : [
                _buildCodeRow(
                  label: '手机号码',
                  controller: _phoneController,
                  hintText: '请输入手机号',
                  maxLength: 11,
                  keyboardType: TextInputType.phone,
                  trailing: DebouncedTextButton(
                    debounceKey: 'request_sms_code',
                    onPressed: _canRequestCode ? _requestCode : null,
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFFB6B6B6),
                      minimumSize: const Size(92, 32),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(color: Color(0xFFDEDEDE)),
                      ),
                    ),
                    child: Text(_countdown > 0 ? '${_countdown}s' : '获取验证码'),
                  ),
                ),
                const Divider(height: 1, thickness: 0.6, color: Color(0xFFE9E9E9)),
                _buildCodeRow(
                  label: '验证码',
                  controller: _codeController,
                  hintText: '请输入验证码',
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                ),
              ],
      ),
    );
  }

  Widget _buildPasswordRow({
    required String iconPath,
    required TextEditingController controller,
    required FocusNode focusNode,
    required String hintText,
    required int maxLength,
    bool obscureText = false,
  }) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 18),
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              obscureText: obscureText,
              maxLength: maxLength,
              decoration: InputDecoration(
                hintText: hintText,
                counterText: '',
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Color(0xFFB6B6B6),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  Widget _buildCodeRow({
    required String label,
    required TextEditingController controller,
    required String hintText,
    required int maxLength,
    TextInputType? keyboardType,
    Widget? trailing,
  }) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const SizedBox(width: 16),
          SizedBox(
            width: 70,
            child: Text(
              label,
              style: const TextStyle(
                color: Color(0xFF666666),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              decoration: InputDecoration(
                hintText: hintText,
                counterText: '',
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  color: Color(0xFFB6B6B6),
                  fontSize: 16,
                ),
              ),
            ),
          ),
          if (trailing != null) ...<Widget>[trailing],
          const SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildLoginButton() {
    final bool enabled = _mode == AuthMode.password
        ? _canSubmitPasswordLogin
        : _canSubmitCodeLogin;
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              enabled
                  ? 'assets/login/btn-login@2x.png'
                  : 'assets/login/btn-login-disable@2x.png',
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: DebouncedFilledButton(
          debounceKey: 'submit_login',
          onPressed: enabled ? _submitLogin : null,
          style: FilledButton.styleFrom(
            backgroundColor: Colors.transparent,
            disabledBackgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: enabled
                ? Colors.white
                : const Color(0xFFBEB7A2),
            shape: const StadiumBorder(),
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          child: Text(_isSubmitting ? '提交中...' : '登录'),
        ),
      ),
    );
  }

  Widget _buildFooterActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DebouncedTextButton(
            debounceKey: 'switch_login_mode',
            onPressed: _switchMode,
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFA7A7A7),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              _mode == AuthMode.password ? '验证码登录  >>' : '账号登录  >>',
              style: const TextStyle(fontSize: 16),
            ),
          ),
          DebouncedTextButton(
            debounceKey: 'forgot_password',
            onPressed: () {
              _showMessage('找回密码功能暂未开放');
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFA7A7A7),
              padding: EdgeInsets.zero,
            ),
            child: const Text(
              '找回密码',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
