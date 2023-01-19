import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/addChild.dart';

class NoChildren extends StatelessWidget {
  //const NoChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(addChild());
      },
      child: Container(
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Text(
                'لايوجد لديك أطفال',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Column(children: [
              Image.asset('images/addChild.png'),
              Text(
                'إضافة طفل',
                style: Theme.of(context).textTheme.headline1,
              )
            ])
          ],
        )),
      ),
    );
  }
}
