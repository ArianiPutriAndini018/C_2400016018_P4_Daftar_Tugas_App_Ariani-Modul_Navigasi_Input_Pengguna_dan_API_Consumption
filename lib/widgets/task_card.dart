import 'package:flutter/material.dart';

import '../models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onLongPress,
  });

  Color getStatusColor(bool isDone) {
    return isDone ? const Color(0xFF4CAF50) : const Color(0xFF800000);
  }

  String getStatusText(bool isDone) {
    return isDone ? 'SELESAI' : 'BELUM';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 227, 221, 203),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    task.judul,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF633A2C),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor(task.isDone).withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    getStatusText(task.isDone),
                    style: TextStyle(
                      color: getStatusColor(task.isDone),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            Row(
              children: [
                const Icon(
                  Icons.book_rounded,
                  color: Color(0xFF800000),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  task.mataKuliah,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF633A2C),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xFFB8860B),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  task.deadline,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF633A2C),
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.access_time_rounded,
                  color: Color(0xFFB88A2C),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  task.jam,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF633A2C),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 249, 231),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.description_rounded,
                    color: Color(0xFF800000),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      task.deskripsi,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color.fromARGB(255, 92, 62, 52),
                      ),
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