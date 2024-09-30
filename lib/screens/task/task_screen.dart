import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final List<Map<String, String>> tasks = [
    {
      'name': 'John Doe',
      'task': 'Complete Report',
      'start': '2024-09-01',
      'end': '2024-09-05',
      'description': 'Finish the financial report for Q3.'
    },
    {
      'name': 'Jane Smith',
      'task': 'Fix Bug',
      'start': '2024-09-03',
      'end': '2024-09-06',
      'description': 'Fix the critical bug in the payment module.'
    },
    {
      'name': 'Michael Johnson',
      'task': 'Design Website',
      'start': '2024-09-07',
      'end': '2024-09-14',
      'description': 'Design the new company website.'
    },
    {
      'name': 'Emily Davis',
      'task': 'Team Meeting',
      'start': '2024-09-09',
      'end': '2024-09-09',
      'description': 'Organize and lead the monthly team meeting.'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Tasks'),
      ),
      body: TaskList(
        tasks: tasks,
        onTap: (task) {
          // Navigate to the task details page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TaskDetailScreen(task: task),
            ),
          );
        },
      ),
    );
  }
}

class TaskList extends StatelessWidget {
  final List<Map<String, String>> tasks;
  final Function(Map<String, String>) onTap;

  const TaskList({required this.tasks, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Card(
          margin: EdgeInsets.all(10.0),
          child: ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.task),
            ),
            title: Text(task['name']!),
            subtitle: Text(task['task']!),
            trailing: Icon(Icons.arrow_forward),
            onTap: () => onTap(task),
          ),
        );
      },
    );
  }
}

class TaskDetailScreen extends StatelessWidget {
  final Map<String, String> task;

  const TaskDetailScreen({required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${task['name']}'s Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskDetail(task: task),
      ),
    );
  }
}

class TaskDetail extends StatelessWidget {
  final Map<String, String> task;

  const TaskDetail({required this.task});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Task: ${task['task']}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text('Start Date: ${task['start']}'),
        SizedBox(height: 10),
        Text('End Date: ${task['end']}'),
        SizedBox(height: 10),
        Text('Description: ${task['description']}'),
      ],
    );
  }
}
