import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:supercharged/supercharged.dart';
import '../../util/imports.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var node_endpoint = Uri.parse('https://localhost:7777/api/register');

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
