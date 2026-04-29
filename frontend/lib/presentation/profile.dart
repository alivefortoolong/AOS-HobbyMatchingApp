import 'package:aos/data/profileModel.dart';
import 'package:aos/data/profileRemoteDataSource.dart';
import 'package:aos/presentation/register2.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({
    super.key,
    required this.id,
    required this.ext,
    required this.fct,
  });

  final int id;
  final bool ext;
  final Function fct;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileModel user = ProfileModel(
    id: 0,
    nom: "",
    prenom: "",
    age: 0,
    ville: "",
    sexe: "",
    link: "",
    hobbies: ["Reading", "Hiking"],
  );

  @override
  void initState() {
    fetchProfile();
    print("profile : ${widget.id}");
    super.initState();
  }

  Future<void> fetchProfile() async {
    user = await ProfileRemoteDataSource().getProfile(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    height: 400,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: Offset(0, 25),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),

                      child: (user.sexe == "M")
                          ? Image.asset("assets/man.png", fit: BoxFit.cover)
                          : Image.asset("assets/woman.png", fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 300,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 234, 224),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Personal Identity",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Color.fromARGB(255, 66, 47, 18),
                            fontFamily: "pjs",
                          ),
                        ),
                        SizedBox(height: 20),
                        infoRow(t1: "Sexe", t2: user.sexe),
                        infoRow(t1: "Age", t2: user.age.toString()),
                        infoRow(t1: "Town", t2: user.ville),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Social Media",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 69, 49, 20),
                                fontFamily: "pjs",
                              ),
                            ),
                            InkWell(
                              onTap: () => openLink(user.link),
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: 5,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: Color.fromARGB(255, 255, 224, 211),
                                ),
                                child: Image.asset(
                                  "assets/link.png",
                                  height: 15,
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
              SizedBox(width: 40),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Color.fromRGBO(192, 209, 255, 1),
                        ),
                        child: Text(
                          "PROFILE SPOTLIGHT",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                            color: Color.fromRGBO(0, 66, 156, 1),
                            fontFamily: "pjs",
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        user.prenom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                          height: 1,
                        ),
                      ),
                      Text(
                        user.nom,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color.fromARGB(255, 214, 126, 37),
                          fontFamily: "pjs",
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Adventure seeker who loves ${user.hobbies[0]} and ${user.hobbies[1]}.\nLooking for like-minded friends to share experiences, laughter, and\ncreativity together, exploring new places, trying unique\nfoods, and enjoying spontaneous adventures.",
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(255, 69, 49, 20),
                          fontFamily: "pjs",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Container(
                    width: 600,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Color.fromARGB(255, 250, 250, 250),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 15,
                          spreadRadius: 1,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset("assets/interests.png", height: 40),
                        SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Discovery Interests",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Color.fromARGB(255, 66, 47, 18),
                                fontFamily: "pjs",
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "${user.prenom} is currently looking for partners in ${user.hobbies.length} specialized\nhobby categories. Explore his curated list to see if there's\na spark.",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 69, 49, 20),
                                fontFamily: "pjs",
                              ),
                            ),
                            SizedBox(height: 30),
                            SizedBox(
                              width: 250,
                              child: btn(
                                text: (widget.ext)
                                    ? "Hobbies"
                                    : "Edit Interests",
                                dest: Register2(edit: true, editid: widget.id),
                                ext: widget.ext,
                                fct: widget.fct,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      hobby(txt: "Photography", img: "pg"),
                      SizedBox(width: 20),
                      hobby(txt: "Architecture", img: "archi"),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openLink(String link) async {
    final Uri url = Uri.parse(link);

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Route animation(Widget dest) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => dest,
    );
  }
}

class hobby extends StatelessWidget {
  const hobby({super.key, required this.txt, required this.img});

  final String txt;
  final String img;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.asset(
            'assets/$img.png',
            width: 290,
            height: 290,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 220),
              Text(
                txt,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class infoRow extends StatelessWidget {
  const infoRow({super.key, required this.t1, required this.t2});

  final String t1;
  final String t2;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t1,
            style: TextStyle(
              fontSize: 15,
              color: Color.fromARGB(255, 69, 49, 20),
              fontFamily: "pjs",
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color.fromARGB(255, 255, 224, 211),
            ),
            child: Text(
              (t2 == "M")
                  ? "Male"
                  : (t2 == "F")
                  ? "Female"
                  : t2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
                color: Color.fromARGB(255, 146, 105, 44),
                fontFamily: "pjs",
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class btn extends StatefulWidget {
  const btn({
    super.key,
    required this.text,
    required this.dest,
    required this.ext,
    required this.fct,
  });

  final String text;
  final Widget dest;
  final bool ext;
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
          onTap: () {
            if (widget.ext) {
              widget.fct();
            } else {
              Navigator.of(context).push(animation(widget.dest));
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
