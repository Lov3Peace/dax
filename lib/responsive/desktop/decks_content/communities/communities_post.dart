import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../util/imports.dart';
import '../../../../util/ui/tactile_button.dart';

class CommunitiesPost extends StatefulWidget {
  CommunitiesPost({
    super.key,
    required this.category,
    required this.postTitle,
    required this.user,
    required this.content,
    required this.timestamp,
    this.height,
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
  final String content;
  final String timestamp;
  final double? height;
  final Image? image;
  final double? textConstraint;
  final Color gradient1;
  final Color gradient2;
  final Color neonGlow;
  final Color shadowColor;

  @override
  State<CommunitiesPost> createState() => _CommunitiesPostState();
}

class _CommunitiesPostState extends State<CommunitiesPost> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return TactileButton(
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
        // width: 34.75.w(context),
        // height: 2 * textBoxHeight,
        child: Padding(
          padding: EdgeInsets.all(1.5.w(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      width: widget.textConstraint, child: widget.postTitle),
                  Container(
                    child: Row(
                      // spacing: 0.5.w(context),
                      children: [
                        Placeholder(
                          child: Text('Badge'),
                          // fallbackWidth: 3.sp(context),
                          fallbackHeight: 3.sp(context),
                        ),
                        Text(widget.user,
                            style: TextStyle(
                                fontSize: 3.sp(context),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
                ],
              ),
              //
              // Post Content
              //
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.sp(context)),
                  child: Container(
                    child: Text(
                      widget.content,
                      style: TextStyle(fontSize: 2.5.sp(context)),
                    ),
                  ),
                ),
              ),
              //
              // Category Label
              //
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [widget.gradient1, widget.gradient2]),
                        boxShadow: [
                          BoxShadow(
                              color: widget.neonGlow,
                              blurRadius: 20,
                              blurStyle: BlurStyle.solid)
                        ],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      child: Text(
                        widget.category,
                        style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                color: widget.shadowColor,
                                blurRadius: 1,
                              ),
                              Shadow(
                                color: widget.shadowColor,
                                blurRadius: 2,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  //
                  // Row of Like, Reply, Share Buttons
                  //
                  Row(
                    children: [
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
                          Icons.reply,
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
                  )
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
