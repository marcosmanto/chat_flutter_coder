import 'package:chat_flutter_coder/components/auth_form.dart';
import 'package:chat_flutter_coder/utils/clear_focus.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: const ClearFocus(
        child: Center(
          child: SingleChildScrollView(
            child: AuthForm(),
          ),
        ),
      ),
    );
  }
}
