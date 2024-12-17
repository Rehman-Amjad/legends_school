class DiaryModel {
  final String title;
  final String description;
  final String classId;
  final String subjectId;
  final String? studentId;
  final String date;
  final String timeStamp;
  // final List<String> attachments;

  DiaryModel({
    required this.title,
    required this.description,
    required this.classId,
    required this.subjectId,
    this.studentId,
    required this.date,
    required this.timeStamp,
    // required this.attachments,
  });

  factory DiaryModel.fromMap(Map<String, dynamic> data) {
    return DiaryModel(
      title: data['title'] ?? "",
      description: data['description'] ?? "",
      classId: data['classId'] ?? "",
      subjectId: data['subjectId'] ?? "",
      studentId: data['studentId'] ?? '',
      date: data['date'] ?? "",
      timeStamp: data['timeStamp'] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "classId": classId,
    "subjectId": subjectId,
    "studentId": studentId,
    "date": date,
    "timeStamp": timeStamp,
    // "attachments": attachments,
  };
}
