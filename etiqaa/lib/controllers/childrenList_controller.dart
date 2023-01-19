import 'package:get/get.dart';
import '../models/child.dart';

class ChildrenListController extends GetxController {
  List<Child> childrenlist = [
    Child(
      name: 'سارة',
      isActivated: true,
      gender: Gender.Girl,
      birthday: DateTime.utc(2007, 6, 9),
    ),
    Child(
      name: 'عمر',
      isActivated: false,
      gender: Gender.Boy,
      birthday: DateTime.utc(2010, 11, 9),
    ),
    Child(
      name: 'عمر',
      isActivated: false,
      gender: Gender.Boy,
      birthday: DateTime.utc(2010, 11, 9),
    ),
  ];

//method to delete:
//I tried to add a third child when clicking on the add child icon just to see his update directly on the screen
  void testAddChild() {
    childrenlist.add(
      Child(
        name: 'منار',
        isActivated: true,
        gender: Gender.Girl,
        birthday: DateTime.utc(2010, 11, 9),
      ),
    );
    update();
  }
}
