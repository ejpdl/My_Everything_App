class ToDoModel {

  final int id;
  final String title;
  final String description;
  final String month;
  final String day;

  ToDoModel({

    required this.id,
    required this.title,
    required this.description,
    required this.month,
    required this.day

  });

  factory ToDoModel.fromJson(Map<String, dynamic> json) {

    return ToDoModel(

      id: json['id'],
      title: json['title'],
      description: json['description'],
      month: json['month'],
      day: json['day']

    );

  } 

}