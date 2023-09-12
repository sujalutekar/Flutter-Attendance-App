import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/my_text_field.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: isEditing
          ? null
          : FloatingActionButton(
              onPressed: () {
                setState(() {
                  isEditing = true;
                });
              },
              child: const Icon(Icons.edit),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: deviceHeight * 0.22,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.pink,
                        Colors.deepPurple,
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  height: deviceHeight * 0.24,
                  margin: const EdgeInsets.only(left: 25),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 55,
                        child: Icon(
                          Icons.person,
                          size: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          return Text(
                            '${snapshot.data!.get('name')}',
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                emailController.text = snapshot.data!.get('email');
                nameController.text = snapshot.data!.get('name');

                return Column(
                  children: [
                    MyTextField(
                      title: 'Name',
                      controller: nameController,
                      enabled: isEditing ? true : false,
                    ),
                    MyTextField(
                      title: 'Email',
                      controller: emailController,
                      enabled: isEditing ? true : false,
                    ),
                    // MyTextField(
                    //   title: 'Phone No.',
                    // ),
                  ],
                );
              },
            ),
            isEditing
                ? Container(
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                      ),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              isEditing = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.black12,
                            width: deviceWidth * 0.5,
                            child: const Center(
                              child: Text('Cancel'),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            color: Colors.black45,
                            width: deviceWidth * 0.5,
                            child: const Center(
                              child: Text('Save'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
