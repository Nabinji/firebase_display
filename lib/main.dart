import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_display/CRUDE/crude_operation.dart';


import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color.fromARGB(255, 224, 90, 241),
        ),
        home: const CRUDEoperation()

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
