import 'package:aos/data/notifModel.dart';
import 'package:aos/data/notifRemoteDataSource.dart';
import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, required this.update, required this.id});

  final Function update;
  final int id;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  // List<User> users = [
  //   User(
  //     id: 1,
  //     nom: "Benali",
  //     prenom: "Yacine",
  //     sexe: "male",
  //     hobbies: ["Football", "Travel"],
  //   ),
  //   User(
  //     id: 2,
  //     nom: "Zeroual",
  //     prenom: "Lina",
  //     sexe: "female",
  //     hobbies: ["Photography", "Art"],
  //   ),
  //   User(
  //     id: 3,
  //     nom: "Kaci",
  //     prenom: "Amine",
  //     sexe: "male",
  //     hobbies: ["Gaming", "Tech"],
  //   ),
  //   User(
  //     id: 4,
  //     nom: "Meziane",
  //     prenom: "Nassim",
  //     sexe: "male",
  //     hobbies: ["Fitness", "Boxing"],
  //   ),
  //   User(
  //     id: 5,
  //     nom: "Boukhalfa",
  //     prenom: "Sara",
  //     sexe: "female",
  //     hobbies: ["Music", "Dance"],
  //   ),
  // ];

  List<NotifModel> users = [
    NotifModel(id: 0, nom: "", prenom: "", message: ""),
  ];

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchData() async {
    users = await NotifRemoteDataSource().getNotifications(widget.id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Color.fromARGB(255, 255, 224, 211),
                    ),
                    child: Text(
                      "SOCIAL FEED",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                        color: Color.fromARGB(255, 146, 105, 44),
                        fontFamily: "pjs",
                        letterSpacing: 3.2,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your newest sparks &\ninterests.",
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
              SizedBox(height: 30),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: users.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 250 / 60,
                ),
                itemBuilder: (context, i) {
                  return notif(
                    nom: users[i].nom,
                    prenom: users[i].prenom,
                    update: widget.update,
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class notif extends StatefulWidget {
  const notif({
    super.key,
    required this.nom,
    required this.prenom,
    required this.update,
  });

  final String nom;
  final String prenom;

  final Function update;

  @override
  State<notif> createState() => _notifState();
}

class _notifState extends State<notif> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.update();
      },
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 248, 231, 224),
        ),
        child: Row(
          children: [
            Image.asset("assets/notifman.png", height: 60),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.nom} ${widget.prenom} Liked your profile",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
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
