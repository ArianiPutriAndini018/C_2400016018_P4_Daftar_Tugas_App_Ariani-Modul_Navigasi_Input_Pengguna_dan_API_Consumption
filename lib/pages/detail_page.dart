import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/api_service.dart';
import 'edit_task_page.dart';

class DetailPage extends StatefulWidget {
  final TaskModel task;

  const DetailPage({super.key, required this.task});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late bool isDone;

  @override
  void initState() {
    super.initState();
    isDone = widget.task.isDone;
  }

  Future<void> updateStatus() async {
    final updatedTask = TaskModel(
      id: widget.task.id,
      judul: widget.task.judul,
      mataKuliah: widget.task.mataKuliah,
      deadline: widget.task.deadline,
      jam: widget.task.jam,
      deskripsi: widget.task.deskripsi,
      isDone: !isDone,
    );

    final success = await ApiService.updateTask(updatedTask);

    if (success) {
      setState(() {
        isDone = !isDone;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            isDone ? 'Tugas ditandai selesai' : 'Tugas ditandai belum selesai',
          ),
        ),
      );
    }
  }

  Color getStatusColor() {
    return isDone ? const Color(0xFFB8860B) : const Color(0xFF800000);
  }

  String getStatusText() {
    return isDone ? 'SELESAI' : 'BELUM SELESAI';
  }

  Widget buildInfoCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F4E9),
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFFB8860B),
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF633A2C),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0D6B8),

      appBar: AppBar(
        backgroundColor: const Color(0xFF800000),
        title: const Text(
          'Detail Tugas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFF8F4E9),
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF800000), Color(0xFF633A2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
              ),
              child: Column(
                children: [
                  const Icon(
                    Icons.assignment_rounded,
                    color: Color(0xFFF8F4E9),
                    size: 70,
                  ),

                  const SizedBox(height: 18),

                  Text(
                    widget.task.judul,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Color(0xFFF8F4E9),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isDone ? Colors.green : const Color(0xFF800000),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      getStatusText(),
                      style: const TextStyle(
                        color: Color(0xFFF8F4E9),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            buildInfoCard(
              icon: Icons.book_rounded,
              color: const Color(0xFF800000),
              title: 'Mata Kuliah',
              value: widget.task.mataKuliah,
            ),

            buildInfoCard(
              icon: Icons.calendar_month_rounded,
              color: const Color(0xFFB8860B),
              title: 'Deadline',
              value: widget.task.deadline,
            ),

            buildInfoCard(
              icon: Icons.access_time_rounded,
              color: const Color(0xFFB88A2C),
              title: 'Jam',
              value: widget.task.jam,
            ),

            buildInfoCard(
              icon: Icons.description_rounded,
              color: const Color(0xFF633A2C),
              title: 'Deskripsi',
              value: widget.task.deskripsi,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: ElevatedButton.icon(
                onPressed: updateStatus,
                style: ElevatedButton.styleFrom(
                  backgroundColor: getStatusColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: Icon(
                  isDone ? Icons.close_rounded : Icons.check_rounded,
                  color: const Color(0xFFF8F4E9),
                ),
                label: Text(
                  isDone ? 'Tandai Belum Selesai' : 'Tandai Selesai',
                  style: const TextStyle(
                    color: Color.fromARGB(255, 233, 248, 234),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            SizedBox(
              width: double.infinity,
              height: 58,
              child: OutlinedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditTaskPage(task: widget.task),
                    ),
                  );

                  if (result == true) {
                    if (!context.mounted) return;
                    Navigator.pop(context, true);
                  }
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF800000), width: 2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                icon: const Icon(Icons.edit_rounded, color: Color(0xFF800000)),
                label: const Text(
                  'Edit Tugas',
                  style: TextStyle(
                    color: Color(0xFF800000),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 18),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F4E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.info_outline_rounded, color: Color(0xFFB88A2C)),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      'Gunakan tombol di atas untuk mengubah status tugas.',
                      style: TextStyle(fontSize: 14, color: Color(0xFF633A2C)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}