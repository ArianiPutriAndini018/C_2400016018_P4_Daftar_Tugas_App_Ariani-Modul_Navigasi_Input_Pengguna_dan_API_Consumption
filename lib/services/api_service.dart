import 'dart:convert';

import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  static const String baseUrl =
      'https://69ff456b2b7ab349602f6f3b.mockapi.io/tugas/daftar_tugas';

  static Future<List<TaskModel>> getTasks() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return data.map((e) => TaskModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data tugas');
    }
  }

  static Future<bool> addTask(TaskModel task) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    return response.statusCode == 201;
  }

  static Future<bool> updateTask(TaskModel task) async {
    final response = await http.put(
      Uri.parse('$baseUrl/${task.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(task.toJson()),
    );

    return response.statusCode == 200;
  }

  static Future<bool> deleteTask(String id) async {
    final response = await http.delete(Uri.parse('$baseUrl/$id'));

    return response.statusCode == 200;
  }
}