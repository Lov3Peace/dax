import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../main.dart';

//
// FAQs button for the help side panel
//
class FAQs extends StatefulWidget {
  const FAQs({super.key});

  @override
  State<FAQs> createState() => _FAQsState();
}

class _FAQsState extends State<FAQs> {
//start active is false
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //
          //activates the settings popup
          isActive = !isActive;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        decoration: BoxDecoration(
          border: Border.all(color: isActive ? Colors.black87 : tran),
          boxShadow: [
            BoxShadow(color: isActive ? Colors.white : Colors.grey.shade700),
          ],
          color: tran,
          borderRadius: const BorderRadius.all(Radius.circular(60)),
        ),
        width: isActive ? 11.w : 9.w,
        height: 4.h,
        alignment: Alignment.center,
        child: addElement(),
      ),
    );
  }

  addElement() {
    return Padding(
      padding: EdgeInsets.only(left: isActive ? 4.75.w : 3.5.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'FAQs',
            style: GoogleFonts.montserrat(
                textStyle: TextStyle(fontSize: 2.sp),
                fontWeight: FontWeight.w400,
                color: isActive
                    ? const Color.fromARGB(221, 28, 24, 24)
                    : Colors.white54),
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 4.w),
          //   child: Stack(
          //     children: [
          //       Icon(
          //         Icons.arrow_right_sharp,
          //         color: isActive ? Colors.white70 : tran,
          //         size: 30.0,
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           setState(() {
          //             //
          //             //gives the active color to be flase
          //             isActive = false;
          //           });
          //         },
          //         child: MouseRegion(
          //             // onEnter: (e) {
          //             //   setState(() {
          //             //     isHover2 = true;
          //             //   });
          //             // },
          //             // onExit: (e) {
          //             //   setState(() {
          //             //     isHover2 = false;
          //             //   });
          //             // },
          //             // child: Icon(
          //             //   Icons.cancel_rounded,
          //             //   color: (isActive && isHover2)
          //             //       ? red
          //             //       : (!isHover2 && isActive)
          //             //           ? Colors.black87
          //             //           : tran,
          //             //   size: 30.0,
          //             // ),
          //             ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}

//
// this houses all the information for the faqs button
//
class FAQsInformation extends StatefulWidget {
  const FAQsInformation({super.key});

  @override
  State<FAQsInformation> createState() => _FAQsInformationState();
}

class _FAQsInformationState extends State<FAQsInformation> {
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
