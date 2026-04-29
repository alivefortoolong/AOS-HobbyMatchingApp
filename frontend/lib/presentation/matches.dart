import 'package:aos/data/matchesModel.dart';
import 'package:aos/data/matchesRemoteDataSource.dart';
import 'package:aos/data/userModel.dart';
import 'package:flutter/material.dart';

class Matches extends StatefulWidget {
  const Matches({super.key, required this.update, required this.id});

  final Function update;
  final int id;

  @override
  State<Matches> createState() => _MatchesState();
}

class _MatchesState extends State<Matches> {
  List<MatchesModel> users = [
    MatchesModel(
      matchId: 1,
      matchedAt: "",
      user: UserModel(
        id: 1,
        userId: 1,
        nom: "",
        prenom: "",
        sexe: "",
        age: 0,
        ville: "",
        link: "",
        hobbies: ["Football", "Football"],
      ),
    ),
  ];

  @override
  void initState() {
    fetchData();
    print("matches : ${widget.id}");
    super.initState();
  }

  Future<void> fetchData() async {
    users = await MatchesRemoteDataSource().getMatches(widget.id);
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
                  Text(
                    "SOCIAL CONNECTIONS",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Color.fromARGB(255, 146, 105, 44),
                      fontFamily: "pjs",
                      letterSpacing: 3.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Your matches",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
                      letterSpacing: -2,
                      height: 1,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "These kinetic connections are waiting for a spark. Reach out and\nstart your next shared adventure today.",
                    style: TextStyle(
                      fontSize: 15,
                      color: Color.fromARGB(255, 69, 49, 20),
                      fontFamily: "pjs",
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
                  crossAxisCount: 3,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 25,
                  childAspectRatio: 250 / 350,
                ),
                itemBuilder: (context, i) {
                  return match(
                    id: users[i].user.id,
                    nom: users[i].user.nom,
                    prenom: users[i].user.prenom,
                    sexe: users[i].user.sexe,
                    hobbies: users[i].user.hobbies,
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

class match extends StatefulWidget {
  const match({
    super.key,
    required this.id,
    required this.nom,
    required this.prenom,
    required this.sexe,
    required this.hobbies,
    required this.update,
  });

  final int id;
  final String nom;
  final String prenom;
  final String sexe;
  final List<String> hobbies;
  final Function update;

  @override
  State<match> createState() => _matchState();
}

class _matchState extends State<match> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 250,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: (widget.sexe == "M")
                    ? AssetImage('assets/man.png')
                    : AssetImage('assets/woman.png'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(40),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "${widget.nom} ${widget.prenom}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: "pjs",
                    fontSize: 14,
                    color: const Color.fromARGB(255, 225, 225, 225),
                  ),
                ),
                Text(
                  (widget.hobbies.isNotEmpty)
                      ? "${widget.hobbies[0]} • ${widget.hobbies[1]}"
                      : widget.hobbies[0],
                  style: TextStyle(
                    fontFamily: "pjs",
                    fontSize: 12,
                    color: Color.fromARGB(255, 225, 225, 225),
                  ),
                ),
                SizedBox(height: 10),
                btn2(id: widget.id, text: "See profile", update: widget.update),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class btn2 extends StatefulWidget {
  const btn2({
    super.key,
    required this.id,
    required this.text,
    required this.update,
  });

  final int id;
  final String text;
  final Function update;

  @override
  State<btn2> createState() => _btn2State();
}

class _btn2State extends State<btn2> {
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
            widget.update(widget.id);
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
