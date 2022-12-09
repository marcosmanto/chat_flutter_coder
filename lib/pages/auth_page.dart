import 'package:chat_flutter_coder/components/auth_form.dart';
import 'package:chat_flutter_coder/core/models/auth_form_data.dart';
import 'package:chat_flutter_coder/core/services/auth/auth_mock_service.dart';
import 'package:chat_flutter_coder/utils/clear_focus.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isLoading = false;

  void _handleSubmit(AuthFormData formData) async {
    try {
      setState(() => _isLoading = true);

      if (formData.isLogin) {
        await AuthMockService().login(
          formData.email,
          formData.password,
        );
      } else {
        await AuthMockService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
      }
    } catch (error) {
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          ClearFocus(
            child: Center(
              child: SingleChildScrollView(
                child: AuthForm(onSubmit: _handleSubmit),
              ),
            ),
          ),
          if (_isLoading) // loading overlay
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: const Color.fromRGBO(0, 0, 0, .5),
              child: Center(
                child: SizedBox(
                  width: 55,
                  height: 55,
                  child: RefreshProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
