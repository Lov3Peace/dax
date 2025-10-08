import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/responsive/desktop/util/go_routes.dart';
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
    required this.imageDir,
    required this.route,
    this.height,
    this.width,
    this.textConstraint,
  });
  final String category;
  final String description;
  final double? height;
  final double? width;
  final String imageDir;
  final double? textConstraint;
  final String route;

  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        router.goNamed("category-posts", pathParameters: {"category": route});
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromRGBO(17, 17, 17, 0.55),
          borderRadius: BorderRadius.circular(1.25.w(context)),
          border: Border.all(color: deckBorderColor),
        ),
        constraints: const BoxConstraints(minHeight: 460, minWidth: 450),
        height: 50.h(context),
        width: 35.25.w(context),
        // width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(1.w(context)),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      constraints:
                          const BoxConstraints(minHeight: 350, minWidth: 350),
                      // height: 35.5.h(context),
                      width: 35.5.w(context),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(1.25.w(context)),
                        child: Image.network(imageDir, fit: BoxFit.cover),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
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
                                fontSize:
                                    100.w(context) >= 1920 ? 2.sp(context) : 12,
                                fontWeight: FontWeight.w500),
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: TactileButton(
                        scale: 1.05,
                        child: Icon(
                          Icons.add_circle,
                          size: 2.w(context),
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
