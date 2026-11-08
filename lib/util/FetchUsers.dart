// Fetch Users Future to get users from database (used in CarbonSearchBox)
import 'dart:convert';
import 'imports.dart';
import 'package:http/browser_client.dart' as httpClient;

Future fetchUsers(searchString) async {
  // debugPrint("Users before setState fetch: $users");
  final client = httpClient.BrowserClient()..withCredentials = true;
  try {
    final getUsersEndpoint =
        Uri.parse("$hostname/api/getUsers?searchString=$searchString");
    final res = await client.get(
      getUsersEndpoint,
      headers: {
        "Content-Type": "application/json",
      },
    );
    final List body = jsonDecode(res.body);
    // debugPrint("Users after setState fetch: $users");
    return body;
  } catch (e) {
    // debugPrint("Could not fetch users: $e");
  }
  // });
}
