import 'package:flutter/material.dart';

import 'child.dart';

class Message {
  int id;
  String message;
  String date;
  String childName;
  Gender childgender;
  String senderName;
  bool isSaved;


  Message(
      {required this.id,
      required this.childName,
      required this.message,
      required this.date,
      required this.senderName,
      required this.childgender,
      required this.isSaved});
}
