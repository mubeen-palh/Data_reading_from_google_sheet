import 'package:flutter/material.dart';
import 'homepage.dart';

class Menu_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Center(child: Text('Students Data')),
      ),
      body: ListView.builder(
        itemCount: S_names.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Text(S_rno[index].toString()),
              ),
              title: Text(S_names[index]),
              subtitle: Text('Marks: ${S_marks[index]}'),
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Do something when the tile is tapped
              },
            ),
          );
        },
      ),
    );
  }
}
