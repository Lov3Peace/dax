import "package:flutter_application_1/util/imports.dart";
import "package:flutter_application_1/util/ui/pillButton.dart";

class ProjectDashFeed extends StatefulWidget {
  const ProjectDashFeed({super.key});

  @override
  State<ProjectDashFeed> createState() => _ProjectDashFeedState();
}

class _ProjectDashFeedState extends State<ProjectDashFeed> {
  @override
  Widget build(BuildContext context) {
    return BlurryContainer(
      // constraints: BoxConstraints(minWidth: 100, minHeight: 100),
      padding: EdgeInsets.all(max(5, 1.w(context))),
      color: tran,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Feed",
                style: TextStyle(
                  fontSize: max(16, 4.sp(context)),
                  fontWeight: FontWeight.bold,
                  color: grey,
                ),
              ),
              PillButton(
                scale: 1.04,
                padding: EdgeInsetsGeometry.symmetric(
                  horizontal: max(10, 2.w(context)),
                  vertical: max(5, 0.5.w(context)),
                ),
                color: tran,
                textColor: darkGrey,
                borderRadius: 10.w(context),
                borderColor: darkGrey,
                text: 'New Post',
                textSize: max(12, 2.sp(context)),
              )
            ],
          )
        ],
      ),
    );
  }
}
