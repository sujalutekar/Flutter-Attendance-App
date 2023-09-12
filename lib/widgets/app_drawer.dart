import 'package:attendence/pages/profile_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../pages/history_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(currentUser?.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 26,
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                      '${snapshot.data?.get("name")}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    subtitle: Text(
                      '${snapshot.data?.get("email")}',
                      style: const TextStyle(
                          fontWeight: FontWeight.w400, color: Colors.black),
                    ),
                  );
                }),
            const Divider(thickness: 2),

            // Profile Tile
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              leading: const Icon(
                Icons.person,
                size: 36,
              ),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 16),
              ),
            ),

            // History Tile
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HistoryPage(),
                  ),
                );
              },
              leading: const Icon(
                Icons.history,
                size: 36,
              ),
              title: const Text(
                'History',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const Spacer(),

            // Logout Tile
            ListTile(
              onTap: () {
                FirebaseAuth.instance.signOut();
              },
              leading: const Icon(
                Icons.logout,
                size: 36,
              ),
              title: const Text(
                'LogOut',
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
