import 'package:etiqaa/main.dart';
import 'package:etiqaa/screens/Child_uncompleteP_Sc.dart';
import 'package:flutter/material.dart';
import '../controllers/childUncomplete_controller.dart';
import '../models/child.dart';
import '../widgets/childIcon.dart';
import '../widgets/curvedAppbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../database/crud.dart';
import '../database/linkApi.dart';

class ChooseChildSc extends StatefulWidget {
  @override
  State<ChooseChildSc> createState() => _ChooseChildSc();
}

class _ChooseChildSc extends State<ChooseChildSc> {
  ChildUncompleteController controller = Get.put(ChildUncompleteController());

  int childrenNum = 0;

  Crud _crud = Crud();

  void initState() {
    super.initState();
  }

  Future childrenList() async {
    var response = await _crud.postRequest(linkchooseChild, {
      "parent_id": sharedPref.getString("parent_id"),
    });
    return response;
  }

  @override
  Widget build(BuildContext context) {
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
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.h, horizontal: 5.h),
          child: Column(
            children: [
              Text(
                'اختر طفل',
                style: Theme.of(context).textTheme.headline1,
                //color: Colors.black,
              ),
              // ListView.builder(
              //     /* both ListView and Column take the full screen available to them, as this way we can only see ListView on the screen, to resolve this we have to shrink ListView to its exact size, for it shrinkwrap: true is used.
              //     physics: NeverScrollableScrollPhysics(), is used here to stop ListView scrolling */
              //     shrinkWrap: true,
              //     physics: BouncingScrollPhysics(),
              //     itemCount: childrenlist.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       if (childrenlist[index].isActivated == false) {
              //         return ChildShow(
              //           name: childrenlist[index].name,
              //           isActivated: childrenlist[index].isActivated,
              //           gender: childrenlist[index].gender,
              //           birthday: childrenlist[index].birthday,
              //         );
              //       }
              //       return SizedBox(
              //         height: 0,
              //         width: 0,
              //       );
              //     }),
              FutureBuilder(
                future: childrenList(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  List? snap = snapshot.data;

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  childrenNum = snap!.length;
                  if (childrenNum == 0) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 30.h, horizontal: 2.w),
                        child: Text(
                          "لا يوجد لديك أطفال مضافين\nقم بإضافة طفل من حسابك أولًا",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 25.sp,
                            fontFamily: 'FFHekaya',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snap.length,
                    itemBuilder: (BuildContext context, index) {
                      print(childrenNum);
                      if ('${snap[index]['parent_id']}' ==
                          sharedPref.getString('parent_id')) {
                        return InkWell(
                          onTap: () {
                            //
                            controller.name = snap[index]['child_name'];
                            controller.age = snap[index]['date_of_birth'];
                            controller.isActive = snap[index]['isActive'];
                            controller.gender = snap[index]['gender'];

                            Get.to(() => ChildUncombletePSc());
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
              // childrenNum == 0
              //     ? Padding(
              //         padding:
              //             EdgeInsets.symmetric(vertical: 30.h, horizontal: 0.h),
              //         child: Text(
              //           "لا يوجد لديك اطفال يحتاجون تنشيط",
              //           style: TextStyle(
              //             color: Colors.redAccent,
              //             fontSize: 25.sp,
              //             fontFamily: 'FFHekaya',
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //       )
              //     : Center()
            ],
          ),
        ),
      ),
    );
  }
}
