import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class PCCrests extends StatefulWidget {
  PCCrests({super.key});

  @override
  State<PCCrests> createState() => PCCrestsState();
}

class PCCrestsState extends State<PCCrests> {
  final List<Map<String, String>> crestData = [
    {"image": "images/creator.png", "label": "Creator"},
    {"image": "images/master.png", "label": "Master"},
    {"image": "images/diamond.png", "label": "Diamond"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: const Color.fromARGB(0, 34, 38, 42),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Crests',
              style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white),
            ),
            SizedBox(
              height: 3.h(context),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: crestData.map((crest) {
                  return Column(
                    children: [
                      Image.asset(
                        crest["image"]!,
                        height: 9.h(context),
                        width: 5.5.w(context),
                        fit: BoxFit.contain,
                      ),
                      Text(
                        crest["label"]!,
                        style: TextStyle(fontSize: 2.5.sp(context), color: Colors.white),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
