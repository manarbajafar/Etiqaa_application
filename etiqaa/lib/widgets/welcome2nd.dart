import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeSecond extends StatelessWidget {
  //const WelcomeSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'images/addChild.png',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
                'قم بإضافة بيانات طفلك من خلال قائمة الأطفال في الإعدادات، ثم قم بتفعيل طفلك من خلال تحميل تطبيقنا في جهاز طفلك وتسجيل الدخول بحسابك وأخذ الأذونات اللازمة',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
