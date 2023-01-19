import 'package:etiqaa/controllers/forget_passChange_controller.dart';
import 'package:etiqaa/controllers/forget_pass_controller.dart';
import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/models/Parent.dart';
import 'package:etiqaa/screens/succsess_forfetPass_SC.dart';
import 'package:etiqaa/screens/welcoming_screen.dart';
import 'package:etiqaa/widgets/custom_textForm.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'homepage.dart';

class forgetPassChange extends StatefulWidget {
  @override
  State<forgetPassChange> createState() => _forgetPassChange();
}

class _forgetPassChange extends State<forgetPassChange> {
  Crud _crud = Crud();

  bool isLoading = false;
  bool _passwordVisible = false;

  static GlobalKey<FormState> fprgetPassChangeKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ForgetPassChangeControllerImp controller =
        Get.put(ForgetPassChangeControllerImp());

    forgetPassChange() async {
      if (fprgetPassChangeKey.currentState!.validate()) {
        isLoading = true;
        setState(() {});

        var response = await _crud.postRequest(linkchangepass, {
          "email": controller.email,
          "password": controller.password.text,
        });

        isLoading = false;
        setState(() {});
        if (response != null && response["status"] == "success") {
          controller.toforgetPassSuccessSc();
        } else {
          print("CP fail");
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
          key: fprgetPassChangeKey,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 1.h, horizontal: 30.w),
                  child: CustomTextForm(
                    controllar: controller.password,
                    textInputType: TextInputType.text,
                    labelText: ' ادخل كلمة المرور الجديدة',
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
                ),
                SizedBox(
                  height: 30.h,
                ),
                SizedBox(
                  height: 40.h,
                  width: 200.w,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).buttonColor,
                    ),
                    onPressed: () {
                      forgetPassChange();
                    },
                    child: Text(
                      ' إدخال',
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
