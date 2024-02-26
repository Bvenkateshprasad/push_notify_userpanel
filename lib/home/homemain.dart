import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notify_user_app/widgets/common.dart';
import '../auth/login.dart';
import '../pushnotifier/push_main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();

    PushNotificationsSystem pushNotificationsSystem = PushNotificationsSystem();
    pushNotificationsSystem.whenNotificationReceived(context);
    pushNotificationsSystem.generateDeviceRecognitionToken();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(name.toString()),
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const LoginScreen()));
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Text(FirebaseAuth.instance.currentUser!.uid.toString()),
      ),
    );
  }
}
