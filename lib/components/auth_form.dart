import 'dart:io';

import 'package:chat_flutter_coder/components/user_image_picker.dart';
import 'package:chat_flutter_coder/core/models/auth_form_data.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function(AuthFormData) onSubmit;

  const AuthForm({super.key, required this.onSubmit});

  @override
  State<AuthForm> createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  final _formData = AuthFormData();

  void _handleImagePick(File image) {
    _formData.image = image;
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 4),
      action: SnackBarAction(
        label: 'FECHAR',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    ));
  }

  void _submit() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return _showError(
          'Preencha corretamente os campos com erro indicado em vermelho para prosseguir.');
    }

    if (_formData.image == null && _formData.isSignup) {
      return _showError(
          'Selecione uma imagem ou avatar para concluir o cadastro.');
    }

    // send form data to the parent widget AuthPage
    widget.onSubmit(_formData);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: _formData.isSignup ? 12 : 20),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                if (_formData.isSignup)
                  UserImagePicker(
                      onImagePick: _handleImagePick,
                      imageAlreadyChoosed: _formData.image),
                if (_formData.isSignup)
                  TextFormField(
                    key: const ValueKey('name'),
                    initialValue: _formData.name,
                    onChanged: (name) => _formData.name = name,
                    decoration: const InputDecoration(labelText: 'Nome'),
                    validator: (value) {
                      final String name = value ?? '';
                      if (name.trim().length < 5) {
                        return 'Nome deve conter no mínimo 5 caracteres.';
                      }
                      return null;
                    },
                  ),
                TextFormField(
                  key: const ValueKey('email'),
                  initialValue: _formData.email,
                  onChanged: (email) => _formData.email = email,
                  decoration: const InputDecoration(labelText: 'E-mail'),
                  validator: (email) {
                    if (email!.trim().isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+(?:\.[a-zA-Z]{2,3}){1,2}$")
                            .hasMatch(email.trim())) {
                      return 'Informe um e-mail válido.';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  key: const ValueKey('password'),
                  initialValue: _formData.password,
                  onChanged: (password) => _formData.password = password,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (value) {
                    final String password = value ?? '';
                    if (password.length < 6) {
                      return 'Senha deve conter no mínimo 6 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: _submit,
                  child: Text(_formData.isLogin ? 'Entrar' : 'Cadastrar'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _formData.toggleAutMode();
                    });
                  },
                  child: Text(_formData.isLogin
                      ? 'Criar uma nova conta'
                      : 'Já possui conta?'),
                )
              ],
            )),
      ),
    );
  }
}
