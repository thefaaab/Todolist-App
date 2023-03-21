import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo App',
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<String> _tasks = [];
  final TextEditingController _controller = TextEditingController();
  void _addTask(String task) {
    setState(() {
      _tasks.add(task);
    });
    _controller.clear();
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  void _editTask(int index, String newTask) {
    setState(() {
      _tasks[index] = newTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Center(
            child: Text(
          'Todooo.',
          style: GoogleFonts.poppins(
              color: Colors.black87, fontSize: 30, fontWeight: FontWeight.w500),
        )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'What todooo?',
                  hintStyle: GoogleFonts.poppins(),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20)),
              onSubmitted: (value) {
                _addTask(value);
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.check_circle_rounded),
                          color: Colors.green[700],
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(_tasks[index],
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87)),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          color: Colors.grey[850],
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                String newTask = _tasks[index];
                                return AlertDialog(
                                  title: Text(
                                    'Edit task',
                                    style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        color: Colors.black87,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  content: TextField(
                                    autofocus: true,
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        hintText: "What's wrong?",
                                        hintStyle: GoogleFonts.poppins(
                                          fontSize: 16,
                                        ),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 20)),
                                    onChanged: (value) {
                                      newTask = value;
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Cancel',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'Save',
                                        style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            color: Colors.black87),
                                      ),
                                      onPressed: () {
                                        _editTask(index, newTask);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red[600],
                          onPressed: () {
                            _removeTask(index);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
