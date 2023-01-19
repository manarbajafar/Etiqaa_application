import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/screens/accountInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../main.dart';
import '../models/Parent.dart';
import '../models/child.dart';
import '../widgets/curvedAppbar.dart';

class editAccountInfo extends StatefulWidget {
  const editAccountInfo({Key? key, required this.info}) : super(key: key);
  final List info;

  @override
  State<editAccountInfo> createState() => _editAccountInfoState();
}

class _editAccountInfoState extends State<editAccountInfo> with Crud {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController genderC = TextEditingController();

  String getGenderValue(String gender) {
    switch (gender) {
      case 'ذكر':
        return 'boy';
      case 'أنثى':
        return 'girl';
      default:
        return '';
    }
  }

  String getGender(String gender) {
    switch (gender) {
      case 'boy':
        return 'ذكر';
      case 'girl':
        return 'أنثى';
      default:
        return '';
    }
  }

  //for testing

  late var gender;
  late int index;
  @override
  void initState() {
    for (int i = 0; i < widget.info.length; i++) {
      if ('${widget.info[i]['parent_id']}' ==
          sharedPref.getString('parent_id')) {
        index = i;
        gender = getGenderValue(widget.info[i]['gender']);
        genderC.text = widget.info[i]['gender'];
      }
    }

    super.initState();
  }

  editAccount() async {
    var response = await postRequest(linkEditAccountInfo, {
      'name': name.text,
      'password': password.text,
      'phone_number': phone.text,
      'gender': genderC.text,
      'parent_id':
          sharedPref.getString('parent_id'), //widget.info[index]['parent_id']
    });
    if (response != null && response["statues"] == "success") {
      Get.off(AccountInfo());
    }
  }

  static GlobalKey<FormState> caFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-0.5.w, -0.9.w),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 3.h),
                  child: Text(
                    'تعديل معلومات الحساب',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                Image.asset(
                  'images/whiteLogo.png',
                  height: 70.h,
                  width: 70.w,
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: caFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: TextFormField(
                    initialValue: widget.info[index]['name'],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: ' الاسم',
                      labelStyle: Theme.of(context).textTheme.headline5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال الاسم';
                      }
                      if (value.length < 2) {
                        return 'الرجاء ادخال اسم صحيح';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      name.text = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: TextFormField(
                    initialValue: widget.info[index]['password'],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      labelText: ' كلمة المرور',
                      labelStyle: Theme.of(context).textTheme.headline5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال كلمة المرور';
                      }
                      if (value.length < 8) {
                        return 'يجب ان تحتوي كلمة المرور على 8 احرف على الاقل;';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      password.text = value.toString();
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: TextFormField(
                    initialValue: widget.info[index]['phone_number'],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      labelText: ' رقم الهاتف',
                      hintText: '966123456789',
                      labelStyle: Theme.of(context).textTheme.headline5,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال رقم الهاتف';
                      }
                      if (value.length != 12) {
                        return 'يجب ان يكون رقم الهاتف مكون من 12 ارقام';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      phone.text = value.toString();
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الجنس',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'boy',
                            groupValue: gender,
                            onChanged: (value) {
                              gender = value;
                              setState(
                                () {
                                  gender = value;
                                  genderC.text = getGender(value.toString());
                                },
                              );
                            },
                          ),
                          Text('ذكر',
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              value: 'girl',
                              groupValue: gender,
                              onChanged: (value) {
                                gender = value;
                                setState(
                                  () {
                                    gender = value;
                                    genderC.text = getGender(value.toString());
                                  },
                                );
                              }),
                          Text('أنثى',
                              style: Theme.of(context).textTheme.headline6),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () async {
                      var caFormData = caFormKey.currentState;
                      if (caFormData!.validate()) {
                        caFormData.save();

                        print('valid');
                      }
                      await editAccount();
                      //Get.off(AccountInfo());
                    },
                    child: Text(
                      'حفظ التعديلات',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
