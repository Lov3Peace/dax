import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:indexed/indexed.dart';
import 'package:sizer/sizer.dart';

class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return Indexer(
      children: [
        Container(
          constraints: BoxConstraints(minWidth: 150, minHeight: 900),
          // margin: EdgeInsets.all(1.w),
          decoration: BoxDecoration(
            color: deckColor,
            borderRadius: BorderRadius.circular(1.w),
            border: Border.all(color: const Color.fromARGB(147, 58, 58, 58)),
            boxShadow: const [
              // BoxShadow(
              //   blurRadius: 5,
              //   color: Color.fromARGB(255, 14, 14, 14),
              //   offset: Offset(5, 5),
              // ),
              //   BoxShadow(
              //     blurRadius: 10,
              //     color: Color.fromARGB(255, 37, 37, 37),
              //     offset: Offset(-5, -5),
              //   )
            ],
          ),

          // height: 90.h,
          width: 15.w,
          margin: EdgeInsets.only(right: 0.5.w),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(1.w, 1.5.w, 1.w, 1.w),
                child: Text(
                  'Messages',
                  style: GoogleFonts.montserrat(textStyle: TextStyle(fontSize: 5.sp, height: 1.0), fontWeight: FontWeight.w600),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(1.w, 0, 1.w, 2.w),
                  constraints: const BoxConstraints(minWidth: 250, minHeight: 650),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.w),
                    color: tran,
                    border: Border.all(color: deckBorderColor),

                    // boxShadow: const [
                    //   BoxShadow(
                    //       color: Color.fromARGB(255, 10, 10, 10),
                    //       spreadRadius: -10),
                    //   BoxShadow(
                    //     color: Color.fromARGB(255, 26, 26, 26),
                    //     spreadRadius: -20.0,
                    //     blurRadius: 30.0,
                    //   ),
                    // ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
