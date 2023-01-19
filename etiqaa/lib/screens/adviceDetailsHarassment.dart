import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/link.dart';
import '../widgets/curvedAppbar.dart';
import 'package:url_launcher/url_launcher.dart';

class AdviceDetailsHarassment extends StatefulWidget {
  const AdviceDetailsHarassment({Key? key}) : super(key: key);

  @override
  State<AdviceDetailsHarassment> createState() =>
      _AdviceDetailsHarassmentState();
}

class _AdviceDetailsHarassmentState extends State<AdviceDetailsHarassment> {
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
                'التعامل مع التحرش الإلكتروني',
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
                    '* عدم التردد في أن تصاحب طفلك،كي يخبرك بنفسه في حال تعرضه لاي عملية تحرش .',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '* الإجابة على كافة أسئلة طفلك، فلا تدعه يستفسر من أصدقائة أو من الانترنت لكي يرضي فضوله .',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '* ضرورة أخذ الموضوع بجدية والتعامل معه يشكل جدي مع الكفل، والاهتمام بصحة الطفل النفسية .',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      '* الطلب من المتحرش التوقف عن ذلك وعمل حظر له في كافة مواقع التواصل.',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                  child: Text(
                    '*  القيام بعمل بلاغات على حسابات المتحرش للحد من تواصله مع الآخرين. ',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Text(
                      '* إبلاغ الجهات المعنية بهذا الحساب لملاحقة هذا المجرم .',
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.w, vertical: 10.h),
                    child: Link(
                      target: LinkTarget.blank,
                      uri: Uri.parse(
                          'https://arabistgroup.com/%D8%A7%D9%84%D8%AA%D8%AD%D8%B1%D8%B4-%D8%A7%D9%84%D8%A7%D9%84%D9%83%D8%AA%D8%B1%D9%88%D9%86%D9%8A/'),
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
