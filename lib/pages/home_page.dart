import 'package:flutter/material.dart';

import '../models/task_model.dart';
import '../services/api_service.dart';
import '../widgets/filter_chip_widget.dart';
import '../widgets/task_card.dart';
import 'add_task_page.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<TaskModel>> futureTasks;

  String selectedFilter = 'Semua';

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  void fetchTasks() {
    futureTasks = ApiService.getTasks();
  }

  Future<void> refreshData() async {
    setState(() {
      fetchTasks();
    });
  }

  List<TaskModel> filterTasks(List<TaskModel> tasks) {
    if (selectedFilter == 'Selesai') {
      return tasks.where((task) => task.isDone).toList();
    }

    if (selectedFilter == 'Belum') {
      return tasks.where((task) => !task.isDone).toList();
    }

    return tasks;
  }

  Future<void> deleteTask(String id) async {
    final success = await ApiService.deleteTask(id);

    if (success) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Tugas berhasil dihapus')));

      refreshData();
    }
  }

  Future<void> showDeleteDialog(String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF8F4E9),
          title: const Text(
            'Hapus Tugas',
            style: TextStyle(color: Color(0xFF800000)),
          ),
          content: const Text(
            'Yakin ingin menghapus tugas ini?',
            style: TextStyle(color: Color(0xFF633A2C)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Batal',
                style: TextStyle(color: Color(0xFFB8860B)),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF800000),
              ),
              onPressed: () async {
                Navigator.pop(context);
                await deleteTask(id);
              },
              child: const Text(
                'Hapus',
                style: TextStyle(color: Color(0xFFF8F4E9)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(320),

        child: Container(
          padding: const EdgeInsets.fromLTRB(24, 55, 24, 24),

          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF800000), Color(0xFF633A2C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),

            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),

          child: Stack(
            children: [
              Positioned(
                right: -20,
                top: 30,
                child: Icon(
                  Icons.assignment_rounded,
                  size: 190,
                  color: Colors.white.withValues(alpha: 0.05),
                ),
              ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F4E9).withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(18),
                        ),

                        child: const Icon(
                          Icons.assignment_rounded,
                          color: Color(0xFFF8F4E9),
                          size: 30,
                        ),
                      ),

                      const Spacer(),

                      Container(
                        padding: const EdgeInsets.all(10),

                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F4E9).withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),

                        child: const Icon(
                          Icons.notifications_none_rounded,
                          color: Color(0xFFF8F4E9),
                        ),
                      ),
                    ],
                  ),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Haloo, Ariani Putri Andini',
                        style: TextStyle(
                          color: Color(0xFFE0D6B8),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 4),

                      Text(
                        '2400016018',
                        style: TextStyle(
                          color: Color(0xFFF8F4E9),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daftar Tugas',
                        style: TextStyle(
                          color: Color(0xFFF8F4E9),
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SizedBox(height: 6),

                      Text(
                        'Organize your tasks efficiently ^_^',
                        style: TextStyle(
                          color: Color(0xFFE0D6B8),
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: const EdgeInsets.all(16),

                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F4E9).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(22),
                    ),

                    child: const Row(
                      children: [
                        Icon(
                          Icons.calendar_month_rounded,
                          color: Color(0xFFF8F4E9),
                        ),

                        SizedBox(width: 12),

                        Expanded(
                          child: Text(
                            'Jangan lupa cek deadline tugas hari ini!',
                            style: TextStyle(
                              color: Color(0xFFF8F4E9),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF800000),

        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );

          if (result == true) {
            refreshData();
          }
        },

        icon: const Icon(Icons.add, color: Color(0xFFF8F4E9)),

        label: const Text('Tambah', style: TextStyle(color: Color(0xFFF8F4E9))),
      ),

      body: RefreshIndicator(
        color: const Color(0xFF800000),
        onRefresh: refreshData,

        child: Column(
          children: [
            const SizedBox(height: 10),

            SizedBox(
              height: 45,

              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),

                children: [
                  FilterChipWidget(
                    label: 'Semua',
                    isSelected: selectedFilter == 'Semua',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Semua';
                      });
                    },
                  ),

                  FilterChipWidget(
                    label: 'Selesai',
                    isSelected: selectedFilter == 'Selesai',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Selesai';
                      });
                    },
                  ),

                  FilterChipWidget(
                    label: 'Belum',
                    isSelected: selectedFilter == 'Belum',
                    onTap: () {
                      setState(() {
                        selectedFilter = 'Belum';
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Expanded(
              child: FutureBuilder<List<TaskModel>>(
                future: futureTasks,

                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF800000),
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        'Terjadi kesalahan',
                        style: TextStyle(color: Color(0xFF633A2C)),
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text(
                        'Belum ada tugas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF633A2C),
                        ),
                      ),
                    );
                  }

                  final tasks = filterTasks(snapshot.data!);

                  if (tasks.isEmpty) {
                    return const Center(
                      child: Text(
                        'Data tidak ditemukan',
                        style: TextStyle(color: Color(0xFF633A2C)),
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),

                    itemCount: tasks.length,

                    itemBuilder: (context, index) {
                      final task = tasks[index];

                      return TaskCard(
                        task: task,

                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailPage(task: task),
                            ),
                          );

                          refreshData();
                        },

                        onLongPress: () {
                          showDeleteDialog(task.id!);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}