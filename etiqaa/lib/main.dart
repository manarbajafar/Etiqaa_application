import 'package:etiqaa/screens/first_sc.dart';
import 'package:etiqaa/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //prevent application from changing its orientation and force the layout to stick to "portrait".
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      //need to test
      designSize: const Size(400, 720),
      // designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          //The application language is Arabic(from right to left).
          locale: Locale('ar', 'AE'),
          debugShowCheckedModeBanner: false,

          //design of moving between pages
          defaultTransition: Transition.fade,
          title: 'Etiqaa App',
          theme: ThemeData(
            primaryColor: Color(0xFF8E58D4),
            accentColor: Color(0xFF738EE2),
            buttonColor: Color(0xFFF9AF4B),
            fontFamily: 'FFHekaya',
            textTheme: ThemeData.light().textTheme.copyWith(
                //for titles
                headline1: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'Changa',
                ),
                headline2: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'Changa',
                ),

                // for description
                headline3: TextStyle(
                  color: Color(0xFFF9AF4B),
                  fontSize: 24.sp,
                  fontFamily: 'FFHekaya',
                ),

                // for button text
                headline4: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontFamily: 'FFHekaya',
                  fontWeight: FontWeight.bold,
                ),

                //for body
                headline5: TextStyle(
                  color: Colors.black,
                  fontSize: 22.sp,
                  fontFamily: 'FFHekaya',
                  fontWeight: FontWeight.bold,
                ),
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 18.sp,
                  fontFamily: 'FFHekaya',
                ),
                bodyText1: TextStyle(
                  color: Colors.black,
                  fontSize: 20.sp,
                  fontFamily: 'FFHekaya',
                  fontWeight: FontWeight.bold,
                )),
          ),
          home: sharedPref.getString('parent_id') == null
              ? firstSc()
              : HomePage(),
        );
      },
    );
  }
}
