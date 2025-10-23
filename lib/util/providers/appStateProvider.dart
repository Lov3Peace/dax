import 'package:flutter_application_1/util/imports.dart';

class AppStateProvider extends ChangeNotifier {
  String _hostname = "";
  String get hostname => _hostname;

  void setHostname(String hostname) {
    _hostname = hostname;
    notifyListeners();
  }
}
