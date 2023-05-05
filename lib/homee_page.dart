import 'package:firebase_display/splash_screen.dart';
import 'package:flutter/material.dart';

import 'google_login_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            ElevatedButton(
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                await FirebaseServices().googleSignOut();
                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AuthSplashScreen()));
              },
            ),
          ],
          automaticallyImplyLeading: false,
          title: const Text("Auto login"),
        ),
        body: const Center(
          child: Text(
            "Welcome",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
