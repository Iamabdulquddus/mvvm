class NotesModel {
  String? title;
  String? description;

  NotesModel({this.title, this.description});

  NotesModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['title'] = title;
    data['description'] = description;
    return data;
  }
}