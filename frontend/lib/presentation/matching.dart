import 'package:aos/data/PrefModel.dart';
import 'package:aos/data/PrefRemoteDataSource.dart';
import 'package:aos/data/likeModel.dart';
import 'package:aos/data/likeRemoteDataSource.dart';
import 'package:aos/data/matchingModel.dart';
import 'package:aos/data/matchingRemoteDataSource.dart';
import 'package:flutter/material.dart';

class Matching extends StatefulWidget {
  const Matching({super.key, required this.id});

  final int id;

  @override
  State<Matching> createState() => _MatchingState();
}

class _MatchingState extends State<Matching> {
  Prefmodel preferencesFake = Prefmodel(
    id: 0,
    town: "Boumerdes",
    prefGender: "Both",
    minAge: 18,
    maxAge: 25,
    hobbies: ["Gaming", "Reading"],
  );

  late int i;
  late bool match;

  Prefmodel preferences = Prefmodel(
    id: 0,
    town: "",
    prefGender: "",
    minAge: 0,
    maxAge: 0,
    hobbies: [],
  );

  List<MatchingModel> users = [
    MatchingModel(
      id: 1,
      nom: "Mediene",
      prenom: "Mohamed",
      age: 22,
      sexe: "Male",
      ville: "Boumerdes",
      hobbies: ["Gaming", "Reading", "Hiking"],
    ),
  ];
  Likemodel model = Likemodel(idTransmitter: 0, idReceiver: 0);

  @override
  void initState() {
    match = false;
    fetchData();
    print("matching : ${widget.id}");
    super.initState();
  }

  Future<void> fetchData() async {
    users = await MatchingRemoteDataSource().getMatchings();
    preferences = await PrefRemoteDataSource().getPreferences(widget.id);
    users.removeAt(0);
    filtre();
    setState(() {
      match = true;
      i = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Row(
        children: [
          SizedBox(width: 100),
          Expanded(
            child: Container(
              width: 450,
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "DISCOVER MATCHES",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color.fromARGB(255, 120, 86, 35),
                      fontFamily: "pjs",
                      letterSpacing: 3.2,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Find the",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
                      letterSpacing: -2,
                      height: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Flame ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 230, 128, 26),
                          fontFamily: "pjs",
                          letterSpacing: -2,
                          height: 1,
                        ),
                      ),
                      Text(
                        "to",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          letterSpacing: -2,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "your",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
                      letterSpacing: -2,
                      height: 1,
                    ),
                  ),
                  Text(
                    "Hobby",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
                      letterSpacing: -2,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    "Connect with people who\nshare your intensity. Swipe\nthrough curated profiles of\nlocal enthusiasts.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (match)
                    ? SizedBox(
                        height: 550,
                        width: 400,
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        height: 500,
                                        width: 300,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          color: Color.fromARGB(
                                            255,
                                            248,
                                            231,
                                            224,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              60,
                                            ),
                                            child: (users[i].sexe == "M")
                                                ? Image.asset(
                                                    "assets/man.png",
                                                    height: 420,
                                                    width: 380,
                                                  )
                                                : Image.asset(
                                                    "assets/woman.png",
                                                    height: 420,
                                                    width: 380,
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 280),
                                                Container(
                                                  height: 120,
                                                  width: double.infinity,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 20,
                                                    horizontal: 30,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          40,
                                                        ),
                                                    color: const Color.fromARGB(
                                                      219,
                                                      238,
                                                      238,
                                                      238,
                                                    ),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "${users[i].prenom} ${users[i].nom}",
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                          fontFamily: "pjs",
                                                          color: Color.fromARGB(
                                                            255,
                                                            69,
                                                            49,
                                                            20,
                                                          ),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Image.asset(
                                                            "assets/location.png",
                                                            height: 10,
                                                          ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            users[i].ville,
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily: "pjs",
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    133,
                                                                    98,
                                                                    45,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          (users[i].sexe == "M")
                                                              ? Image.asset(
                                                                  "assets/male.png",
                                                                  height: 10,
                                                                )
                                                              : Image.asset(
                                                                  "assets/female.png",
                                                                  height: 10,
                                                                ),
                                                          SizedBox(width: 5),
                                                          Text(
                                                            (users[i].sexe ==
                                                                    "M")
                                                                ? "Male • ${users[i].age} years old"
                                                                : "Female • ${users[i].age} years old",
                                                            style: TextStyle(
                                                              fontSize: 13,
                                                              fontFamily: "pjs",
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    133,
                                                                    98,
                                                                    45,
                                                                  ),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          Spacer(),
                                                          Container(
                                                            padding:
                                                                EdgeInsets.symmetric(
                                                                  vertical: 5,
                                                                  horizontal: 8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    20,
                                                                  ),
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    244,
                                                                    202,
                                                                    184,
                                                                  ),
                                                            ),
                                                            child: Center(
                                                              child: Row(
                                                                children: [
                                                                  Image.asset(
                                                                    "assets/${users[i].hobbies[0]}.png",
                                                                    height: 10,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 5,
                                                                  ),
                                                                  Text(
                                                                    users[i]
                                                                        .hobbies[0],
                                                                    style: TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontFamily:
                                                                          "pjs",
                                                                      color:
                                                                          Color.fromARGB(
                                                                            255,
                                                                            133,
                                                                            98,
                                                                            45,
                                                                          ),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Row(
                                        children: [
                                          SizedBox(width: 120),
                                          InkWell(
                                            onTap: () {
                                              if (i < users.length - 1) {
                                                i++;
                                              } else {
                                                match = false;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 10),
                                                  ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "assets/dislike.png",
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 40),
                                          InkWell(
                                            onTap: () {
                                              model = Likemodel(
                                                idTransmitter: widget.id,
                                                idReceiver: users[i].id,
                                              );
                                              LikeRemoteDataSource().sendLike(
                                                model,
                                              );
                                              i++;
                                              if (i > users.length - 1) {
                                                match = false;
                                              }
                                              setState(() {});
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    blurRadius: 5,
                                                    spreadRadius: 2,
                                                    offset: Offset(0, 10),
                                                  ),
                                                ],
                                              ),
                                              child: Image.asset(
                                                "assets/like.png",
                                                height: 50,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(width: 20),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Text(
                        "No possible matches for the moment...",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          letterSpacing: -2,
                          height: 1,
                        ),
                      ),
                (match)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          hobby(
                            text: users[i].hobbies[0],
                            icon: "assets/male.png",
                          ),
                          SizedBox(width: 20),
                          (users[i].hobbies.length > 1)
                              ? hobby(
                                  text: users[i].hobbies[1],
                                  icon: "assets/male.png",
                                )
                              : SizedBox.shrink(),
                          SizedBox(width: 20),
                          (users[i].hobbies.length > 2)
                              ? hobby(
                                  text: users[i].hobbies[2],
                                  icon: "assets/male.png",
                                )
                              : SizedBox.shrink(),
                        ],
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(width: 100),
        ],
      ),
    );
  }

  void filtre() {
    users.removeWhere((user) => user.id == widget.id);
    if (preferences.prefGender != "Both") {
      users.removeWhere((user) => user.sexe != preferences.prefGender);
    }

    users.removeWhere(
      (user) => user.age < preferences.minAge || user.age > preferences.maxAge,
    );

    users.removeWhere(
      (user) => !user.hobbies.any((h) => preferences.hobbies.contains(h)),
    );
  }
}

class hobby extends StatefulWidget {
  const hobby({super.key, required this.text, required this.icon});

  final String text;
  final String icon;
  @override
  State<hobby> createState() => _hobbyState();
}

class _hobbyState extends State<hobby> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 244, 202, 184),
      ),
      child: Center(
        child: Row(
          children: [
            Image.asset("assets/${widget.text}.png", height: 15),
            SizedBox(width: 7),
            Text(
              widget.text,
              style: TextStyle(
                fontSize: 12,
                fontFamily: "pjs",
                color: Color.fromARGB(255, 133, 98, 45),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
