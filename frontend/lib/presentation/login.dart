import 'dart:ui';

import 'package:aos/data/authRemoteDataSource.dart';
import 'package:aos/data/authResponseModel.dart';
import 'package:aos/data/loginModel.dart';
import 'package:aos/presentation/register1.dart';
import 'package:aos/presentation/temp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController pwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/loginbg.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 150),

            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                border: Border.all(
                  color: const Color.fromARGB(174, 0, 0, 0),
                  width: 0.7,
                ),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 100,
                          horizontal: 100,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "The kinetic\nHearth",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                    color: const Color.fromARGB(
                                      255,
                                      244,
                                      234,
                                      203,
                                    ),
                                    fontFamily: "pjs",
                                    height: 1,
                                  ),
                                ),
                                Text(
                                  "Where the energy of shared passion meets \nthe warmth of human connection.",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w200,
                                    fontSize: 15,
                                    color: const Color.fromARGB(
                                      255,
                                      244,
                                      234,
                                      203,
                                    ),
                                    fontFamily: "pjs",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(60),
                        bottomRight: Radius.circular(60),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: 450,
                          padding: EdgeInsets.symmetric(
                            vertical: 60,
                            horizontal: 70,
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(147, 255, 244, 239),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "Welcome",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                      color: const Color.fromARGB(
                                        255,
                                        69,
                                        49,
                                        20,
                                      ),
                                      fontFamily: "pjs",
                                    ),
                                  ),
                                  Text(
                                    "continue your journey of discovery",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: "pjs",
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50),
                              textbox(
                                text: "Email adress",
                                hint: "hello@kinetichearth.com",
                                icon: "assets/email.png",
                                obscure: false,
                                controller: email,
                              ),
                              SizedBox(height: 20),
                              textbox(
                                text: "Password",
                                hint: "••••••••",
                                icon: "assets/pwd.png",
                                obscure: true,
                                controller: pwd,
                              ),
                              SizedBox(height: 50),
                              btn(text: "Login", fct: login),
                              Spacer(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "New to the hearth? ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w200,
                                      fontSize: 15,
                                      fontFamily: "pjs",
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(
                                        context,
                                      ).push(animation(Register1()));
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                        fontFamily: "pjs",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  LoginModel login() {
    LoginModel model = LoginModel(email: email.text, password: pwd.text);
    return model;
  }

  Route animation(Widget dest) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dest,
    );
  }
}

class textbox extends StatefulWidget {
  const textbox({
    super.key,
    required this.text,
    required this.hint,
    required this.icon,
    required this.obscure,
    required this.controller,
  });

  final String text;
  final String hint;
  final String icon;
  final bool obscure;
  final TextEditingController controller;

  @override
  State<textbox> createState() => _textboxState();
}

class _textboxState extends State<textbox> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 69, 49, 20),
            fontFamily: "pjs",
          ),
        ),
        SizedBox(height: 10),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Color.fromRGBO(255, 237, 228, 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Row(
            children: [
              Image.asset(widget.icon, height: 17),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  obscureText: widget.obscure,
                  controller: widget.controller,
                  style: TextStyle(
                    color: Color.fromRGBO(122, 77, 56, 1),
                    fontFamily: "pjs",
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(210, 146, 116, 1),
                      fontSize: 13,
                      fontFamily: "pjs",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class btn extends StatefulWidget {
  const btn({super.key, required this.text, required this.fct});

  final String text;
  final Function fct;

  @override
  State<btn> createState() => _btnState();
}

class _btnState extends State<btn> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color.fromARGB(255, 163, 83, 3),
            const Color.fromARGB(255, 202, 102, 3),
            Color.fromARGB(255, 220, 112, 4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: () async {
            LoginModel model = widget.fct();
            AuthResponseModel response = await AuthRemoteDataSource().login(
              model,
            );
            if (response.token != "Failed") {
              final prefs = await SharedPreferences.getInstance();
              await prefs.setString('token', response.token);
              await prefs.setInt('id', response.id);
              Navigator.of(context).push(animation(Temp(id: response.id)));
            }
          },
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }

  Route animation(Widget dest) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dest,
    );
  }
}
