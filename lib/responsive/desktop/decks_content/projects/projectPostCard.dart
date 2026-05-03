import "package:dotted_border/dotted_border.dart";
import "package:dotted_decoration/dotted_decoration.dart";
import "package:dotted_line/dotted_line.dart";
import "package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart";
import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/responsive/desktop/util/dottedLine.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/tactile_button.dart";
import "package:google_fonts/google_fonts.dart";
import "package:ionicons/ionicons.dart";
import "package:score_progress_pretty_display/score_progress_pretty_display.dart";

class ProjectPostCard extends StatefulWidget {
  const ProjectPostCard({
    super.key,
    required this.category,
    required this.postTitle,
    required this.user,
    required this.description,
    required this.teammates,
    required this.rolesNeeded,
    required this.timestamp,
    this.height,
    required this.gradient1,
    required this.gradient2,
    required this.neonGlow,
    required this.shadowColor,
    required this.image,
    this.textConstraint,
  });
  final String category;
  final String postTitle;
  final String user;
  final String description;
  final String teammates;
  final String rolesNeeded;
  final String timestamp;
  final double? height;
  final String image;
  final double? textConstraint;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final Color shadowColor;

  @override
  State<ProjectPostCard> createState() => _ProjectPostCardState();
}

class _ProjectPostCardState extends State<ProjectPostCard> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {},
      child: Container(
        //
        // Parent Container
        //
        decoration: BoxDecoration(
          color: const Color.fromRGBO(17, 17, 17, 0.55),
          borderRadius: BorderRadius.circular(1.25.w(context)),
          border: Border.all(color: deckBorderColor),
        ),
        // constraints: const BoxConstraints(),
        height: 40.w(context),
        // width: double.infinity,
        // height: 2 * textBoxHeight,
        child: Padding(
          padding: EdgeInsets.all(1.5.w(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: Text(
                    widget.postTitle,
                    style: TextStyle(
                        fontSize: 5.sp(context),
                        color: white,
                        fontWeight: FontWeight.w800),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  )),
                  Image.asset(
                    "images/creator.png",
                    width: 2.w(context),
                  ),
                  SizedBox(width: 0.5.w(context)),
                  Text(widget.user,
                      style: TextStyle(
                          fontSize: 4.sp(context), fontWeight: FontWeight.w500),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis)
                ],
              ),
              SizedBox(height: 15),
              //
              // Post Content
              //
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      // Row for Image | Divider | Content
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: 40.w(context)),
                            child: ClipRRect(
                              clipBehavior: Clip.hardEdge,
                              borderRadius:
                                  BorderRadius.circular(1.25.w(context)),
                              // clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                fit: BoxFit.cover,
                                widget.image,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w(context)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                          fontSize: 5.sp(context),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: CarbonDottedLine(
                                          color: Colors.grey,
                                          dashThickness: 1,
                                          dashLength: 1.5,
                                          gapLength: 2),
                                    ),
                                    Text.rich(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      TextSpan(children: [
                                        TextSpan(
                                            text: widget.description,
                                            style: TextStyle(
                                                fontSize: 3.sp(context)))
                                      ]),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Teammates",
                                      style: TextStyle(
                                          fontSize: 5.sp(context),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: CarbonDottedLine(
                                          color: Colors.grey,
                                          dashThickness: 1,
                                          dashLength: 1.5,
                                          gapLength: 2),
                                    ),
                                    Text.rich(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      TextSpan(children: [
                                        TextSpan(
                                            text: widget.teammates,
                                            style: TextStyle(
                                                fontSize: 3.sp(context))),
                                      ]),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Roles Needed",
                                      style: TextStyle(
                                          fontSize: 5.sp(context),
                                          fontWeight: FontWeight.w800),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5),
                                      child: CarbonDottedLine(
                                          color: Colors.grey,
                                          dashThickness: 1,
                                          dashLength: 1.5,
                                          gapLength: 2),
                                    ),
                                    Text.rich(
                                      maxLines: 5,
                                      overflow: TextOverflow.ellipsis,
                                      TextSpan(children: [
                                        TextSpan(
                                            text: widget.rolesNeeded,
                                            style: TextStyle(
                                                fontSize: 3.sp(context)))
                                      ]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 20),
              //
              // Category Label | Actions+Timestamp
              //
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Container(
                  //   decoration: BoxDecoration(
                  //       gradient: LinearGradient(
                  //           colors: [widget.gradient1, widget.gradient2]),
                  //       boxShadow: [
                  //         BoxShadow(
                  //             color: widget.neonGlow,
                  //             blurRadius: 20,
                  //             blurStyle: BlurStyle.solid)
                  //       ],
                  //       borderRadius:
                  //           const BorderRadius.all(Radius.circular(20))),
                  //   child: Padding(
                  //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //     child: Text(
                  //       widget.category,
                  //       style: GoogleFonts.montserrat(
                  //           fontSize: 14,
                  //           fontWeight: FontWeight.w600,
                  //           color: Colors.white,
                  //           shadows: [
                  //             Shadow(
                  //               color: widget.shadowColor,
                  //               blurRadius: 1,
                  //             ),
                  //             Shadow(
                  //               color: widget.shadowColor,
                  //               blurRadius: 2,
                  //             ),
                  //           ]),
                  //     ),
                  //   ),
                  // ),
                  //
                  // Padding(
                  //   padding: EdgeInsets.only(left: 2.w(context)),
                  //   child: PrimaryArcAnimationComponent(
                  //     score: 77,
                  //     maxScore: 100,
                  //     arcHeight: 70,
                  //     arcWidth: 70,
                  //     backgroundArcStrokeThickness: 10,
                  //     progressArcStrokeThickness: 10,
                  //     enableStepperEffect: false,
                  //     isRoundEdges: true,
                  //     minScoreTextFontSize: 14,
                  //     maxScoreTextFontSize: 14,
                  //     isRoundOffScoreWhileProgress: true,
                  //     isRoundOffScore: true,
                  //     showOutOfScoreFormat: false,
                  //     isPrgressCurveFilled: false,
                  //     scoreAnimationDuration: Duration(seconds: 3),
                  //     // scoreTextAnimationDuration: Duration(milliseconds: 700),
                  //     arcBackgroundColor: deckBorderColor,
                  //     arcProgressGradientColors: [red, pink, purp, blue],
                  //     scoreTextStyle: TextStyle(fontSize: 14),
                  //   ),
                  // ),
                  // Spacer(),
                  // Row of Like, Add Request, Share Buttons (Actions)
                  //
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    spacing: 15,
                    children: [
                      Text(
                        "Completion Status",
                        style: TextStyle(
                            fontSize: 2.5.sp(context),
                            fontWeight: FontWeight.w400,
                            color: Colors.grey),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: liked,
                        icon: Icon(
                          Ionicons.heart,
                          color: isLiked ? orange : white,
                        ),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Ionicons.person_add,
                          color: white,
                        ),
                      ),
                      const IconButton(
                        onPressed: null,
                        icon: Icon(
                          Icons.share,
                          color: white,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(right: 2.w(context)),
                          child: FAProgressBar(
                            maxValue: 100,
                            currentValue: 50,
                            size: 17,
                            displayTextStyle: TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w600),
                            displayText: "%",
                            borderRadius: BorderRadius.circular(10.w(context)),
                            backgroundColor: deckBorderColor,
                            animatedDuration: Duration(milliseconds: 300),
                            // border: BoxBorder.all(color: deckBorderColor),
                            progressGradient:
                                LinearGradient(colors: [purp, pink, red]),
                            direction: Axis.horizontal,
                          ),
                        ),
                      ),
                      Text(
                        widget.timestamp,
                        style: TextStyle(
                            fontSize: 4.sp(context),
                            fontWeight: FontWeight.w600,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

// Sets the state of the like button to true if is it false, and false if it is true
  void liked() {
    setState(() {
      isLiked ? isLiked = false : isLiked = true;
    });
  }
}
