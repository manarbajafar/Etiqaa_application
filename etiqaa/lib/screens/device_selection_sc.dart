import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'loginC_Sc.dart';
import 'loginP_Sc.dart';

class deviceSelectionSc extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-1.0.w, -0.7.w),
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
              Text(
                'جهاز من هذا ؟',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(
                height: 15.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 13.h),
                child: SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () {
                      Get.to(LoginPSc());
                    },
                    child: Text(
                      'جهاز الوالد/ة',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              SizedBox(
                height: 40.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                  onPressed: () {
                    Get.to(LoginCSc());
                  },
                  child: Text(
                    'جهاز الطفل',
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
