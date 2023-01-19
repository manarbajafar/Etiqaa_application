import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:etiqaa/models/child.dart';
import 'package:etiqaa/screens/childAccount.dart';
import 'package:etiqaa/widgets/childIcon.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:sizer/sizer.dart';
import '../controllers/childrenList_controller.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';
import '../main.dart';
import '../widgets/curvedAppbar.dart';
import 'addChild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'accountSettings.dart';
import 'advice.dart';
import 'homepage.dart';

class ChildrenList extends StatefulWidget {
  @override
  State<ChildrenList> createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  //const ChildrenList({ Key? key }) : super(key: key);
  ChildrenListController controller = Get.put(ChildrenListController());

  late int childrenNum;

  Crud _crud = Crud();

  void initState() {
    super.initState();
  }

  Future childrenList() async {
    return await _crud.getRequest(linkChildrenList);
  }

  // int index = 0;
  @override
  Widget build(BuildContext context) {
    var appbar = AppBar(
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
    );
    return Scaffold(
      appBar: appbar,
      bottomNavigationBar: CurvedNavigationBar(
          // type: BottomNavigationBarType.fixed,
          index: 2,
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          color: Color(0xFFF9AF4B),
          items: [
            Icon(
              Icons.tips_and_updates_outlined,
              size: 30,
            ),
            Icon(
              Icons.home,
              size: 30,
            ),
            Icon(
              Icons.settings,
              size: 30,
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                Get.to(Advice());
                break;
              case 1:
                setState(() {
                  Get.to(HomePage());
                });
                break;
              case 2:
                Get.to(accountSettings());
                break;
            }
            //selectedIndex = index;
          }),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80.h,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'قائمة الأطفال',
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  Text('لا يمكن إضافة أكثر من ثلاثة أطفال',
                      style: Theme.of(context).textTheme.headline3),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                // ListView.builder(
                //   /* both ListView and Column take the full screen available to them, as this way we can only see ListView on the screen, to resolve this we have to shrink ListView to its exact size, for it shrinkwrap: true is used.
                //             physics: NeverScrollableScrollPhysics(), is used here to stop ListView scrolling */
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemBuilder: (BuildContext context, int index) {
                //     return childIcon(
                //       name: controller.childrenlist[index].name,
                //       isActivated: controller.childrenlist[index].isActivated,
                //       gender: controller.childrenlist[index].gender,
                //     );
                //   },
                //   itemCount: controller.childrenlist.length,
                // ),
                FutureBuilder(
                  future: childrenList(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    List? snap = snapshot.data;
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: snap!.length,
                      itemBuilder: (BuildContext context, index) {
                        if ('${snap[index]['parent_id']}' ==
                            sharedPref.getString('parent_id')) {
                          return InkWell(
                            onTap: () {
                              Get.to(() => ChildAccount(
                                  name: snap[index]['child_name'],
                                  gander: snap[index]['gender'],
                                  date: snap[index]['date_of_birth'],
                                  isActive:
                                      snap[index]['isActive'].toString()));
                            },
                            child: childIcon(
                              name: snap[index]['child_name'],
                              isActivated:
                                  snap[index]['isActive'].toString() == '0'
                                      ? false
                                      : true,
                              gender: snap[index]['gender'].toString() == 'أنثى'
                                  ? Gender.Girl
                                  : Gender.Boy,
                            ),
                          );
                        }
                        return Center();
                      },
                    );
                  },
                ),
                SizedBox(
                    child: (sharedPref.getInt('childrenNum'))! < 3
                        ? Container(
                            height: 200.h,
                            width: double.infinity,
                            child: InkWell(
                              onTap: () {},
                              child: InkWell(
                                onTap: () {
                                  Get.to(() => addChild());
                                  //controller.testAddChild();
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'images/addChild.png',
                                        height: 100.h,
                                        width: double.infinity,
                                      ),
                                      Text('إضافة طفل',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        : null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
