import 'dart:convert';

import 'package:etiqaa/main.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/screens/editChildAccount.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../models/child.dart';

class ChildAccount extends StatefulWidget {
  const ChildAccount(
      {required this.name,
      required this.gander,
      required this.date,
      required this.isActive});
  final String name;
  final String gander;
  final String date;
  final String isActive;

  static String iconUrl(Gender gender, bool isActivated) {
    if (gender == Gender.Boy && isActivated) {
      return ('images/boyIcon_c.png');
    } else if (gender == Gender.Boy && !isActivated) {
      return ('images/boyIcon_b.png');
    } else if (gender == Gender.Girl && isActivated) {
      return ('images/girlIcon_c.png');
    } else {
      return ('images/girlIcon_b.png');
    }
  }

  @override
  State<ChildAccount> createState() => _ChildAccountState();
}

class _ChildAccountState extends State<ChildAccount> with Crud {
  //for testing
  Child childInfo = new Child(
    name: 'سارة',
    isActivated: false,
    // isActivated: true,
    gender: Gender.Girl,
    birthday: DateTime.utc(2007, 6, 9),
  );
  Future childrenList() async {
    return await getRequest(linkChildrenList);
  }

  var gender, isActive;
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

  deleteChild() async {
    var response = await postRequest2(linkDeletChild, {
      'parent_id': '${sharedPref.getString('parent_id')}',
      'child_name': widget.name,
    });
    //response = jsonDecode(response.toString());
    if (response != null && response['statues'] == 'success') {
      sharedPref.setInt('childrenNum', sharedPref.getInt('childrenNum')! - 1);
      Get.off(ChildrenList());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            alignment: Alignment(-1.0.w, -0.7.w),
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Get.off(ChildrenList()),
          ),
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
                  padding:
                      EdgeInsets.only(top: 28.h, bottom: 30.h, right: 20.w),
                  child: Row(
                    children: [
                      Image.asset(
                        ChildAccount.iconUrl(
                            widget.gander == 'أنثى' ? Gender.Girl : Gender.Boy,
                            widget.isActive == '0' ? false : true),
                        height: 70.h,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(widget.name,
                          style: Theme.of(context).textTheme.headline5),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Text(
                'العمر: ${calculateAge(DateTime.parse(widget.date))}',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            Text(
                 widget.isActive == '0'
                    ? 'لم يتم إنهاء إجراءات هذا الطفل \nقم بربط الطفل بجهازه'
                    : '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3),
            Padding(
              padding: EdgeInsets.only(top: 10.h, bottom: 20.h),
              child: SizedBox(
                height: 40.h,
                width: 200.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonColor,
                  ),
                  onPressed: () {
                    Get.to(() => EditChildAccount(
                          name: widget.name,
                          gander: widget.gander,
                          isActive: widget.isActive,
                          date: widget.date,
                        ));
                  },
                  child: Text(
                    'تعديل',
                    style: Theme.of(context).textTheme.headline4,
                  ),
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
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      //title: const Text(''),
                      content: const Text('هل أنت متأكد من حذف الحساب؟'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            deleteChild();
                          },
                          child: const Text('نعم'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(),
                          child: const Text('إلغاء'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text(
                  'حذف الطفل',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ),
            ),
          ],
        )));
  }
}
