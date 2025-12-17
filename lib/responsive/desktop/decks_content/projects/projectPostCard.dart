import "package:flutter_application_1/responsive/desktop/desk_decks.dart";
import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/tactile_button.dart";
import "package:google_fonts/google_fonts.dart";
import "package:ionicons/ionicons.dart";

class ProjectPostCard extends StatefulWidget {
  const ProjectPostCard({
    super.key,
    required this.category,
    required this.postTitle,
    required this.user,
    required this.content,
    required this.rolesNeeded,
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
  final String postTitle;
  final String user;
  final String content;
  final String rolesNeeded;
  final String timestamp;
  final double? height;
  final Image? image;
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
        height: 35.25.w(context),
        width: 35.25.w(context),
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
                      width: widget.textConstraint,
                      child: Text(
                        widget.postTitle,
                        style: TextStyle(
                            fontSize: 5.sp(context),
                            color: white,
                            fontWeight: FontWeight.w800),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Container(
                    child: Row(
                      // spacing: 0.5.w(context),
                      children: [
                        Image.asset(
                          "images/creator.png",
                          width: 2.w(context),
                        ),
                        SizedBox(width: 0.5.w(context)),
                        Text(widget.user,
                            style: TextStyle(
                                fontSize: 4.sp(context),
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
                ],
              ),
              //
              // Post Content
              //
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.sp(context)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            height: 35.5.w(context),
                            width: 35.5.w(context),
                            constraints: const BoxConstraints(
                                minHeight: 350, minWidth: 350),
                            child: ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(1.25.w(context)),
                              // clipBehavior: Clip.hardEdge,
                              child: Image.network(
                                  fit: BoxFit.cover,
                                  "https://assets.crbn.cx/carbon-assets/images/${widget.category == "Fashion" ? widget.category.toLowerCase() + ".webp" : widget.category.toLowerCase() + ".jpg"}"),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Description: " + widget.content,
                          style: TextStyle(fontSize: 3.sp(context)),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Roles Needed: " + widget.rolesNeeded,
                          style: TextStyle(fontSize: 3.sp(context)),
                        ),
                      ],
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
