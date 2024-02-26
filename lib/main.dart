import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notify_user_app/auth/login.dart';
import 'package:notify_user_app/home/homemain.dart';
import 'package:notify_user_app/home/secondpage.dart';
import 'package:notify_user_app/home/third.dart';
import 'package:notify_user_app/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Note App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      routes: {
        '/home': (context) => SecondPage(
              name: "0",
              phone: "0",
            ),
        '/home1': (context) => const ThirdPage(),
        // Define other routes here
      },
      home: MySplashScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      return const HomePage();
    } else {
      return const LoginScreen();
    }
  }
}
