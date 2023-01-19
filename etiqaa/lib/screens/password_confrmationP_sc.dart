import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/screens/success_CA_Sc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/confrmation_controller.dart';

class PasswordConfirmationSc extends StatefulWidget {
  @override
  State<PasswordConfirmationSc> createState() => _PasswordConfirmationSc();
}

class _PasswordConfirmationSc extends State<PasswordConfirmationSc> {
  Crud _crud = Crud();

  bool msg = false;
  String msgtext = "";
  bool isLoading = false;

  GlobalKey<FormState> passwordConfirmationFormKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ConfrmationControllerImp controller = Get.put(ConfrmationControllerImp());

    confrmation() async {
      if (passwordConfirmationFormKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});
        var response = await _crud.postRequest(linkconfrmation, {
          "email": controller.email,
          "verfiycode": controller.verfiycode.text,
        });
        isLoading = false;
        setState(() {});
        if (response != null && response["status"] != "fail") {
          controller.toforgetPassChange();
        } else {
          msgtext = ' هذا الرقم غير صحيح  ';
          msg = true;
          setState(() {});
          print("confrmatin fail");
        }
      }
    }

    resend() async {
      isLoading = true;
      setState(() {});
      var response = await _crud.postRequest(linkresend, {
        "email": controller.email,
      });
      isLoading = false;
      setState(() {});
      if (response != null && response["status"] != "fail") {
        msgtext = ' تم ارسال رمز جديد  ';
        msg = true;
        setState(() {});
      } else {
        print("resend fail");
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
          key: passwordConfirmationFormKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Text(
                    ' من فضلك أدخل رمز التحقق الذي تم إرساله إلى الإيميل ',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 130.h,
                  width: 200.w,
                  child: TextFormField(
                    controller: controller.verfiycode,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                          width: 3.w,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide(
                          color: Colors.lightBlue,
                          width: 3.w,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'الرجاء ادخال رقم التحقق';
                      }
                      if (value.length != 4) {
                        return 'يجب ان يحتوي رقم التحقق على 4 ارقام ';
                      }
                      return null;
                    },
                  ),
                ),
                msg == true
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.h, horizontal: 0.h),
                        child: Text(
                          msgtext,
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
                    : Column(
                        children: [
                          SizedBox(
                            height: 40.h,
                            width: 200.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                              ),
                              onPressed: () {
                                confrmation();

                                print('valid');
                              },
                              child: Text(
                                ' تحقق',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          SizedBox(
                            height: 40.h,
                            width: 200.w,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).buttonColor,
                              ),
                              onPressed: () {
                                resend();
                              },
                              child: Text(
                                'إعادة الإرسال',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
