import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/widgets/messagesCards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../models/child.dart';
import '../models/message.dart';
import '../widgets/curvedAppbar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'alertDetails.dart';
import 'homepage.dart';

Gender getGender(String gender) {
  switch (gender) {
    case 'ذكر':
      return Gender.Boy;
    case 'أنثى':
      return Gender.Girl;
    default:
      return Gender.Boy;
  }
}

Crud _crud = Crud();

List msgidi = [];
int msgSaved = 0;
List msgchild = [];
bool msg = false;
messages() async {
  List response = await _crud.getRequest(linkAllMessages);
  for (int i = 0; i < response.length; i++) {
    if (response[i]['parent_id'].toString() ==
        sharedPref.getString('parent_id')) {
      msgidi.add(response[i]['msg_id']);
      msgchild.add(response[i]['child_name']);
      msg = true;
    } else {}
  }
  if (msg == true) {
    allMessages();
  }
}

List<Message> messageList = [];

int msgNumber = 0;
allMessages() async {
  messageList = [];

  print(msgidi.toString());
  print(msgchild.toString());

  for (int i = 0; i < msgidi.length; i++) {
    var response = await _crud.postRequest(linkAlertHistory, {
      'msg_id': (msgidi[i].toString()),
    });

    print("response.toString() : ${response[0]["statues"].toString()}");

    if (response != null && response[0]["statues"] == "success") {
      var responseChild = await _crud.postRequest2(linkChild, {
        'child_name': msgchild[i].toString(),
        'parent_id': sharedPref.getString('parent_id'),
      });
      print(responseChild.toString());
      if (responseChild != null && responseChild[0]['statues'] == "success") {
        // AsyncSnapshot snap = responseChild;
        print(response.toString());
        // response = jsonEncode(response.toString());
        print(responseChild[0]['gender']);
        messageList.add(
          Message(
              id: int.parse(msgidi[i].toString()),
              childName: msgchild[i],
              childgender: getGender(responseChild[0]['gender']),
              message: response[0]['content'],
              date: response[0]['date_time'].toString(),
              senderName: response[0]['sender'],
              isSaved: true),
        );
        msgNumber++;
        print("messageList.length : ${messageList.length}");
      } else {
        print('Child fail');
      }
    } else {
      print('Msg fail');
    }
  }
}

class AlertHistory extends StatefulWidget {
  @override
  State<AlertHistory> createState() => _AlertHistoryState();
}

class _AlertHistoryState extends State<AlertHistory> {
  @override
  void initState() {
    msgidi = [];
    msgchild = [];
    messages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-1.0.h, -0.7.h),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 120.h,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
            clipper: CurvedAppbar(),
            child: Container(
              height: 250.h,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Theme.of(context).accentColor,
                    Theme.of(context).primaryColor,
                  ],
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Image.asset(
                    'images/whiteLogo.png',
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
              ),
            )),
      ),
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 2,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates_outlined,
              size: 30,
            ),
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Get.to(Advice());
                break;
              case 1:
                Get.to(HomePage());
                break;
              case 2:
                Get.to(accountSettings());
                break;
            }
            //selectedIndex = index;
          }),
      body: Column(children: [
        Text(
          'سجل التنبيهات',
          style: Theme.of(context).textTheme.headline1,
        ),
        Expanded(
          flex: 1,
          child: ListView.builder(
            reverse: false,
            shrinkWrap: true,
            itemCount: messageList.length,
            itemBuilder: ((context, index) {
              return Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    child: SizedBox(
                      height: 170.h,
                      width: 280.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40.r),
                        child: Card(
                            color: Color.fromRGBO(255, 255, 255, 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20.r),
                              child: Column(
                                children: [
                                  Container(
                                    height: 45.h,
                                    color: Color.fromRGBO(237, 236, 242, 1),
                                    child: Row(children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 10.w,
                                        ),
                                        child: messageList[index].childgender ==
                                                Gender.Boy
                                            ? Image.asset(
                                                'images/boyIcon_c.png')
                                            : Image.asset(
                                                'images/girlIcon_c.png'),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 2.h),
                                        child: Text(
                                          '${messageList[index].childName}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline1,
                                        ),
                                      )
                                    ]),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        'العبارة',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline1,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.w),
                                      child: Text(
                                        '${messageList[index].message}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline5,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: TextButton(
                                        onPressed: () {
                                          Get.off(
                                            AlertDetails(
                                              name:
                                                  messageList[index].childName,
                                              date: messageList[index].date,
                                              sender:
                                                  messageList[index].senderName,
                                              content:
                                                  messageList[index].message,
                                              gender: (messageList[index]
                                                  .childgender),
                                              isSaved:
                                                  messageList[index].isSaved,
                                              id: messageList[index].id,
                                            ),
                                          );
                                        },
                                        child: Text(
                                          'المزيد',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                            fontFamily: 'FFHekaya',
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ]),
    );
  }
}
