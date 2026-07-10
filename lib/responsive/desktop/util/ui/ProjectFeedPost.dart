import 'package:flutter/material.dart';
import 'package:flutter_application_1/responsive/desktop/desk_decks.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter_application_1/util/ui/CarbonCircleAvatar.dart';

class ProjectFeedPost extends StatefulWidget {
  const ProjectFeedPost(
      {super.key,
      required this.username,
      required this.content,
      required this.timestamp});

  final String username;
  final String content;
  final String timestamp;

  @override
  State<ProjectFeedPost> createState() => _ProjectFeedPostState();
}

class _ProjectFeedPostState extends State<ProjectFeedPost> {
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //
        // Profile Icon, Username, Timestamp
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: max(10, 1.w(context))),
              child: const CarbonCircleAvatar(),
            ),
            //
            // Username
            Text(
              widget.username,
              style: TextStyle(
                  fontSize: max(16, 2.5.sp(context)),
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(width: max(10, 1.w(context))),
            //
            // Timestamp
            Text(
              widget.timestamp,
              style: TextStyle(color: grey, fontSize: max(14, 2.5.sp(context))),
            ),
          ],
        ),
        //
        // Content
        Row(
          children: [
            // This SizedBox is set to the total width of the profile icon + its padding
            SizedBox(width: 3.5.w(context)),
            Expanded(
              //
              // Content
              child: Text(
                widget.content,
                style: TextStyle(fontSize: max(14, 2.5.sp(context))),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        )
      ],
    );
  }
}
