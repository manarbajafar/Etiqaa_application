import 'package:etiqaa/models/child.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
import '../screens/childAccount.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class childIcon extends StatelessWidget {
  //const childIcon({ Key? key }) : super(key: key);
  final String name;
  final bool isActivated;
  final Gender gender;

  childIcon(
      {required this.name, required this.isActivated, required this.gender});

  void seleccChild(BuildContext context) {
    //go to chid account screen
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 135.h,
      width: double.infinity,
      child: Column(
        children: [
          Image.asset(
            ChildAccount.iconUrl(gender, isActivated),
            height: 100.h,
          ),
          Text(name, style: Theme.of(context).textTheme.headline5),
        ],
      ),
    );
  }
}
