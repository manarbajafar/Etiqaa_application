import 'package:etiqaa/main.dart';
import 'package:etiqaa/models/Parent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../models/child.dart';
import '../widgets/curvedAppbar.dart';
import 'confirmDeletion.dart';
import 'editAccountInfo.dart';

class AccountInfo extends StatefulWidget {
  @override
  State<AccountInfo> createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> with Crud {
  //const AccountInfo({Key? key}) : super(key: key);

  Future accountInfo() async {
    return await getRequest(linkAccountInfo);
  }

  Future deleteAccount() async {
    var response = await postRequest(linkDeleteAccount, {
      'parent_id': '${sharedPref.getString('parent_id')}',
    });
    if (response != null) {
      await sharedPref.clear();
      Get.offAll(ConfirmDeletion());
    }
  }

  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
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
                'معلومات الحساب',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );
    return Scaffold(
      appBar: appbar,
      body: FutureBuilder(
          future: accountInfo(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            List? snap = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (!snapshot.hasError) {
              for (int i = 0; i < snap!.length; i++) {
                if ('${snap[i]['parent_id']}' ==
                    sharedPref.getString('parent_id')) {
                  return Center(
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 200.h,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text(
                                  'الاسم: ${snap[i]['name']}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text(
                                  'كلمة المرور: ${stars((snap[i]['password']))}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 10.h),
                                child: Text(
                                  'رقم الهاتف: ${snap[i]['phone_number']}',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              Text(
                                'الجنس: ${snap[i]['gender']}',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: SizedBox(
                                height: 40.h,
                                width: 200.w,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).buttonColor,
                                  ),
                                  onPressed: () {
                                    Get.to(() => editAccountInfo(
                                          info: snap,
                                        ));
                                  },
                                  child: Text(
                                    'تعديل',
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                              width: 200.w,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).buttonColor,
                                ),
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      //title: const Text(''),
                                      content: const Text(
                                          'هل أنت متأكد من حذف الحساب؟'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            deleteAccount();
                                          },
                                          child: const Text('نعم'),
                                        ),
                                        TextButton(
                                          onPressed: () => Get.back(),
                                          //Navigator.pop(context, 'Cancel'),
                                          child: const Text('إلغاء'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                child: Text(
                                  'حذف الحساب',
                                  style: Theme.of(context).textTheme.headline4,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                  ;
                  ;
                }
              }
            }
            return Center(
              child: Text('Erorr'),
            );
          }),
    );
  }

  String stars(String passWord) {
    String stars = '';
    for (int i = 0; i < passWord.length; i++) {
      stars += '*';
    }
    return stars;
  }
}
