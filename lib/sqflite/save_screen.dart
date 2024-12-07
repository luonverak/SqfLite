import 'package:flutter/material.dart';
import 'package:local_stograge/sqflite/controller_database.dart';
import 'package:local_stograge/sqflite/model.dart';

class SaveScreen extends StatefulWidget {
  final Model? model;

  const SaveScreen({super.key, this.model});

  @override
  State<SaveScreen> createState() => _SaveScreenState();
}

class _SaveScreenState extends State<SaveScreen> {
  final _title = TextEditingController();
  final _description = TextEditingController();

  @override
  void initState() {
    if (widget.model != null) {
      _title.text = widget.model!.title;
      _description.text = widget.model!.description;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: widget.model != null
            ? const Text("Edit note")
            : const Text("Save note"),
        actions: [
          IconButton(
            onPressed: () async {
              final title = _title.text;
              final description = _description.text;
              var date = DateTime.now();
              final time =
                  "${date.year.toString()}-${date.month.toString()}-${date.day.toString()}";
              if (widget.model == null) {
                await ControllerDatabase().insertData(
                  model: Model(
                    title: title,
                    description: description,
                    date: time,
                  ),
                ).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note save success'),
                    backgroundColor: Colors.blue,
                  ),
                ));
              } else {
                await ControllerDatabase().editData(
                  model: Model(
                    id: widget.model!.id,
                    title: title,
                    description: description,
                    date: time,
                  ),
                ).then((value) => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Note edit completed'),
                    backgroundColor: Colors.blue,
                  ),
                ));

              }

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
