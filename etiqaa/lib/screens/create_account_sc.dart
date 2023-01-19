import 'package:email_validator/email_validator.dart';
import 'package:etiqaa/controllers/singup_controller.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/widgets/custom_textForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class createAcountSc extends StatefulWidget {
  @override
  State<createAcountSc> createState() => _CreateAccountForm();
}

class _CreateAccountForm extends State<createAcountSc> {
  Crud _crud = Crud();

  bool msg = false;
  bool isLoading = false;
  bool _passwordVisible = false;

  bool validateEmail(String value) {
    RegExp regex = new RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return (!regex.hasMatch(value)) ? false : true;
  }

  static GlobalKey<FormState> caFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SignupControllerImp controller = Get.put(SignupControllerImp());

    SignUp() async {
      if (caFormKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequest(linksignup, {
          "name": controller.name.text,
          "email": controller.email.text,
          "phone_number": controller.phoneNumber.text,
          "gender": controller.gender.toString(),
          "password": controller.password.text,
        });

        isLoading = false;
        setState(() {});
        if (response != null && response["status"] == "success") {
          controller.toConfirmation();
        } else {
          msg = true;
          setState(() {});
          print("SU fail");
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          alignment: Alignment(-1.0.h, -0.7.h),
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
                    'إنشاء حساب',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                ),
                SizedBox(
                  width: 10.w,
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
                CustomTextForm(
                  controllar: controller.name,
                  labelText: "الاسم",
                  textInputType: TextInputType.name,
                  padding: EdgeInsets.only(bottom: 10.h),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال الاسم';
                    }
                    if (value.length < 2) {
                      return 'الرجاء ادخال اسم صحيح';
                    }
                    return null;
                  },
                  obscureText: false,
                ),
                CustomTextForm(
                  controllar: controller.email,
                  textInputType: TextInputType.emailAddress,
                  labelText: ' البريد الالكتروني',
                  padding: EdgeInsets.only(bottom: 10.h),
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "الرجاء ادخال بريد الكتروني صحيح",
                  obscureText: false,
                ),
                CustomTextForm(
                  controllar: controller.password,
                  textInputType: TextInputType.text,
                  labelText: ' كلمة المرور',
                  padding: EdgeInsets.only(bottom: 10.h),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال كلمة المرور';
                    }
                    if (value.length < 8) {
                      return 'يجب ان تحتوي كلمة المرور على 8 احرف على الاقل;';
                    }
                    return null;
                  },
                  obscureText: !_passwordVisible,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // Update the state i.e. toogle the state of passwordVisible variable
                      setState(() {
                        _passwordVisible = !_passwordVisible;
                      });
                    },
                  ),
                ),
                CustomTextForm(
                  controllar: controller.phoneNumber,
                  textInputType: TextInputType.phone,
                  labelText: ' رقم الهاتف',
                  padding: EdgeInsets.only(bottom: 10.h),
                  obscureText: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال رقم الهاتف';
                    }
                    if (value.length != 12) {
                      return 'يجب ان يكون رقم الهاتف مكون من 12 ارقام';
                    }
                    return null;
                  },
                  hintText: '966123456789',
                ),
                Container(
                  padding: EdgeInsets.only(bottom: 10.h),
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
                            value: 'ذكر',
                            groupValue: controller.gender,
                            onChanged: (value) {
                              controller.gender = value;
                              setState(
                                () {
                                  controller.gender = value;
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
                              value: 'أنثى',
                              groupValue: controller.gender,
                              onChanged: (value) {
                                controller.gender = value;
                                setState(
                                  () {
                                    controller.gender = value;
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
                msg == true
                    ? Text(
                        ' هذا البريد الالكتروني مسجل مسبقا ',
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 19.sp,
                          fontFamily: 'FFHekaya',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Container(),
                isLoading == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).buttonColor,
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: 5.h, bottom: 15.h),
                        child: SizedBox(
                          height: 40.h,
                          width: 200.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).buttonColor,
                            ),
                            onPressed: () async {
                              await SignUp();
                              //  var caFormData = caFormKey.currentState;
                              //   if (caFormData!.validate()) {
                              //     caFormData.save();

                              //    Get.to(ConfirmationSc());

                              //    print('valid');
                              //   }
                            },
                            child: Text(
                              'انشاء',
                              style: Theme.of(context).textTheme.headline4,
                            ),
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
