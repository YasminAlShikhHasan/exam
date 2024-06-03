import 'package:exam/core.dart';
import 'package:exam/model/model.dart';
import 'package:exam/services/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: core.get<SharedPreferences>().getString("newUserName") == null
          ? HomePage()
          : Produced(),
    );
  }
}

class Produced extends StatelessWidget {
  Produced({super.key});

  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => InviteFriends()));
            },
            child: const Icon(
              Icons.home,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.black,
          actions: [
            Icon(
              Icons.delete,
              color: Colors.white,
            )
          ],
          title: const Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.green,
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    "Invite Friends",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 24),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: 500,
              child: TextField(
                controller: search,
                decoration: InputDecoration(
                    hintText: "search here",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
          ),
          FutureBuilder(
              future: GetDataImp().getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<People> result = List.generate(
                      snapshot.data!.length, (index) => snapshot.data![index]);
                  return Expanded(
                    child: ListView.builder(
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(result[index].name),
                            leading: CircleAvatar(
                                child: Image.network(result[index].image)),
                            subtitle: Text(result[index].date),
                          );
                        }),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              })
        ]));
  }
}

class HomePage extends StatelessWidget {
  HomePage({super.key});
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 100,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("r",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800)),
                  Text("ii",
                      style: TextStyle(
                          color: Colors.green,
                          fontSize: 40,
                          fontWeight: FontWeight.w800)),
                  Text("de",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            Container(
              width: 800,
              height: 100,
              child: Center(
                child: Text(
                  "Welcome to Riide",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: username,
                onChanged: (value) {
                  core.get<SharedPreferences>().setString("newUserName", value);
                },
                decoration: InputDecoration(
                    filled: true,
                    hintText: "enter email or password",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.black,
                    label: Text(
                      "username",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: password,
                decoration: InputDecoration(
                    filled: true,
                    hintText: "enter your password",
                    hintStyle: TextStyle(color: Colors.white),
                    fillColor: Colors.black,
                    label: Text(
                      "password",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 20,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Remember me",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Forggot Password",
                      style: TextStyle(color: Colors.blue),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => Produced())));
              },
              child: Container(
                width: 500,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                child: Center(
                  child: Text(
                    "sign in",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account ?",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "Sign up",
                  style: TextStyle(color: Colors.blue),
                )
              ],
            )
          ],
        ));
  }
}

class InviteFriends extends StatelessWidget {
  const InviteFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            width: 1000,
            height: 200,
            color: Colors.black,
            child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Text(
                    "Invite Friends",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800),
                  ),
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ]),
          ),
          Container(
            width: 600,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: Image.asset("images/picture.png").image,
                    fit: BoxFit.fill)),
          ),
          Container(
            color: Colors.black,
            width: 300,
            height: 30,
            child: const Center(
                child: Text(
              "Invite Friends",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w800),
            )),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              color: Colors.black,
              width: 600,
              height: 60,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Sign up afriend with your referral\n code and earn Ride and free rides",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                width: 500,
                height: 30,
                child: const Text("Share your invite code",
                    style: TextStyle(
                      color: Colors.white,
                    ))),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.green),
            width: 500,
            height: 30,
            child: const Center(
                child: Text(
              "Invite Friends",
              style: TextStyle(color: Colors.white),
            )),
          )
        ]));
  }
}
