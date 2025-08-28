import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/api_call.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<Todo> todos = [];

  TextEditingController titleController = TextEditingController();

  int selIndx = -1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    await APICall.fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todo App')),
      body: Column(
        children: [
          // add
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Enter Title',
                    labelText: 'Title',
                  ),
                ),
              ),
              IconButton(
                onPressed: () async {
                  // add to list
                  if (titleController.text.isNotEmpty) {
                    if (selIndx == -1) {
                      todos.add(
                        Todo(title: titleController.text, isCompleted: false),
                      );
                    } else {
                      todos[selIndx].title = titleController.text;
                      selIndx = -1;
                    }
                    print(todos.length);
                    await APICall.addTodo(
                      Todo(title: titleController.text, isCompleted: false),
                    );
                    titleController.clear();

                    setState(() {});
                  }
                },
                icon: Icon(Icons.add),
              ),
            ],
          ),
          // display
          Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder:
                  (context, index) => CheckboxListTile(
                    value: todos[index].isCompleted,
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (v) {
                      print(v);
                      todos[index].isCompleted = v!;
                      setState(() {});
                    },
                    title: Text('${todos[index].title}'),
                    secondary: SizedBox(
                      width:
                          MediaQuery.of(context).size.width * 0.25 > 180
                              ? 180
                              : MediaQuery.of(context).size.width * 0.25,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              selIndx = index;
                              titleController.text = todos[index].title;
                              setState(() {});
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              todos.removeAt(index);
                              setState(() {});
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}