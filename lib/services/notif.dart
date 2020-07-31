import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_support/overlay_support.dart';

class NotificationHandler {
  String serverToken =
      'AAAAJGnT0rA:APA91bEH1BT3R2nQrFmamOlKwz82wF2pCI0JY6qM5DfzQtN-TDrT1Fj_keaqtx-3Urx7jOsAZd0553_0_-rC6Td6J4HeHmm5s0SqcgzEHT8WwSFnB_6rXCWoc3EQzpHPBFsYuMj2imTD';

  NotificationHandler._();
  String token;
  factory NotificationHandler() => instance;
  static final NotificationHandler instance = NotificationHandler._();
  final FirebaseMessaging fcm = FirebaseMessaging();
  bool initialized = false;

  Future<String> init(context) async {
    if (!initialized) {
      fcm.requestNotificationPermissions();
      fcm.configure(
          onMessage: (message) async {
            showSimpleNotification(
              Text(
                message['notification']['body'],
              ),
              autoDismiss: true,
              background: Colors.black,
              foreground: Colors.white,
              duration: Duration(seconds: 5),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 4, vertical: 0),
              position: NotificationPosition.bottom,
            );
          },
          onResume: (message) async {});

      // For testing purposes print the Firebase Messaging token
      token = await fcm.getToken();
      initialized = true;
    }
    return token;
  }
}
