import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/decks.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../util/imports.dart';

class ProjectCategory extends StatelessWidget {
  ProjectCategory({
    super.key,
    required this.category,
    required this.postTitle,
    required this.user,
    required this.content,
    required this.timestamp,
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
  final Text postTitle;
  final String user;
  final Text content;
  final String timestamp;
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
    print(textConstraint);
    return Container(
      // margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [
          Color.fromARGB(240, 19, 19, 19),
          Color.fromARGB(194, 33, 33, 33),
        ], transform: GradientRotation(180)),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color.fromARGB(182, 60, 60, 60)),
      ),
      constraints: const BoxConstraints(),
      // height: 2 * textBoxHeight,
      width: width,
      child: Padding(
        padding: EdgeInsets.all(1.5.w(context)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(margin: const EdgeInsets.only(bottom: 5), width: textConstraint, child: postTitle),
                Container(
                  child: Row(
                    spacing: 0.5.w(context),
                    children: [
                      Placeholder(
                        child: Text('Badge'),
                        // fallbackWidth: 3.sp(context),
                        fallbackHeight: 3.sp(context),
                      ),
                      Text(user, style: TextStyle(fontSize: 3.sp(context), fontWeight: FontWeight.w500)),
                    ],
                  ),
                )
              ],
            ),
            TextField(),
            //
            // Category Label
            //
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [gradient1, gradient2]),
                      boxShadow: [BoxShadow(color: neonGlow, blurRadius: 20, blurStyle: BlurStyle.solid)],
                      borderRadius: const BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      category,
                      style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white, shadows: [
                        Shadow(
                          color: shadowColor,
                          blurRadius: 1,
                        ),
                        Shadow(
                          color: shadowColor,
                          blurRadius: 2,
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
