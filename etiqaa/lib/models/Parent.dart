import 'child.dart';

class Parent {
  String parntName;
  String email;
  String passWord;
  String phoneNumber;
  String gender;
  List<Child> parentChildList = [];

  Parent({
    required this.parntName,
    required this.email,
    required this.passWord,
    required this.phoneNumber,
    required this.gender,
    required List<Child> parentChildList,
  });

  get getParntName => this.parntName;

  set setParntName(parntName) => this.parntName = parntName;

  get getEmail => this.email;

  set setEmail(email) => this.email = email;

  get getPassWord => this.passWord;

  set setPassWord(passWord) => this.passWord = passWord;

  get getPhoneNumber => this.phoneNumber;

  set setPhoneNumber(phoneNumber) => this.phoneNumber = phoneNumber;

  get getGender => this.gender;

  set setGender(gender) => this.gender = gender;

  get getParentChildList => this.parentChildList;

  set setParentChildList(parentChildList) =>
      this.parentChildList = parentChildList;
}
