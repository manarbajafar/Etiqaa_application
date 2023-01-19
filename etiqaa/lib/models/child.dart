import 'package:flutter/cupertino.dart';

enum Gender {
  Boy,
  Girl,
}

class Child {
  String name;
  //String parentName;
  DateTime birthday;
  bool isActivated;
  Gender gender;

  String get genderText {
    switch (gender) {
      case Gender.Boy:
        return 'ذكر';
      case Gender.Girl:
        return 'أنثى';
      default:
        return 'غير معروف';
    }
  }

  Child({
    required this.name,
    //this.parentName,
    required this.birthday,
    required this.isActivated,
    required this.gender,
  });
}
