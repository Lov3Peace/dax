import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/decks.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../util/imports.dart';

class ProjectCategory extends StatelessWidget {
  ProjectCategory({
    super.key,
    required this.category,
    required this.description,
    this.content,
    this.height,
    this.width,
    this.image,
    this.textConstraint,
  });
  final String category;
  final String description;
  final Text? content;
  final double? height;
  final double? width;
  final Image? image;
  final double? textConstraint;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      child: Container(
        // margin: const EdgeInsets.only(top: 20),
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: [
            Color.fromARGB(240, 19, 19, 19),
            Color.fromARGB(194, 33, 33, 33),
          ], transform: GradientRotation(180)),
          borderRadius: BorderRadius.circular(1.25.w(context)),
          border: Border.all(color: const Color.fromARGB(182, 60, 60, 60)),
        ),
        constraints: const BoxConstraints(minHeight: 425, minWidth: 500),
        height: 50.h(context),
        width: width,
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              Stack(
                children: [
                  // Container(
                  //   decoration: BoxDecoration(boxShadow: [
                  //     BoxShadow(
                  //       color: Colors.red,
                  //       offset: Offset(1, 1),
                  //       spreadRadius: -3,
                  //     )
                  //   ], borderRadius: BorderRadius.circular(1.5.w(context))),
                  // ),
                  Container(
                    constraints: BoxConstraints(minHeight: 350),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1.5.w(context)),
                      child: Image.asset(
                          fit: BoxFit.cover,
                          width: 35.w(context),
                          "../../../../../images/construction-project.jpg"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category,
                            style: TextStyle(
                                fontSize: 5.sp(context),
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            description,
                            style: TextStyle(
                                fontSize: 2.sp(context),
                                fontWeight: FontWeight.w500),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: TactileButton(
                        scale: 1.08,
                        child: Icon(
                          Icons.add_circle,
                          size: 40,
                        )),
                  ),
                ],
              ),
              //
              // Category Label
              //
            ],
          ),
        ),
      ),
    );
  }
}
