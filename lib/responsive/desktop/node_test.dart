import 'package:flutter_application_1/responsive/desktop/desk_dock_bubbles.dart';
import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:supercharged/supercharged.dart';
import '../../util/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final node_endpoint = Uri.parse('https://$hostname/api/register');

class NodeTest extends StatelessWidget {
  NodeTest({super.key});

  Future<String> fetch(url) async {
    http.Response res = await http.get(node_endpoint);
    String body = res.body;
    // print(body);
    return body;
  }

  var res = http.get(node_endpoint);

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      title: "NodeTest",
      button1: ProjectsButton(),
      button2: CommunitiesButton(),
      button3: SocialsButton(),
      child: Column(
        children: [
          Container(
            child: FutureBuilder(
                future: fetch(node_endpoint),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!);
                  } else {
                    return Text('${snapshot.error}');
                  }
                }),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () => fetch(node_endpoint),
              child: Text('Connect'),
            ),
          ),
        ],
      ),
    );
  }
}
