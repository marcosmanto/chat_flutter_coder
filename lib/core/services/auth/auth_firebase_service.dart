import 'dart:async';

import 'package:chat_flutter_coder/core/models/chat_user.dart';
import 'dart:io';

import 'package:chat_flutter_coder/core/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebaseService implements AuthService {
  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : _toChatUser(user);
      controller.add(_currentUser);
    }
  });

  void _printCatchedError(String error, StackTrace stacktrace) {
    // ignore: avoid_print
    print(
        '\n****************\n[ERROR]: ${error.toString()}\n****************\nstacktrace:$stacktrace');
    // ignore: avoid_print
    print('****************');
  }

  @override
  ChatUser? get currentUser => _currentUser;

  @override
  Stream<ChatUser?> get userChanges => _userStream;

  @override
  Future<void> login(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.toString().trim(),
        password: password.toString().trim(),
      );
    } catch (error, stacktrace) {
      _printCatchedError(error.toString(), stacktrace);
    }
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  @override
  Future<void> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.toString().trim(),
        password: password.toString().trim(),
      );

      if (credential.user == null) return;

      credential.user!.updateDisplayName(name);
    } catch (error, stacktrace) {
      _printCatchedError(error.toString(), stacktrace);
    }
  }

  static ChatUser _toChatUser(User user) {
    return ChatUser(
      id: user.uid,
      name: user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageURL: user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
