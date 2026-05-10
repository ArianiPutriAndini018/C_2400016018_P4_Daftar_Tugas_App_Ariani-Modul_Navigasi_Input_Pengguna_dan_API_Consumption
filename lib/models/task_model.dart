class TaskModel {
  String? id;
  String judul;
  String mataKuliah;
  String deadline;
  String jam;
  String deskripsi;
  bool isDone;

  TaskModel({
    this.id,
    required this.judul,
    required this.mataKuliah,
    required this.deadline,
    required this.jam,
    required this.deskripsi,
    required this.isDone,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      judul: json['judul'] ?? '',
      mataKuliah: json['mataKuliah'] ?? '',
      deadline: json['deadline'] ?? '',
      jam: json['jam'] ?? '',
      deskripsi: json['deskripsi'] ?? '',
      isDone: json['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'judul': judul,
      'mataKuliah': mataKuliah,
      'deadline': deadline,
      'jam': jam,
      'deskripsi': deskripsi,
      'isDone': isDone,
    };
  }
}