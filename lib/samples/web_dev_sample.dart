import 'package:flutter/material.dart';
import '../react_flutter/react_flutter.dart';

/// Sample: React/Web developer writing Flutter using familiar HTML syntax.
/// This screen is written entirely with React-style elements.
class WebDevSampleScreen extends StatefulWidget {
  const WebDevSampleScreen({super.key});

  @override
  State<WebDevSampleScreen> createState() => _WebDevSampleScreenState();
}

class _WebDevSampleScreenState extends State<WebDevSampleScreen> {
  String _email = '';
  String _password = '';
  bool _loading = false;
  String? _errorMsg;

  void _handleLogin() async {
    if (_email.isEmpty || _password.isEmpty) {
      setState(() => _errorMsg = 'Vui lòng điền đầy đủ thông tin.');
      return;
    }
    setState(() {
      _loading = true;
      _errorMsg = null;
    });
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _loading = false);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng nhập thành công! 🎉')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // ── React/Web dev writes code like this ──────────────────────────────────
    return Scaffold(
      body: SingleChildScrollView(
        child: Div(
          style: Style(
            minHeight: MediaQuery.of(context).size.height,
            backgroundColor: '#f0f2f5',
            display: 'flex',
            flexDirection: 'column',
            alignItems: 'center',
            justifyContent: 'center',
            padding: 24,
          ),
          child: Div(
            style: Style(
              backgroundColor: '#ffffff',
              borderRadius: 16,
              padding: 36,
              width: 400,
              boxShadow: [
                const BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 24,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            children: [
              // Logo / Icon
              Div(
                style: Style(
                  display: 'flex',
                  flexDirection: 'column',
                  alignItems: 'center',
                  marginBottom: 28,
                ),
                children: [
                  Div(
                    style: Style(
                      backgroundColor: '#6c63ff',
                      borderRadius: 50,
                      width: 64,
                      height: 64,
                      display: 'flex',
                      flexDirection: 'column',
                      alignItems: 'center',
                      justifyContent: 'center',
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  const SizedBox(height: 16),
                  H2(
                    'Chào mừng trở lại!',
                    style: Style(color: '#1a1a2e'),
                  ),
                  const SizedBox(height: 6),
                  P(
                    'Đăng nhập vào tài khoản của bạn',
                    style: Style(color: '#888', fontSize: 14),
                  ),
                ],
              ),

              // Error message
              if (_errorMsg != null) ...[
                Div(
                  style: Style(
                    backgroundColor: '#fff3f3',
                    borderRadius: 8,
                    padding: 12,
                    borderColor: '#ffcccc',
                    borderWidth: 1,
                    marginBottom: 16,
                  ),
                  child: P(_errorMsg!, style: Style(color: '#e53935')),
                ),
              ],

              // Email input
              Label('Email'),
              const SizedBox(height: 6),
              Input(
                type: InputType.email,
                placeholder: 'you@company.com',
                value: _email,
                onChange: (v) => setState(() => _email = v),
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
              ),
              const SizedBox(height: 16),

              // Password input
              Label('Mật khẩu'),
              const SizedBox(height: 6),
              Input(
                type: InputType.password,
                placeholder: '••••••••',
                value: _password,
                onChange: (v) => setState(() => _password = v),
                onSubmit: (_) => _handleLogin(),
              ),
              const SizedBox(height: 6),

              // Forgot password
              Div(
                style: Style(
                  display: 'flex',
                  flexDirection: 'row',
                  justifyContent: 'flex-end',
                ),
                child: A(
                  label: 'Quên mật khẩu?',
                  style: Style(color: '#6c63ff', fontSize: 13),
                  onTap: () {},
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              SizedBox(
                width: double.infinity,
                child: Button(
                  label: _loading ? 'Đang đăng nhập...' : 'Đăng nhập',
                  onClick: _handleLogin,
                  loading: _loading,
                  disabled: _loading,
                  style: Style(
                    backgroundColor: '#6c63ff',
                    color: '#ffffff',
                    borderRadius: 10,
                    padding: 14,
                    fontSize: 15,
                    fontWeight: 'bold',
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Divider
              Div(
                style: Style(
                  display: 'flex',
                  flexDirection: 'row',
                  alignItems: 'center',
                  gap: 12,
                ),
                children: [
                  const Expanded(child: Hr()),
                  Small('hoặc'),
                  const Expanded(child: Hr()),
                ],
              ),
              const SizedBox(height: 20),

              // Register link
              Div(
                style: Style(
                  display: 'flex',
                  flexDirection: 'row',
                  justifyContent: 'center',
                  gap: 4,
                ),
                children: [
                  Small('Chưa có tài khoản?'),
                  A(
                    label: 'Đăng ký ngay',
                    style: Style(color: '#6c63ff', fontSize: 12),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
