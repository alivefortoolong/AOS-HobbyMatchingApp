import 'package:aos/presentation/hobbies.dart';
import 'package:aos/presentation/login.dart';
import 'package:aos/presentation/matches.dart';
import 'package:aos/presentation/matching.dart';
import 'package:aos/presentation/notifications.dart';
import 'package:aos/presentation/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Temp extends StatefulWidget {
  const Temp({super.key, required this.id});

  final int id;

  @override
  State<Temp> createState() => _TempState();
}

class _TempState extends State<Temp> {
  late int selectedItem;
  late Widget selectedPage;

  @override
  void initState() {
    selectedItem = 1;
    selectedPage = Matching(id: 8);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 244, 239),
      body: Row(
        children: [
          Container(
            width: 300,
            height: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  spreadRadius: 5,
                  offset: Offset(0, 0),
                ),
              ],
              color: Color.fromARGB(255, 248, 231, 224),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "The Kenetic Hearth",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 50),
                sidebarItem(
                  text: "Matching",
                  icon: "assets/matching.png",
                  iconS: "assets/matchingS.png",
                  indice: 1,
                  selected: selectedItem,
                  updt: update,
                ),
                sidebarItem(
                  text: "Matches",
                  icon: "assets/matches.png",
                  iconS: "assets/matchesS.png",
                  indice: 2,
                  selected: selectedItem,
                  updt: update,
                ),
                sidebarItem(
                  text: "Profiles",
                  icon: "assets/profile.png",
                  iconS: "assets/profileS.png",
                  indice: 3,
                  selected: selectedItem,
                  updt: update,
                ),
                Spacer(),
                InkWell(
                  onTap: () async {
                    showDialogBox(context);
                  },
                  child: Row(
                    children: [
                      Image.asset("assets/Logout.png", height: 10),
                      SizedBox(width: 3),
                      Text("Logout"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 60),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          selectedItem = 5;
                          selectedPage = Notifications(update: update2, id: 1);
                          setState(() {});
                        },
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: Image.asset(
                          selectedItem == 5
                              ? "assets/notif2.png"
                              : "assets/notif1.png",
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: selectedPage),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void update2(int id) {
    selectedPage = Profile(key: UniqueKey(), id: id, ext: true, fct: update3);
    setState(() {});
  }

  void update3() {
    selectedPage = Hobbies(id: widget.id);
    setState(() {});
  }

  Route animation(Widget dest) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dest,
    );
  }

  void update(int newS) {
    selectedItem = newS;
    if (selectedItem == 1) {
      selectedPage = Matching(id: widget.id);
    }
    if (selectedItem == 2) {
      selectedPage = Matches(update: update2, id: widget.id);
    }
    if (selectedItem == 3) {
      selectedPage = Profile(
        key: UniqueKey(),
        id: widget.id,
        ext: false,
        fct: update3,
      );
    }
    setState(() {});
  }

  void showDialogBox(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: "a",
      barrierColor: Colors.black.withOpacity(0.9),
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Material(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 450,
              width: 440,
              padding: EdgeInsets.symmetric(horizontal: 40),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 248, 231, 224),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "pjs",
                      fontSize: 30,
                      color: Color.fromARGB(255, 69, 49, 20),
                    ),
                    child: Text("Log out?"),
                  ),
                  SizedBox(height: 10),
                  DefaultTextStyle(
                    style: TextStyle(
                      fontFamily: "pjs",
                      fontSize: 20,
                      color: Color.fromARGB(255, 69, 49, 20),
                    ),
                    child: Text(
                      "You can always log back in at any\ntime. If you just want to switch\naccounts, you can do that by adding\nan existing account. ",
                    ),
                  ),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      await prefs.remove('token');
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
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
                      child: Center(
                        child: Text(
                          "Log out",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "pjs",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: double.infinity,
                      height: 55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.transparent,
                        border: Border.all(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          width: 0.7,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            fontFamily: "pjs",
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class sidebarItem extends StatelessWidget {
  const sidebarItem({
    super.key,
    required this.indice,
    required this.selected,
    required this.updt,
    required this.text,
    required this.icon,
    required this.iconS,
  });

  final String text;
  final String icon;
  final String iconS;
  final int indice;
  final int selected;
  final Function updt;

  @override
  Widget build(BuildContext context) {
    bool isSelected = indice == selected;

    return InkWell(
      onTap: () {
        updt(indice);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: EdgeInsets.only(bottom: 5),
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
          color: isSelected
              ? Color.fromARGB(255, 251, 202, 180)
              : Color.fromARGB(255, 248, 231, 224),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            isSelected
                ? Image.asset(iconS, height: 17)
                : Image.asset(icon, height: 15),
            SizedBox(width: 10),
            Text(
              text,
              style: TextStyle(
                fontSize: 15,
                fontFamily: "pjs",
                color: isSelected
                    ? Color.fromARGB(255, 69, 49, 20)
                    : Color.fromARGB(255, 93, 67, 27),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
