import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  final VoidCallback toggleTheme;
  final bool isDark;

  const HomePage({super.key, required this.toggleTheme, required this.isDark});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  String query = "";

  void addTask(Task task) {
    setState(() => tasks.add(task));
  }

  void updateTask(Task updatedTask, int index) {
    setState(() => tasks[index] = updatedTask);
  }

  void deleteTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  void toggleDone(int index) {
    setState(() => tasks[index].isDone = !tasks[index].isDone);
  }

  @override
  Widget build(BuildContext context) {
    final filtered = tasks.where((task) => task.title.toLowerCase().contains(query)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickTasks', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: Icon(widget.isDark ? Icons.wb_sunny : Icons.dark_mode),
            onPressed: widget.toggleTheme,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search tasks...',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16))),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => setState(() => query = value.toLowerCase()),
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const Center(child: Text("No tasks yet."))
                : ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (context, i) {
                final task = filtered[i];
                final index = tasks.indexOf(task);
                return TaskCard(
                  task: task,
                  onToggle: () => toggleDone(index),
                  onEdit: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => AddTaskPage(task: task),
                      ),
                    );
                    if (result != null && result is Task) updateTask(result, index);
                  },
                  onDelete: () => deleteTask(index),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTaskPage()),
          );
          if (result != null && result is Task) addTask(result);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
