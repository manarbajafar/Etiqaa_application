import 'package:flutter/material.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import 'device_selection_sc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class firstSc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 300.h,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        flexibleSpace: ClipPath(
          clipper: CurvedAppbar(),
          child: Container(
            height: 350.h,
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'images/whiteLogo.png',
                  height: 200.h,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.h),
                child: Container(
                  height: 180.h,
                  width: 300.w,
                  child: Text(
                    'اتقاء هو تطبيق لمراقبة الرسائل الخاصة للابناء على تطبيق واتساب لاكتشاف الكلمات غير اللائقة باللغة العربية',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                  onPressed: () {
                    Get.to(deviceSelectionSc());
                    print(sharedPref.getString('parent_id'));
                  },
                  child: Text(
                    'للبدء اضغط هنا',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
