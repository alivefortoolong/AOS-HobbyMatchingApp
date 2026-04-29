import 'package:aos/data/PrefModel.dart';
import 'package:aos/data/PrefRemoteDataSource.dart';
import 'package:flutter/material.dart';

import 'profile.dart';

class Hobbies extends StatefulWidget {
  const Hobbies({super.key, required this.id});

  final int id;

  @override
  State<Hobbies> createState() => _HobbiesState();
}

class _HobbiesState extends State<Hobbies> {
  Prefmodel prefs = Prefmodel(
    id: 0,
    prefGender: "",
    minAge: 0,
    maxAge: 0,
    hobbies: ["Gaming", "Reading"],
  );

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    prefs = await PrefRemoteDataSource().getPreferences(widget.id);
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
              Text(
                "Hobbies",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Color.fromARGB(255, 69, 49, 20),
                  fontFamily: "pjs",
                  letterSpacing: -2,
                  height: 1,
                ),
              ),
              SizedBox(height: 60),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: prefs.hobbies.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 15,
                  childAspectRatio: 250 / 350,
                ),
                itemBuilder: (context, i) {
                  return hobby(txt: prefs.hobbies[i], img: 'pg');
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
