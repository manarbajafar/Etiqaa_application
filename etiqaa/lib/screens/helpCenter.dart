import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/screens/addChildWay.dart';
import 'package:etiqaa/screens/appUse.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/screens/connectWithUs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curvedAppbar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class HelpCenter extends StatefulWidget {
  // const HelpCenter({super.key});

  @override
  State<HelpCenter> createState() => _HelpCenterState();
}

class _HelpCenterState extends State<HelpCenter> {
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
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'المساعدات',
                style: Theme.of(context).textTheme.headline1,
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
                    Get.to(AppUse());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'طريقة استخدام التطبيق',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
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
                    Get.to(AddChildWay());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'طريقة إضافة طفل',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
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
                    Get.to(ConnectWithUs());
                  },
                  child: Container(
                    color: Color.fromRGBO(237, 236, 242, 1),
                    child: Center(
                      child: Text(
                        'تواصل معنا',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
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
