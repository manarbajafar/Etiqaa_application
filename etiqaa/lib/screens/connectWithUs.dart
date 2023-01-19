import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/curvedAppbar.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class ConnectWithUs extends StatefulWidget {
  const ConnectWithUs({Key? key}) : super(key: key);
  static const _kFontFam = 'MyFlutterApp';
  static const String? _kFontPkg = null;

  static const IconData twitter =
      IconData(0xf309, fontFamily: _kFontFam, fontPackage: _kFontPkg);

  @override
  State<ConnectWithUs> createState() => _ConnectWithUsState();
}

class _ConnectWithUsState extends State<ConnectWithUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-1.0.w, -0.7.w),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        toolbarHeight: 250.h,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: CurvedAppbar(),
          child: Container(
            height: 300.h,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).accentColor,
                  Theme.of(context).primaryColor,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/whiteLogo.png',
                  height: 150.h,
                ),
                Text(
                  'تواصل معنا',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ],
            ),
          ),
        ),
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
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Card(
                color: Color.fromRGBO(237, 236, 242, 1),
                child: ListTile(
                  leading: Icon(
                    Icons.mail,
                    color: Colors.black,
                  ),
                  title: Center(
                    child: Text(
                      'EtiqaaApp@gmail.com',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Card(
                color: Color.fromRGBO(237, 236, 242, 1),
                child: ListTile(
                  leading: Image.asset(
                    'images/twitter.png',
                    height: 25.w,
                    width: 25.w,
                  ),
                  title: Center(
                    child: Text(
                      'etiqaa_App@',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
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
