import 'dart:convert';

import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/main.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/widgets/messagesCards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../database/linkApi.dart';
import '../models/child.dart';
import '../widgets/curvedAppbar.dart';
import '../controllers/editChild_controller.dart';

class EditChildAccount extends StatefulWidget {
  const EditChildAccount({
    Key? key,
    required this.name,
    required this.gander,
    required this.date,
    required this.isActive,
  }) : super(key: key);
  final String name;
  final String gander;
  final String date;
  final String isActive;
  @override
  State<EditChildAccount> createState() => _EditChildAccountState();
}

class _EditChildAccountState extends State<EditChildAccount> with Crud {
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  EditChildController controller =
      Get.put(EditChildController(), permanent: true);

  var isActive;
  void initState() {
    controller.date.text = widget.date;
    controller.name.text = widget.name;
    isActive = widget.isActive;
    controller.gender = getGenderValue(widget.gander);
    birthdate.text = widget.date;

    super.initState();
  }

  String getGenderValue(String gender) {
    switch (gender) {
      case 'ذكر':
        return 'boy';
      case 'أنثى':
        return 'girl';
    }
    return '';
  }

  //for testing
  Child childInfo = new Child(
    name: 'سارة',
    isActivated: false,
    gender: Gender.Girl,
    birthday: DateTime.utc(2007, 6, 9),
  );

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

  DateTime? pickedDate;

  editChild() async {
    if (formstate.currentState!.validate()) {
      var response = await postRequest2(linkEditChild, {
        "child_name": controller.name.text,
        "gender": getGender(controller.gender),
        "date_of_birth": birthdate.text,
        "parent_id": sharedPref.getString('parent_id'),
        'old_name': widget.name,
      });

      // response = jsonDecode(response.toString());
      print(controller.name.text);
      print(getGender(controller.gender));
      print(birthdate.text);

      print(response.toString());

      if (response != null && response["statues"] == "success") {
        controller.toConfirmation(isActive);
      } else {
        print("Edit fail");
      }
    }
  }

  late TextEditingController birthdate = TextEditingController();
  late var gender;

  void check() {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      //It runs onSaved function.. After the value is checked, it will be stored in the variable
      formData.save();
      print('valid');
    } else {
      print('not valid');
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
                'تعديل بيانات الطفل',
                style: Theme.of(context).textTheme.headline2,
              ),
            ],
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: appbar,
      body: Container(
        child: SingleChildScrollView(
          child: Form(
            key: formstate,
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 20.h),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: TextFormField(
                      controller: controller.name,
                      decoration: InputDecoration(
                        labelText: 'اسم الطفل',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      validator: (text) {
                        //just a test,, If I want to check the input
                        if (text!.length < 2) {
                          return 'الرجاء ادخال اسم صحيح';
                        }
                        return null;
                      },
                      onSaved: (text) {
                        // childName = text;
                      },
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 15.h),
                    child: TextField(
                      readOnly: true,
                      controller: birthdate,
                      decoration: InputDecoration(
                        labelText: 'تاريخ الميلاد',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () async {
                        pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.parse(birthdate.text),
                            firstDate: DateTime(2006),
                            lastDate: DateTime(2017));
                        if (pickedDate != null) {
                          setState(() {
                            birthdate.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate!);
                          });
                        }
                      },
                    ),
                  ),
                  Container(
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
                              groupValue: controller.gender,
                              onChanged: (val) {
                                setState(() {
                                  controller.gender = val.toString();
                                });
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
                              groupValue: controller.gender,
                              onChanged: (val) {
                                setState(() {
                                  controller.gender = val.toString();
                                });
                              },
                            ),
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
                      onPressed: () {
                        check();
                        editChild();
                      },
                      child: Text(
                        'حفظ',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*

Form(
        key: formstate,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: TextFormField(
                      //
                      initialValue: childInfo.name,
                      decoration: InputDecoration(
                        labelText: 'اسم الطفل',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      validator: (text) {
                        //just a test,, If I want to check the input
                        if (text!.length < 2) {
                          return 'الرجاء ادخال اسم صحيح';
                        }
                        return null;
                      },
                      onSaved: (text) {},
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 3.h),
                    child: TextField(
                      controller: birthdate,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'تاريخ الميلاد',
                        labelStyle: Theme.of(context).textTheme.headline5,
                      ),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: childInfo.birthday,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          setState(() {
                            birthdate.text =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                          });
                        }
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 4.h),
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
                              onChanged: (val) {
                                setState(() {
                                  gender = val.toString();
                                });
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
                              onChanged: (val) {
                                setState(() {
                                  gender = val.toString();
                                });
                              },
                            ),
                            Text('أنثى',
                                style: Theme.of(context).textTheme.headline6),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                    width: 45.w,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).buttonColor,
                      ),
                      onPressed: () {},
                      child: Text(
                        'حفظ',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),

*/