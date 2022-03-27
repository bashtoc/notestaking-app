import 'package:bioself/screens/constants.dart';
import 'package:bioself/screens/notes.dart';
import 'package:bioself/screens/profile.dart';
import 'package:bioself/screens/write_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../models/user_management.dart';
import 'login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var dateTime = DateFormat('yMMMd').format(DateTime.now());
  int index = 0;
  String title = '';

  final _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Builder(
              builder: (context) => IconButton(
                  icon: (SvgPicture.asset(
                    'assets/Component 3.svg',
                    height: 15,
                    width: 15,
                    color: Colors.black,
                  )),
                  onPressed: () => Scaffold.of(context).openDrawer()),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'SAFE SPACE',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 25,
              width: 25,
              child: FloatingActionButton(
                  elevation: 0,
                  backgroundColor: Colors.black,
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: (20),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WriteField()));
                  }),
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            const SizedBox(
              height: 150,
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Profile()));
              },
              child: Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                decoration:
                    const BoxDecoration(border: Border(), color: buttonColor),
                child: const Text(
                  'profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            TextButton(
              onPressed: () {
                _auth.signOut()
                    .then((user) => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                        LogIn())));
              },
              child: const Text(
                'LogOut',
                style: TextStyle(color: buttonColor, fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            const SizedBox(
              height: 40,
              width: 40,
            )
          ],
        ),
      ),
      backgroundColor: Colors.white,
      body: const HomeBody(),
    );
  }
}

class HomeBody extends StatefulWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  CollectionReference dbCollection =
      FirebaseFirestore.instance.collection('Notes');

  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {

    return StreamBuilder<QuerySnapshot>(

      stream: dbCollection.doc(user!.uid).collection('MyNotes').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('Error fetching data'),
              );
            }
            return const Center(
              child: Text(
                'No notes added yet !',
                style: TextStyle(fontSize: 19, color: Colors.grey),
              ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              child: ListView(
                   reverse: true,
                shrinkWrap: true,


                children: [
                  ...snapshot.data!.docs.map((data) {
                    String title = data.get('title');
                    final time = data.get('time');
                    String body = data.get('story');
                    String id = data.id;
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => Notes(
                                story: body,
                                title: title,
                                time: time,
                              ),
                            ),
                          );
                        },
                        title: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: buttonColor),),
                        subtitle: Text("$time"),
                        trailing: IconButton(
                            onPressed: () {
                              AlertDialog alert = AlertDialog(
                                  title: const Text('post delete alert'),
                                  content: const Text(
                                      'Are you sure you want to delete post'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('cancel'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        DbHelper().delete(id: id).then((value) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                                  SnackBar(content: Text(value)));
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: const Text('Delete'),
                                    ),
                                  ]);

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alert;
                                },
                              );
                            },
                            icon: const Icon(Icons.drag_handle)),
                      ),
                    );
                  }),
                  const SizedBox(
                    height: 80,
                  )
                ].reversed.toList(),
              ),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
