import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_notification_listener/flutter_notification_listener.dart';
import 'dart:isolate';
import 'dart:ui';
import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../main.dart';

class ChildUncompleteController extends GetxController {
  List<NotificationEvent> _log = [];
  bool started = false;
  bool _loading = false;
  bool flag = false;
  ReceivePort port = ReceivePort();

  Crud crud = Crud();
  bool isLoading = false;

  String? name;
  String? age;
  int? isActive;
  String? gender;

  final myServerUrl = 'http://192.168.8.102:5000/';

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  // we must use static method, to handle in background
  static void _callback(NotificationEvent evt) {
    // HANDLING BACKGROUND NOTIFICATIONS :
    // print('GETTING INFO ');
    // print(evt.packageName); // PACKAGE USE TO SEND MESSAGE :
    // print(evt.text); // MESSAGE CONTENT  :
    // print(evt.title); //SENDER NUMBER: OR HEADER

    final SendPort? send = IsolateNameServer.lookupPortByName("_listener_");
    if (send == null) print("can't find the sender");
    send?.send(evt);
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    NotificationsListener.initialize(callbackHandle: _callback);

    // this can fix restart<debug> can't handle error
    IsolateNameServer.removePortNameMapping("_listener_");
    IsolateNameServer.registerPortWithName(port.sendPort, "_listener_");
    port.listen((message) => onData(message));

    // don't use the default receivePort
    // NotificationsListener.receivePort.listen((evt) => onData(evt));

    bool? isR = await NotificationsListener.isRunning;
    print("""Service is ${isR == false ? "not " : ""}aleary running""");

    started = isR!;
    update();
  }

  Future<void> onData(NotificationEvent event) async {
    _log.add(event);
    update();

    if (!event.packageName!.contains("example")) {
      // TODO: fix bug
      // NotificationsListener.promoteToForeground("");
    }
    // print('GETTING INFO FRONT APP ');
    // print(event.packageName); // PACKAGE USE TO SEND MESSAGE :
    // print(event.text); // MESSAGE CONTENT  :
    // print(event.title); //SENDER NUMBER: OR HEADER

    if (event.packageName == 'com.whatsapp' && event.id != 0) {
      //kik.android
      String label = await getMsgLabel(event.text.toString());
      print("after getMsgLabel(): ${label}");

      if (label == 'NOT_APROP') {
        storeMsg(event);
      }
    }
  }

  void startListening() async {
    print("start listening");

    _loading = true;
    update();

    bool? hasPermission = await NotificationsListener.hasPermission;
    if (hasPermission == false) {
      print("no permission, so open settings");
      NotificationsListener.openPermissionSettings();
      return;
    }

    bool? isR = await NotificationsListener.isRunning;

    if (isR == false) {
      await NotificationsListener.startService(
          title: "we still with you ", description: "payai from feelsafe");
    }
    //if he agree
    flag = true;
    activateC();
    started = true;
    _loading = false;
    update();
  }

  void stopListening() async {
    print("stop listening");

    _loading = true;
    update();

    await NotificationsListener.stopService();

    started = false;
    _loading = false;
    update();
  }

  Future<String> getMsgLabel(String text) async {
    //url to send the post request to
    final url = myServerUrl;
    // print(text);
    //sending a post request to the url
    final response =
        await http.post(Uri.parse(url), body: json.encode({'message': text}));

    //converting the fetched data from json to key value pair that can be displayed on the screen
    final decoded = json.decode(response.body) as Map<String, dynamic>;

    //changing the UI be reassigning the fetched data to final response{
    return decoded['message'];
  }

  void storeMsg(NotificationEvent msg) async {
    print(
        "child_name: $name , parent_id: ${sharedPref.getString('parent_id')}");

    var response = await crud.postRequest2(linkStoreMsg, {
      "child_name": name,
      "sender": msg.title.toString(),
      "date_time": msg.createAt.toString().substring(0, 19).toString(),
      "content": msg.text,
      "parent_id": sharedPref.getString('parent_id'),
    });
    print("response ${response}");
  }

  activateC() async {
    isLoading = true;
    var response = await crud.postRequest(linkactivateChild, {
      "child_name": name,
      "parent_id": sharedPref.getString("parent_id"),
    });
    isLoading = false;
    if (response != null && response["status"] != "fail") {
      isActive = 1;
      update();
      //?
      // sharedPref.clear();
    } else {
      print("activate fail");
    }
  }
}
