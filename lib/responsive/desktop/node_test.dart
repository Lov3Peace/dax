import 'package:flutter_application_1/responsive/desktop/util/web_ui_template.dart';
import 'package:supercharged/supercharged.dart';
import '../../util/imports.dart';
import 'package:http/http.dart' as http;

var node_endpoint = Uri.parse('http://127.0.0.1:7777/node');

class NodeTest extends StatelessWidget {
  NodeTest({super.key});

  Future fetch(url) async {
    http.Response res = await http.get(node_endpoint);
    var body = res.body;
    print(body);
    return body;
  }

  var res = http.get(node_endpoint);

  @override
  Widget build(BuildContext context) {
    return WebUiTemplate(
      child: Column(
        children: [
          Container(
            child: Text(fetch(node_endpoint).toString()),
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
