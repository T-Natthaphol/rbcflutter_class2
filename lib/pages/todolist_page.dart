import 'package:flutter/material.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<String> items = [
  'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Mango',
    'Pineapple',
    'Watermelon',
    'Strawberry',
    'Cherry',
    'Peach'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(45,255,3,1) ,//Colors.amber[400],
        centerTitle: true,
        title: Text('To do list', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext,index){
          return Card(
            child: ListTile(
              leading: Icon(Icons.plus_one),
              title: Text(items[index],),
            ),
          );
        }
        ),
    );
  }
}
