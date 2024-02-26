import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:notify_user_app/home/secondpage.dart';

import '../widgets/common.dart';

class PushNotificationsSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //notifications arrived/received
  Future whenNotificationReceived(BuildContext context) async {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        print(" appppleeeee ${remoteMessage.data['type']}");
        if (remoteMessage.data['type'] == 'chat') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => SecondPage(
                  name: remoteMessage.data['name'],
                  phone: remoteMessage.data['phone'],
                ),
              ));
        }
        //open app and show notification data

        showNotificationWhenOpenApp(
          remoteMessage.data,
          context,
        );
      }
    });

    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //directly show notification data
        showNotificationWhenOpenApp(
          remoteMessage.data,
          context,
        );
      }
    });

    //3. Background

    //When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        print(" appppleeeee ${remoteMessage.data['type']}");
        if (remoteMessage.data['type'] == 'chat') {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (c) => SecondPage(
                  name: remoteMessage.data['name'],
                  phone: remoteMessage.data['phone'],
                ),
              ));
       
        }
        showNotificationWhenOpenApp(
          remoteMessage.data,
          context,
        );
      }
    });
  }

  //device recognition token
  Future generateDeviceRecognitionToken() async {
    String? registrationDeviceToken = await messaging.getToken();

    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({
      "userDeviceToken": registrationDeviceToken,
    });

    messaging.subscribeToTopic("allUsers");
  }

  showNotificationWhenOpenApp(userOrderId, context) {
    showReusableSnackBar(context, "Your code works (# $userOrderId) ");
  }
}
