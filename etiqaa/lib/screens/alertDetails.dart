import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/screens/alertHistory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../models/child.dart';
import '../models/message.dart';
import 'homepage.dart';

late int idM;
late bool save;

class AlertDetails extends StatelessWidget {
  final int id;
  final String name;
  final String date;
  final String sender;
  final String content;
  final Gender gender;
  final bool isSaved;

  const AlertDetails({
    Key? key,
    required this.name,
    required this.date,
    required this.sender,
    required this.content,
    required this.gender,
    required this.id,
    required this.isSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    save = isSaved;
    idM = id;
    bool isVisible = true;
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 270.h,
            child: Container(
              color: const Color.fromRGBO(236, 235, 241, 1),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 25.w,
                        color: Colors.black,
                        onPressed: () {
                          //Get.back();
                          if (save) {
                            Get.off(AlertHistory());
                          } else {
                            Get.off(HomePage());
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        gender == Gender.Boy
                            ? Image.asset('images/boyIcon_c.png')
                            : Image.asset('images/girlIcon_c.png'),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10.w, vertical: 5.h),
                          child: Text(
                            '$name',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        'الوقت',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        '$date',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        'المرسل',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        '$sender',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        'العبارة',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.w),
                      child: Text(
                        '$content',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                  ),
                  save == false
                      ? Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.h),
                              child: Center(
                                child: Text(
                                  'هل تريد حفظ الرسالة؟',
                                  style: Theme.of(context).textTheme.headline1,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 20.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SizedBox(
                                    height: 40.h,
                                    width: 100.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // ignore: deprecated_member_use
                                        primary: const Color(0xF0F9AF4B),
                                      ),
                                      onPressed: () {
                                        saveMessage();
                                      },
                                      child: Text(
                                        'نعم',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40.h,
                                    width: 100.w,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        // ignore: deprecated_member_use
                                        primary: const Color(0xF0F9AF4B),
                                      ),
                                      onPressed: () {
                                        deleteMessage();

                                        Get.off(HomePage());
                                      },
                                      child: Text(
                                        'لا',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : Container(),
                ]),
          ),
        ],
      ),
    );
  }
}

Crud _crud = Crud();
deleteMessage() async {
  var response = await _crud.postRequest2(linkdeleteMessages, {
    'msg_id': idM.toString(),
  });

  // response = jsonDecode(response.toString());
  print(response.toString());
  if (response != null && response["statues"] == "success") {
    save = true;
  } else {
    print("delete fail");
  }
}

saveMessage() async {
  var response = await _crud.postRequest2(linkSaveMessage, {
    'msg_id': idM.toString(),
  });

  // response = jsonDecode(response.toString());
  print(response.toString());
  if (response != null && response["statues"] == "success") {
    save = true;
    Get.off(AlertHistory());
  } else {
    print("save fail");
  }
}

List<Message> messageList = [];
