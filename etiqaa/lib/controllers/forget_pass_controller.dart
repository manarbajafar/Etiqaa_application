import 'package:etiqaa/screens/create_account_sc.dart';
import 'package:etiqaa/screens/forget_passwordP_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:etiqaa/screens/password_confrmationP_sc.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/confirmation_Sc.dart';

abstract class ForgetPassController extends GetxController {
  forgetPass();
  toforgetConfirmationSc();
}

class ForgetPassControllerImp extends ForgetPassController {
  late TextEditingController email;

  @override
  forgetPass() {}

  @override
  void onInit() {
    email = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  toforgetConfirmationSc() {
    Get.to(PasswordConfirmationSc(), arguments: {"email": email.text});
  }
}
