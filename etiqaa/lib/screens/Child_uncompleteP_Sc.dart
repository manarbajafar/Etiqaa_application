import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/childUncomplete_controller.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../models/child.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'childAccount.dart';

class ChildUncombletePSc extends StatelessWidget {
  ChildUncompleteController controller = Get.put(ChildUncompleteController());

  String iconUrl(Gender gender, bool isActive) {
    if (gender == Gender.Boy && isActive) {
      return ('images/boyIcon_c.png');
    } else if (gender == Gender.Boy && !isActive) {
      return ('images/boyIcon_b.png');
    } else if (gender == Gender.Girl && isActive) {
      return ('images/girlIcon_c.png');
    } else {
      return ('images/girlIcon_b.png');
    }
  }

  calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(400.r),
          ),
        ),
        flexibleSpace: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(400.r),
          ),
          child: Container(
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
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(250.h),
          child: Column(
            children: [
              Image.asset(
                'images/whiteLogo.png',
                height: 150.h,
              ),
              Padding(
                padding: EdgeInsets.only(top: 28.h, bottom: 30.h, right: 20.w),
                child: Row(
                  children: [
                    Image.asset(
                      // iconUrl(gender, isActivated),
                      ChildAccount.iconUrl(
                          controller.gender.toString() == 'أنثى'
                              ? Gender.Girl
                              : Gender.Boy,
                          controller.isActive == 0 ? false : true),
                      height: 70.h,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(controller.name ?? "",
                        style: Theme.of(context).textTheme.headline5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<ChildUncompleteController>(
          init: ChildUncompleteController(),
          builder: (value) => Column(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Text(
                  'العمر: ${calculateAge(DateTime.parse(controller.age ?? ""))}',
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 3.h, horizontal: 3.w),
                  child: !value.flag
                      ? Text(
                          'لم يتم إنهاء اجراءات هذا الطفل',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        )
                      : Text(
                          'تم انهاء إجراءات هذا الطفل ',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Center(
                child: !value.flag
                    ? SizedBox(
                        height: 40.h,
                        width: 200.w,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).buttonColor,
                          ),
                          onPressed: () {
                            print("message 1 ${value.started}");
                            value.started
                                ? value.stopListening()
                                : value.startListening();
                          },
                          child: Text(
                            ' إنهاء الاجراءات ',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
