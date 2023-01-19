import 'package:etiqaa/controllers/loginp_controller.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/main.dart';
import 'package:etiqaa/widgets/custom_textForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginCSc extends StatefulWidget {
  @override
  State<LoginCSc> createState() => _LoginCSc();
}

class _LoginCSc extends State<LoginCSc> {
  Crud _crud = Crud();

  bool _passwordVisible = false;
  GlobalKey<FormState> loginCFormKey = new GlobalKey<FormState>();

  bool msg = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    LogInControllerImp controller = Get.put(LogInControllerImp());

    @override
    loginp() async {
      if (loginCFormKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequest(linklogin, {
          "email": controller.email.text,
          "password": controller.password.text,
        });

        isLoading = false;
        setState(() {});
        if (response["status"] == "success") {
          sharedPref.setString(
              'parent_id', response['data']['parent_id'].toString());

          controller.toChooseChild();
        } else {
          msg = true;
          setState(() {});
          print("LI fail");
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
                    ' تسجيل الدخول',
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
          key: loginCFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 30.w),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomTextForm(
                    controllar: controller.email,
                    textInputType: TextInputType.emailAddress,
                    labelText: ' البريد الالكتروني',
                    padding: EdgeInsets.only(bottom: 10.h),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال البريد الالكتروني';
                      }

                      return null;
                    },
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
                  Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Align(
                      alignment: FractionalOffset.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          controller.toForgetPass();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            bottom: 0, // space between underline and text
                          ),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.black, // Text colour here
                            width: 1.0, // Underline width
                          ))),
                          child: Text(
                            'نسيت كلمة المرور؟',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15.sp,
                              fontFamily: 'FFHekaya',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  msg == true
                      ? Text(
                          '  البريد الالكتروني او كلمة المرور غير صحيح',
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 19.sp,
                            fontFamily: 'FFHekaya',
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : Container(),
                  SizedBox(
                    height: 20.h,
                  ),
                  isLoading == true
                      ? Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).buttonColor,
                          ),
                        )
                      : SizedBox(
                          height: 40.h,
                          width: 200.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).buttonColor,
                            ),
                            onPressed: () {
                              print(sharedPref.getString('parent_id'));
                              loginp();
                            },
                            child: Text(
                              'تسجيل الدخول',
                              style: Theme.of(context).textTheme.headline4,
                            ),
                          ),
                        ),
                ]),
          ),
        ),
      ),
    );
  }
}
