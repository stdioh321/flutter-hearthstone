class SortModel {
  String label;
  String dir;

  static List<String> types = [
    "A-Z",
    "Mana",
    "Atk",
    "Health",
  ];

  SortModel({this.label, this.dir});
}
