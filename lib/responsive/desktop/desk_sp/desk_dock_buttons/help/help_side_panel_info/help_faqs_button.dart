import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

//
// this houses all the information for the faqs button
//
class FAQsInformation extends StatelessWidget {
  const FAQsInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.5.h,
      width: 45.w,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(25, 25, 29, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 3.w),
              child: const Text(
                'FAQs',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 36),
              ),
            ),
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            // Mission Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Q: How can I go hawda?'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            //Origin Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Q: Is going hawda mandatory?'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
            //
            //
            const Divider(
              color: Colors.grey,
              indent: 20,
              endIndent: 30,
            ),
            //
            //Founders Container
            Container(
              height: 24.h,
              width: 45.w,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(25, 25, 29, 0.233),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 3.w, top: 1.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Q: Will Lex ever go hawda?'),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5.h, right: 1.5.w),
                      child: const Text(
                          'The passage experienced a surge in popularity during the 1960s when Letraset used it on their dry-transfer sheets, and again during the 90s as desktop publishers bundled the text with their software. Today it is seen around the web; on templates, websites, and stock designs. Use our generator to get your own, or read on for the authoritative history of lorem ipsum'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
