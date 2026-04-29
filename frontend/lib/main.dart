import 'package:aos/presentation/login.dart';
import 'package:aos/presentation/temp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html;

void disableSpellCheck() {
  html.document.querySelectorAll('body').forEach((element) {
    element.setAttribute('spellcheck', 'false');
  });
}

void main() {
  disableSpellCheck();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? token;
  int? id;

  @override
  void initState() {
    super.initState();
    loadToken();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      token = prefs.getString('token');
      id = prefs.getInt('id');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (token == null) {
      return Login();
    }
    print(token);
    print("id : $id");
    return Temp(id: id!);
  }
}
