// Import necessary packages and libraries
import 'package:flutter/material.dart';

class ListPage extends StatelessWidget {
  final List<Map<String, dynamic>> result;

  const ListPage({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List Page'),
      ),
      body: ListView.builder(
        itemCount: result.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                'ID: ${result[index]['id']}, Title: ${result[index]['title']}'),
          );
        },
      ),
    );
  }
}
