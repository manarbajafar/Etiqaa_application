import 'package:email_validator/email_validator.dart';
import 'package:etiqaa/controllers/forget_pass_controller.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/screens/password_confrmationP_sc.dart';
import 'package:etiqaa/widgets/custom_textForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPassSc extends StatefulWidget {
  @override
  State<ForgetPassSc> createState() => _ForgetPassSc();
}

class _ForgetPassSc extends State<ForgetPassSc> {
  static GlobalKey<FormState> forgetpassKey = new GlobalKey<FormState>();
  Crud _crud = Crud();

  bool msg = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    ForgetPassControllerImp controller = Get.put(ForgetPassControllerImp());

    forgetPass() async {
      if (forgetpassKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequest(linkresend, {
          "email": controller.email.text,
        });
        isLoading = false;
        setState(() {});
        if (response != null && response["status"] != "fail") {
          controller.toforgetConfirmationSc();
        } else {
          msg = true;
          setState(() {});
          print("forget email fail");
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
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  child: Image.asset(
                    'images/whiteLogo.png',
                    height: 70.h,
                    width: 70.w,
                  ),
                ),
              ),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: forgetpassKey,
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
                  validator: (value) => EmailValidator.validate(value!)
                      ? null
                      : "الرجاء ادخال بريد الكتروني صحيح",
                  obscureText: false,
                ),
                SizedBox(
                  height: 40.h,
                ),
                msg == true
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.h, horizontal: 0.h),
                        child: Text(
                          "البريد الالكتروني غير مسجل ",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 19.sp,
                            fontFamily: 'FFHekaya',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
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
                            forgetPass();
                          },
                          child: Text(
                            'ارسال الرمز',
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
