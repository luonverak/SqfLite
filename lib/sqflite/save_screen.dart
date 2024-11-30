import 'package:flutter/material.dart';
import 'package:local_stograge/sqflite/controller_database.dart';
import 'package:local_stograge/sqflite/model.dart';

class SaveScreen extends StatefulWidget {
  const SaveScreen({super.key});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text("Save note"),
        actions: [
          IconButton(
            onPressed: () async {
              final title = _title.text;
              final description = _description.text;
              final date = DateTime.now().toString();

              await ControllerDatabase().insertData(
                model: Model(
                  title: title,
                  description: description,
                  date: date,
                ),
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: "Title"),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: _description,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Description",
              ),
              minLines: 5,
              maxLines: 20,
            )
          ],
        ),
      ),
    );
  }
}
