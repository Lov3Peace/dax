import 'dart:math';

class TagLists {
  static final TagLists _instance = TagLists._internal();

  factory TagLists() {
    return _instance;
  }

  TagLists._internal() {
    print("TagLists initialized");
  }
  List activeTags = ['1', '2', '3', '4'];
  List inactiveTags = List.generate(100, (index) => Random().toString());
  List group1Tags = ['1', '2', '3', '4'];
  List group2Tags = ['5', '6', '7', '8'];
}
