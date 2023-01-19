import 'package:etiqaa/database/linkApi.dart';
import 'package:etiqaa/screens/choose_child_Sc.dart';
import 'package:etiqaa/screens/create_account_sc.dart';
import 'package:etiqaa/screens/forget_passwordP_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:etiqaa/database/crud.dart';

import '../main.dart';
import '../screens/welcoming_screen.dart';

abstract class LogInController extends GetxController {
  loginp();
  toSignup();
  toHomePage();
  toChooseChild();
  toForgetPass();
}

class LogInControllerImp extends LogInController {
  late TextEditingController email;
  late TextEditingController password;

  @override
  void onInit() {
    email = TextEditingController();
    password = TextEditingController();

    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  loginp() {}

  @override
  toForgetPass() {
    Get.to(ForgetPassSc());
  }

  @override
  toHomePage() {
    if (sharedPref.getInt('childrenNum') == 0) {
      Get.offAll(Welcoming());
    } else
      Get.offAll(HomePage());
  }

  @override
  toSignup() {
    Get.to(createAcountSc());
  }

  @override
  toChooseChild() {
    Get.to(ChooseChildSc());
  }
}
