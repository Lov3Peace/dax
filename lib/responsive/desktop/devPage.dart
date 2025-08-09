import 'package:flutter_application_1/responsive/desktop/decks_content/projects/project_cat_stack.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import '../../util/imports.dart';

class Devpage extends StatelessWidget {
  const Devpage({super.key});

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
        child: ProjectCategory(
            category: "Category",
            postTitle: Text("Title"),
            user: "l3x",
            content: Text("Content"),
            timestamp: "TimeStamp",
            gradient1: red,
            gradient2: pink,
            neonGlow: pink,
            shadowColor: white));
  }
}
