import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/accountInfo.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/screens/first_sc.dart';
import 'package:etiqaa/screens/helpCenter.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:etiqaa/widgets/messagesCards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../main.dart';
import '../widgets/curvedAppbar.dart';
import 'advice.dart';
import 'alertHistory.dart';

class accountSettings extends StatelessWidget {
  //const accountSettings({super.key});

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
              size: 30.w,
            ),
            Icon(
              Icons.home,
              size: 30.w,
            ),
            Icon(
              Icons.settings,
              size: 30.w,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'الإعدادات',
              style: Theme.of(context).textTheme.headline1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AccountInfo());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'معلومات الحساب',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    //Get.to(ChildrenList());
                    Get.to(() => ChildrenList());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'قائمة الأطفال',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(AlertHistory());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'سجل التنبيهات',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: SizedBox(
                height: 60.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    backgroundColor: Color.fromRGBO(237, 236, 242, 1),
                  ),
                  onPressed: () {
                    Get.to(HelpCenter());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'المساعدات',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.h),
              child: SizedBox(
                height: 40.h,
                width: 190.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // ignore: deprecated_member_use
                    primary: const Color(0xF0F9AF4B),
                  ),
                  onPressed: () async {
                    await sharedPref.clear();
                    Get.offAll(firstSc());
                  },
                  child: Text(
                    'تسجيل الخروج',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
