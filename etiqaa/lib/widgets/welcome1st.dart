import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeFirst extends StatelessWidget {
  //const WelcomeFirst({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          Image.asset(
            'images/welcome1st.png',
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h),
            child: Text(
                'ستصلك تنبيهات الرسائل غير اللائقة من جهاز طفلك والتي تحتوي على (محتوى الرسالة، تاريخ الرسالة، وقت إرسال الرسالة، اسم المرسل). الرسالة ستكون موجودة على جهازك لمدة أسبوعين، إذا أردت عدم فقدانها يمكنك حفظ الرسالة في سجل التنبيهات',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}
