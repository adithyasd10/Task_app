import 'package:flutter/material.dart';
import '../models/task.dart';
import 'add_task_page.dart';
import '../widgets/task_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [];
  String query = "";

  void addTask(Task task) {
    setState(() => tasks.add(task));
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
      body: Column(
        children: [
          // Profile Section
          Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(vertical: 40),
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/animations/profile.jpg'),
                ),
                const SizedBox(height: 16),
                const Text(
                  "Welcome back!",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ),

          // Tasks Section with Gradient Background
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/animations/gradient12.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        hintText: 'Search tasks...',
                        hintStyle: TextStyle(color: Colors.white54),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                      ),
                      onChanged: (value) => setState(() => query = value.toLowerCase()),
                    ),
                  ),
                  Expanded(
                    child: filtered.isEmpty
                        ? const Center(child: Text("No tasks yet.", style: TextStyle(color: Colors.white70)))
                        : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final task = filtered[i];
                        final index = tasks.indexOf(task);
                        return TaskCard(
                          task: task,
                          onChanged: (_) => toggleDone(index),
                          onDelete: () => deleteTask(index),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddTaskPage()),
            );
            if (result != null && result is Task) addTask(result);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
