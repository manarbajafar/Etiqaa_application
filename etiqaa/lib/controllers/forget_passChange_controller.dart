import 'package:etiqaa/screens/create_account_sc.dart';
import 'package:etiqaa/screens/forget_passwordP_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:etiqaa/screens/succsess_forfetPass_SC.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/confirmation_Sc.dart';

abstract class ForgetPassChangeController extends GetxController {
  forgetPass();
  toforgetPassSuccessSc();
}

class ForgetPassChangeControllerImp extends ForgetPassChangeController {
  String? email;
  late TextEditingController password;

  @override
  forgetPass() {}

  @override
  void onInit() {
    email = Get.arguments["email"];
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  @override
  toforgetPassSuccessSc() {
    Get.to(() => forgetPassSuccessSc());
  }
}
