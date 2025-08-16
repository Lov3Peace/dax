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
    required this.content,
    this.height,
    this.width,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    required this.shadowColor,
    this.image,
    this.textConstraint,
  });
  final String category;
  final String description;
  final Text content;
  final double? height;
  final double? width;
  final Image? image;
  final double? textConstraint;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final Color shadowColor;

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
          borderRadius: BorderRadius.circular(1.w(context)),
          border: Border.all(color: const Color.fromARGB(182, 60, 60, 60)),
        ),
        constraints: const BoxConstraints(),
        // height: 2 * textBoxHeight,
        width: width,
        child: Padding(
          padding: EdgeInsets.all(1.5.w(context)),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        offset: Offset(1, 1),
                        spreadRadius: -3,
                      )
                    ], borderRadius: BorderRadius.circular(1.5.w(context))),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(1.5.w(context)),
                    child: Image.asset(
                        // height: 30.h(context),
                        width: 35.w(context),
                        "../../../../../images/construction-project.jpg"),
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
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
                              fontSize: 2.5.sp(context),
                              fontWeight: FontWeight.w500),
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 30, left: 30),
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
