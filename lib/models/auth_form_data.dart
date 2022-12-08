import 'dart:io';

enum AuthMode { signup, login }

class AuthFormData {
  String name = '';
  String email = '';
  String password = '';
  File? image;
  AuthMode _mode = AuthMode.login;

  bool get isLogin {
    return _mode == AuthMode.login;
  }

  bool get isSignup {
    return _mode == AuthMode.signup;
  }

  void toggleAutMode() {
    _mode = isLogin ? AuthMode.signup : AuthMode.login;
  }

  @override
  String toString() {
    return """
AuthFormData instance:
----------------------${((name) {
      return name != null && !name?.isEmpty ? '\nname: $name' : '';
    }(name))}
email: $email
password: $password
${((imagePath) {
      return imagePath != null ? 'image: $imagePath' : '';
    }(image?.path))}""";
  }
}
