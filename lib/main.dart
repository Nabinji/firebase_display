import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_display/CRUDE/crude_operation.dart';

import 'package:flutter/material.dart';

import 'firebase_image_slider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageSliderFirebase(),
      // const CRUDEoperation()

      // StreamBuilder(
      //     stream: FirebaseAuth.instance.authStateChanges(),
      //     builder: (context, snapshot) {
      //       if (snapshot.hasData) {
      //         return const HomePage();
      //       } else {
      //         return const LoginScreen();
      //       }
      //     }),
    );
  }
}
