import 'package:aos/data/registerModel.dart';
import 'package:aos/presentation/register2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register1 extends StatefulWidget {
  const Register1({super.key});

  @override
  State<Register1> createState() => _Register1State();
}

class _Register1State extends State<Register1> {
  RxBool male = true.obs;

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController link = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController town = TextEditingController();
  TextEditingController pwd = TextEditingController();
  TextEditingController confirmpwd = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 244, 239),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "The Kenetic Hearth",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    fontFamily: "pjs",
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                SizedBox(width: 150),
                Container(
                  width: 450,
                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "STEP 1 OF 2",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          letterSpacing: 3.2,
                        ),
                      ),
                      SizedBox(height: 15),
                      Text(
                        "Ignite Your",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          height: 0.8,
                        ),
                      ),
                      Text(
                        "Social",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                          color: Color.fromARGB(255, 132, 86, 16),
                          fontFamily: "pjs",
                        ),
                      ),
                      Text(
                        "Journey",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          height: 0.8,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Welcome to the hearth. Before we find your\nkinetic matches, we need a few details to build\nyour unique profile.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                        ),
                      ),
                      SizedBox(height: 20),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/register.png',
                          width: 270,
                          height: 330,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Center(
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(
                        bottom: 30,
                        left: 150,
                        right: 150,
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(253, 232, 222, 1),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Account basics",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              fontFamily: "pjs",
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Container(
                                width: 80,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(155, 63, 0, 1),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                width: 80,
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color.fromRGBO(255, 212, 185, 1),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: textbox2(
                                  text: "NAME",
                                  hint: "E.g. Mohamed",
                                  obscure: false,
                                  controller: prenom,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: textbox2(
                                  text: "FAMILY NAME",
                                  hint: "E.g. Touati",
                                  obscure: false,
                                  controller: nom,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          textbox2(
                            text: "EMAIL ADRESS",
                            hint: "mohamed.t@gmail.com",
                            obscure: false,
                            controller: email,
                          ),
                          SizedBox(height: 15),
                          textbox2(
                            text: "FACEBOOK LINK",
                            hint: "https://www.facebook.com/mohamed.touati",
                            obscure: false,
                            controller: link,
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: textbox2(
                                  text: "AGE",
                                  hint: "31",
                                  obscure: false,
                                  controller: age,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: textbox2(
                                  text: "TOWN",
                                  hint: "Algiers",
                                  obscure: false,
                                  controller: town,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "GENDER",
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 69, 49, 20),
                                  fontFamily: "pjs",
                                ),
                              ),
                              SizedBox(height: 7),
                              Obx(
                                () => Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 246, 246, 246),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            male.value = true;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: male.value
                                                  ? Color.fromRGBO(
                                                      155,
                                                      63,
                                                      0,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      246,
                                                      246,
                                                      246,
                                                    ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Male",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: male.value
                                                      ? Color.fromARGB(
                                                          255,
                                                          246,
                                                          246,
                                                          246,
                                                        )
                                                      : Color.fromARGB(
                                                          255,
                                                          69,
                                                          49,
                                                          20,
                                                        ),
                                                  fontFamily: "pjs",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            male.value = false;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: !male.value
                                                  ? Color.fromRGBO(
                                                      155,
                                                      63,
                                                      0,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      246,
                                                      246,
                                                      246,
                                                    ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Female",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: !male.value
                                                      ? Color.fromARGB(
                                                          255,
                                                          246,
                                                          246,
                                                          246,
                                                        )
                                                      : Color.fromARGB(
                                                          255,
                                                          69,
                                                          49,
                                                          20,
                                                        ),
                                                  fontFamily: "pjs",
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: textbox2(
                                  text: "PASSWORD",
                                  hint: "••••••••",
                                  obscure: true,
                                  controller: pwd,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: textbox2(
                                  text: "CONFIRM PASSWORD",
                                  hint: "••••••••",
                                  obscure: true,
                                  controller: confirmpwd,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          btn(
                            text: "Continue to Preferences",
                            dest: Register2(edit: false, editid: 0),
                            fct: register,
                            cpwd: confirmpwd,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  RegisterModel register() {
    String sexe;
    if (male.value) {
      sexe = "M";
    } else {
      sexe = "F";
    }
    RegisterModel model = RegisterModel(
      nom: nom.text,
      prenom: prenom.text,
      pwd: pwd.text,
      sexe: sexe,
      prefGender: "",
      minAge: 0,
      maxAge: 0,
      age: age.text.isEmpty ? null : int.tryParse(age.text),
      ville: town.text,
      link: link.text,
      email: email.text,
      hobbies: [],
    );
    return model;
  }
}

class textbox2 extends StatefulWidget {
  const textbox2({
    super.key,
    required this.text,
    required this.hint,
    required this.obscure,
    required this.controller,
  });

  final String text;
  final String hint;
  final bool obscure;
  final TextEditingController controller;

  @override
  State<textbox2> createState() => _textbox2State();
}

class _textbox2State extends State<textbox2> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: const Color.fromARGB(255, 69, 49, 20),
            fontFamily: "pjs",
          ),
        ),
        SizedBox(height: 5),
        Container(
          height: 45,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 246, 246, 246),
            borderRadius: BorderRadius.circular(2),
          ),
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
                fontSize: 12,
                fontFamily: "pjs",
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class btn extends StatefulWidget {
  const btn({
    super.key,
    required this.text,
    required this.dest,
    required this.fct,
    required this.cpwd,
  });

  final String text;
  final Widget dest;
  final Function fct;
  final TextEditingController cpwd;

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
          onTap: () {
            RegisterModel model = widget.fct();
            // if (!model.isComplete1()) {
            //   Fluttertoast.showToast(
            //     msg: "Fill in all the fields!",
            //     toastLength: Toast.LENGTH_LONG,
            //     timeInSecForIosWeb: 3,
            //     gravity: ToastGravity.BOTTOM,
            //     webPosition: "center",
            //     backgroundColor: const Color.fromARGB(255, 71, 40, 8),
            //     webBgColor: "#9B3F00",
            //     textColor: Colors.white,
            //     fontSize: 25,
            //   );
            // }
            // if (model.pwd != widget.cpwd.text) {
            //   Fluttertoast.showToast(
            //     msg: "Passwords do not match!",
            //     toastLength: Toast.LENGTH_LONG,
            //     timeInSecForIosWeb: 3,
            //     gravity: ToastGravity.BOTTOM,
            //     webPosition: "center",
            //     backgroundColor: const Color.fromARGB(255, 135, 79, 22),
            //     webBgColor: "#9B3F00",
            //     textColor: Colors.white,
            //     fontSize: 25,
            //   );
            // }
            // if (model.isComplete1() && model.pwd == widget.cpwd.text) {
            //   Navigator.of(
            //     context,
            //   ).push(animation(Register2(edit: false, infos: model)));
            // }

            Navigator.of(
              context,
            ).push(animation(Register2(edit: false, infos: model, editid: 0)));
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
