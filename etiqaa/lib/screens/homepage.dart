import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/accountSettings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import '../widgets/messagesCards.dart';
import '../widgets/noChildren.dart';
import 'advice.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget get isHasChild {
    print(
        "sharedPref.getInt('childrenNum') ${sharedPref.getInt('childrenNum')}");
    if (sharedPref.getInt('childrenNum') == 0) {
      return NoChildren();
    } else {
      return MessagesCards();
    }
  }

  List<Widget> pages = [
    Advice(),
    HomePage(),
    accountSettings(),
  ];

  int selectedIndex = 1;

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
          index: 1,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates_outlined,
              size: 30.h,
            ),
            Icon(
              Icons.home,
              size: 30.h,
            ),
            Icon(
              Icons.settings,
              size: 30.h,
            ),
          ],
          onTap: (index) {
            setState(() {
              switch (index) {
                case 0:
                  //Get.to(Advice());
                  Get.to(() => Advice());
                  break;
                case 1:
                  //Get.to(HomePage());
                  Get.to(() => HomePage());
                  break;
                case 2:
                  //Get.to(accountSettings());
                  Get.to(() => accountSettings());
                  break;
              }
              //selectedIndex = index;
            });
          }),
      body: isHasChild,
    );
  }
}
