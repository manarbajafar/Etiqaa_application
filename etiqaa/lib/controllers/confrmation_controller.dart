import 'package:etiqaa/screens/create_account_sc.dart';
import 'package:etiqaa/screens/forget_passChange.dart';
import 'package:etiqaa/screens/forget_passwordP_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/confirmation_Sc.dart';
import '../screens/success_CA_Sc.dart';

abstract class ConfrmationController extends GetxController {
  confrmation();
  toSuccessCASc();
  toforgetPassChange();
}

class ConfrmationControllerImp extends ConfrmationController {
  String? email;
  late TextEditingController verfiycode;

  @override
  confrmation() {}

  @override
  void onInit() {
    email = Get.arguments['email'];
    verfiycode = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    verfiycode.dispose();
    super.dispose();
  }

  @override
  toSuccessCASc() => Get.to(SuccessCASc());

  @override
  toforgetPassChange() =>
      Get.to(forgetPassChange(), arguments: {"email": email});
}
