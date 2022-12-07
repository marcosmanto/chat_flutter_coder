import 'package:chat_flutter_coder/pages/loading_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFFFBE7C6),
          secondary: const Color(0xFFA0E7E5),
          tertiary: const Color(0xFF05445E),
        ),
      ),
      home: const LoadingPage(),
    );
  }
}
