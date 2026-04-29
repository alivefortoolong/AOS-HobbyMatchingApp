import 'package:aos/data/PrefModel.dart';
import 'package:aos/data/PrefRemoteDataSource.dart';
import 'package:aos/data/registerModel.dart';
import 'package:aos/data/registerRemoteDataSource.dart';
import 'package:aos/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class Register2 extends StatefulWidget {
  const Register2({
    super.key,
    required this.edit,
    this.infos,
    required this.editid,
  });

  final bool edit;
  final int editid;
  final RegisterModel? infos;

  @override
  State<Register2> createState() => _Register2State();
}

class _Register2State extends State<Register2> {
  RangeValues values = RangeValues(18, 80);
  RxBool male = true.obs;
  RxBool female = false.obs;
  RxBool both = false.obs;
  List<String> hobbies = [];

  @override
  void initState() {
    super.initState();
  }

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
                        "DISCOVERY ENGINE",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color.fromARGB(255, 34, 94, 150),
                          fontFamily: "pjs",
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        (widget.edit) ? "Edit Your" : "Find Your",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          height: 0.8,
                        ),
                      ),
                      Text(
                        "Perfect",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          fontSize: 50,
                          color: Color.fromARGB(255, 132, 86, 16),
                          fontFamily: "pjs",
                        ),
                      ),
                      Text(
                        "Match",
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
                        "We believe sparks fly when hobbies collide, Tell us\nwho you are looking for to share the warmth of the\nhearth.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                        ),
                      ),
                      SizedBox(height: 20),
                      !(widget.edit)
                          ? Row(
                              children: [
                                Container(
                                  width: 280,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        const Color.fromARGB(255, 163, 83, 3),
                                        const Color.fromARGB(255, 202, 102, 3),
                                        Color.fromARGB(255, 220, 112, 4),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text(
                                  "Step 2 of 2",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 69, 49, 20),
                                    fontFamily: "pjs",
                                  ),
                                ),
                              ],
                            )
                          : SizedBox.shrink(),
                      SizedBox(height: 30),
                      Transform.rotate(
                        angle: -0.07,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/register2.png',
                            width: 200,
                            height: 250,
                            fit: BoxFit.cover,
                          ),
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
                        vertical: 50,
                        horizontal: 40,
                      ),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 246, 246, 246),
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            spreadRadius: 2,
                            offset: Offset(0, 0),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Preferred Gender",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 93, 61, 9),
                                  fontFamily: "pjs",
                                  letterSpacing: 0.01,
                                ),
                              ),
                              SizedBox(height: 20),
                              Obx(
                                () => Container(
                                  width: double.infinity,
                                  height: 45,
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 249, 225, 214),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            male.value = true;
                                            female.value = false;
                                            both.value = false;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: male.value
                                                  ? Color.fromRGBO(
                                                      43,
                                                      80,
                                                      190,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      249,
                                                      225,
                                                      214,
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
                                            female.value = true;
                                            both.value = false;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: female.value
                                                  ? Color.fromRGBO(
                                                      43,
                                                      80,
                                                      190,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      249,
                                                      225,
                                                      214,
                                                    ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Female",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: female.value
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
                                            female.value = false;
                                            both.value = true;
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: both.value
                                                  ? Color.fromRGBO(
                                                      43,
                                                      80,
                                                      190,
                                                      1,
                                                    )
                                                  : Color.fromARGB(
                                                      255,
                                                      249,
                                                      225,
                                                      214,
                                                    ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Both",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: both.value
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
                              SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Preferred Age Range",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: const Color.fromARGB(
                                        255,
                                        93,
                                        61,
                                        9,
                                      ),
                                      fontFamily: "pjs",
                                      letterSpacing: 0.01,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "${values.start.round()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: const Color.fromARGB(
                                            255,
                                            118,
                                            82,
                                            5,
                                          ),
                                          fontFamily: "pjs",
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "TO",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 10,
                                          color: const Color.fromARGB(
                                            131,
                                            95,
                                            95,
                                            95,
                                          ),
                                          fontFamily: "pjs",
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "${values.end.round()}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: const Color.fromARGB(
                                            255,
                                            118,
                                            82,
                                            5,
                                          ),
                                          fontFamily: "pjs",
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                  activeTrackColor: Color.fromRGBO(
                                    155,
                                    63,
                                    0,
                                    1,
                                  ),
                                  inactiveTrackColor: Colors.grey.shade300,
                                  thumbColor: Color.fromRGBO(155, 63, 0, 1),
                                  overlayColor: Color.fromRGBO(
                                    204,
                                    146,
                                    116,
                                    0.544,
                                  ),
                                  valueIndicatorColor: Color.fromRGBO(
                                    155,
                                    63,
                                    0,
                                    1,
                                  ),
                                ),
                                child: RangeSlider(
                                  values: values,
                                  min: 18,
                                  max: 80,
                                  divisions: 100,
                                  labels: RangeLabels(
                                    values.start.round().toString(),
                                    values.end.round().toString(),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      values = val;
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                "Select Your Hobbies",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: const Color.fromARGB(255, 93, 61, 9),
                                  fontFamily: "pjs",
                                ),
                              ),
                              SizedBox(height: 30),
                              Row(
                                children: [
                                  hobby(hob: "Politics", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Football", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Reading", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Hiking", addHobby: addHobby),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  hobby(hob: "Cooking", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Astronomy", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Photography", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Yoga", addHobby: addHobby),
                                  SizedBox(width: 5),
                                ],
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  hobby(hob: "Painting", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Music", addHobby: addHobby),
                                  SizedBox(width: 5),
                                  hobby(hob: "Gaming", addHobby: addHobby),
                                ],
                              ),
                              SizedBox(height: 30),
                              btnn(
                                text: (widget.edit)
                                    ? "Save Changes"
                                    : "Complete Registration",
                                dest: Login(),
                                fct: register,
                                edit: widget.edit,
                                editid: widget.editid,
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          "assets/back.png",
                                          height: 15,
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          (widget.edit)
                                              ? "BACK TO PROFILE"
                                              : "BACK TO PERSONAL INFO",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(
                                              145,
                                              94,
                                              69,
                                              1,
                                            ),
                                            fontFamily: "pjs",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
        ],
      ),
    );
  }

  RegisterModel register() {
    RegisterModel model;
    if (!widget.edit) {
      model = widget.infos!;
    } else {
      model = RegisterModel(
        nom: "",
        prenom: "",
        pwd: "",
        sexe: "",
        prefGender: "",
        minAge: 0,
        maxAge: 0,
        age: 0,
        ville: "",
        link: "",
        email: "",
        hobbies: hobbies,
      );
    }
    model.minAge = values.start.round();
    model.maxAge = values.end.round();
    model.hobbies = hobbies;

    if (both.value) {
      model.prefGender = "Both";
    } else if (male.value) {
      model.prefGender = "M";
    } else if (female.value) {
      model.prefGender = "F";
    }
    print(model.toJson());

    return model;
  }

  void addHobby(String hobby, bool selected) {
    if (selected) {
      hobbies.add(hobby);
    } else {
      hobbies.remove(hobby);
    }
  }
}

class hobby extends StatefulWidget {
  const hobby({super.key, required this.hob, required this.addHobby});

  final String hob;
  final Function addHobby;

  @override
  State<hobby> createState() => _hobbyState();
}

class _hobbyState extends State<hobby> {
  RxBool selected = false.obs;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () {
          selected.value = !selected.value;
          widget.addHobby(widget.hob, selected.value);
        },
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: selected.value
                    ? const Color.fromARGB(255, 188, 112, 12)
                    : Color.fromARGB(255, 249, 225, 214),
                width: 2,
              ),
              color: selected.value
                  ? Color.fromARGB(255, 249, 225, 214)
                  : Color.fromARGB(255, 246, 246, 246),
            ),
            child: Center(
              child: Text(
                widget.hob.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  fontFamily: "pjs",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class btnn extends StatefulWidget {
  const btnn({
    super.key,
    required this.text,
    required this.dest,
    required this.fct,
    required this.edit,
    required this.editid,
  });

  final String text;
  final Widget dest;
  final Function fct;
  final bool edit;
  final int editid;

  @override
  State<btnn> createState() => _btnnState();
}

class _btnnState extends State<btnn> {
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
            if (model.hobbies.length > 1) {
              if (widget.edit) {
                Prefmodel editModel = Prefmodel(
                  id: widget.editid,
                  prefGender: model.prefGender,
                  minAge: model.minAge,
                  maxAge: model.maxAge,
                  hobbies: model.hobbies,
                );
                PrefRemoteDataSource().editPreferences(editModel);
                Navigator.pop(context);
              } else {
                RegisterRemoteDataSource().register(model);
                Navigator.of(context).push(animation(widget.dest));
              }
            } else {
              Fluttertoast.showToast(
                msg: "Choose at least two hobbies",
                toastLength: Toast.LENGTH_LONG,
                timeInSecForIosWeb: 3,
                gravity: ToastGravity.BOTTOM,
                webPosition: "center",
                backgroundColor: const Color.fromARGB(255, 135, 79, 22),
                webBgColor: "#9B3F00",
                textColor: Colors.white,
                fontSize: 25,
              );
            }
            print(model.toJson());
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
