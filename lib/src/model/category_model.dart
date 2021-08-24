class CategoryModel {
  CategoryModel({required this.id, required this.title, this.courses});

  CategoryModel.fromJson(Map<String, Object?> json)
      : this(
          id: json['id']! as String,
          title: json['title']! as String,
        );

  final String id;
  final String title;
  List<CourseModel>? courses;
  set setCourse(List<CourseModel> courses) {
    this.courses = courses;
  }
}

class CourseModel {
  CourseModel(
      {required this.id,
      required this.title,
      required this.desc,
      required this.img});

  CourseModel.fromJson(String id, Map<String, Object?> json)
      : this(
          id: id,
          title: json['title']! as String,
          desc: json['desc']! as String,
          img: json['img']! as String,
        );

  final String id;
  final String title;
  final String desc;
  final String img;
}
