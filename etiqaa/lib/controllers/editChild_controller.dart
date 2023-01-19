import 'package:etiqaa/database/crud.dart';
import 'package:etiqaa/screens/childAccount.dart';
import 'package:etiqaa/screens/childrenList.dart';
import 'package:etiqaa/widgets/messagesCards.dart';
import 'package:get/get.dart';

import 'package:etiqaa/screens/create_account_sc.dart';
import 'package:etiqaa/screens/forget_passwordP_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:flutter/material.dart';
import '../screens/confirmation_Sc.dart';

class EditChild_controller extends GetxController {}

class EditChildController extends EditChild_controller {
  late TextEditingController name;
  late TextEditingController date;
  var gender;

  @override
  editChild() {}

  @override
  void onInit() {
    name = TextEditingController();
    date = TextEditingController();
    gender = '';
    super.onInit();
  }

  @override
  void dispose() {
    name.dispose();
    date.dispose();
    super.dispose();
  }

  @override
  toConfirmation(String isActive) {
    Get.off(
      ChildAccount(
        name: name.text,
        date: date.text,
        gander: gender,
        isActive: isActive,
      ),
    );
  }
}
