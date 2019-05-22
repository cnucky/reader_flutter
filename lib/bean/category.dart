class MyCategory {
  String Id;
  String Name;
  int Count;

  static MyCategory fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    MyCategory category = MyCategory();
    category.Id = map['Id'];
    category.Name = map['Name'];
    category.Count = map['Count'];
    return category;
  }
}