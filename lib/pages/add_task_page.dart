import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task_model.dart';
import '../services/api_service.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController judulController = TextEditingController();
  final TextEditingController mataKuliahController = TextEditingController();
  final TextEditingController deskripsiController = TextEditingController();

  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  bool isLoading = false;

  Future<void> pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  Future<void> saveTask() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (selectedDate == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih deadline')));
      return;
    }

    if (selectedTime == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Silakan pilih jam')));
      return;
    }

    setState(() {
      isLoading = true;
    });

    final task = TaskModel(
      judul: judulController.text,
      mataKuliah: mataKuliahController.text,
      deadline: DateFormat('yyyy-MM-dd').format(selectedDate!),
      jam:
          '${selectedTime!.hour.toString().padLeft(2, '0')}:${selectedTime!.minute.toString().padLeft(2, '0')}',
      deskripsi: deskripsiController.text,
      isDone: false,
    );

    final success = await ApiService.addTask(task);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tugas berhasil ditambahkan')),
      );

      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Gagal menambahkan tugas')));
    }
  }

  @override
  void dispose() {
    judulController.dispose();
    mataKuliahController.dispose();
    deskripsiController.dispose();
    super.dispose();
  }

  InputDecoration inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: const Icon(Icons.circle, color: Color(0xFF800000)),
      filled: true,
      fillColor: const Color(0xFFF8F4E9),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: Color(0xFF800000), width: 2),
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
          'Tambah Tugas',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFF8F4E9),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F4E9),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.assignment_rounded,
                      size: 70,
                      color: Color(0xFF800000),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      'Tambah Tugas Baru',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF633A2C),
                      ),
                    ),

                    const SizedBox(height: 30),

                    TextFormField(
                      controller: judulController,
                      decoration: inputDecoration(
                        'Judul Tugas',
                        Icons.title_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: mataKuliahController,
                      decoration: inputDecoration(
                        'Mata Kuliah',
                        Icons.book_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Mata kuliah tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18),

                    GestureDetector(
                      onTap: pickDate,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F4E9),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFB88A2C)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_rounded,
                              color: Color(0xFF800000),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              selectedDate == null
                                  ? 'Pilih Deadline'
                                  : DateFormat(
                                      'dd MMM yyyy',
                                    ).format(selectedDate!),
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedDate == null
                                    ? const Color(0xFFB8860B)
                                    : const Color(0xFF633A2C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    GestureDetector(
                      onTap: pickTime,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 18,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8F4E9),
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: const Color(0xFFB88A2C)),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.access_time_rounded,
                              color: Color(0xFF800000),
                            ),
                            const SizedBox(width: 12),
                            Text(
                              selectedTime == null
                                  ? 'Pilih Jam'
                                  : selectedTime!.format(context),
                              style: TextStyle(
                                fontSize: 16,
                                color: selectedTime == null
                                    ? const Color(0xFFB8860B)
                                    : const Color(0xFF633A2C),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    TextFormField(
                      controller: deskripsiController,
                      maxLines: 5,
                      decoration: inputDecoration(
                        'Deskripsi',
                        Icons.description_rounded,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Deskripsi tidak boleh kosong';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 30),

                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: isLoading ? null : saveTask,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF800000),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: Color(0xFFF8F4E9),
                              )
                            : const Text(
                                'Simpan Tugas',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFFF8F4E9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}