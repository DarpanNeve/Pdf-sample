class DataModel {
  final String name;
  final int marks;

  DataModel({required this.name, required this.marks});
  DataModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        marks = json['marks'];
}
