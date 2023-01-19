import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/link.dart';

import '../widgets/curvedAppbar.dart';

class AdviceDetailsBullying extends StatefulWidget {
  const AdviceDetailsBullying({Key? key}) : super(key: key);

  @override
  State<AdviceDetailsBullying> createState() => _AdviceDetailsBullyingState();
}

class _AdviceDetailsBullyingState extends State<AdviceDetailsBullying> {
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
          child: Column(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              child: Text(
                'التعامل مع التنمر الإلكتروني',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  لابد من تشجيع طفلك على التعبير عن مشاكله النفسية والاجتماعية، بشكل ودي بينكم واحتوائك لطفلك، وتعليمه كيف يحل المشكلات؟ وأن يلجأ للأسرة دون خوف أو تردد من أي رد فعل.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '* التحكم بأوقات استخدام الأجهزة الالكترونية شيء مهم جدًّا وأساسي بالنسبة لطفلك.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  لابد من مراقبة طفلك حين يستخدم الأجهزة الالكترونية والتأكد من أنه يستخدم تطبيقات مفيدة وغير مؤذية على سلوكه النفسي.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '* تعليم الطفل أن يتجاهل الأشخاص ذوي السلوك السيء.',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  شجع طفلك على تكوين الصداقات والعلاقات الاجتماعية ،لتزيد ثقته في نفسه. ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  عدم نشر الطفل لأي صورة خاصة به أو معلومات عنه، حتى لا يتم استغلالها من قبل المتنمرين.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  إذا علمت بأن طفلك يتعرض للتنمر عليك احتوائه دون توبيخ، حتى لا تظهر عليه مشاكل نفسية لاحقًا. ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  اطلب مساعدة المختصين إن استدعى الأمر، حفاظًا على التوازن النفسي لطفلك.',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse(
                          'https://www.belarabyapps.com/%D8%A7%D9%84%D8%AA%D9%86%D9%85%D8%B1-%D8%A7%D9%84%D8%A5%D9%84%D9%83%D8%AA%D8%B1%D9%88%D9%86%D9%8A/'),
                      builder: (context, followLink) => GestureDetector(
                        onTap: followLink,
                        child: Text(
                          'المصدر هنا',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontFamily: 'FFHekaya',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ))
              ],
            ),
          ),
        ],
      )),
    );
  }
}
