import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';

import '../data/database/app_db.dart';

class DetailPage extends StatefulWidget {
  const DetailPage(
      {super.key,
      required this.appDb,
      required this.book,
      required this.notify});
  final AppDb appDb;
  final TbBookData book;
  final Function notify;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();

  updateDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Update Book"),
            content: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    label: Text("Title:"),
                  ),
                ),
                TextFormField(
                  controller: _authorController,
                  decoration: const InputDecoration(
                    label: Text("Author:"),
                  ),
                ),
                TextFormField(
                  controller: _genreController,
                  decoration: const InputDecoration(
                    label: Text("Genre:"),
                  ),
                ),
                TextFormField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    label: Text("Year:"),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel")),
              TextButton(
                  onPressed: () {
                    final entity = TbBookCompanion(
                        title: drift.Value(_titleController.text),
                        author: drift.Value(_authorController.text),
                        genre: drift.Value(_genreController.text),
                        year: drift.Value(_yearController.text));
                    widget.appDb.updateBook(entity);
                    Navigator.pop(context);
                    _titleController.text = '';
                    _authorController.text = '';
                    _genreController.text = '';
                    _yearController.text = '';
                    setState(() {});
                  },
                  child: const Text('Create')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              widget.notify();
              Navigator.pop(context);
            }),
      ),
      body: Center(
        child: Row(
          children: [
            ElevatedButton(
              onPressed: updateDialog,
              child: const Text("update"),
            ),
            ElevatedButton(
              onPressed: () {
                widget.appDb.deleteBook(widget.book.id);
                widget.notify();
                Navigator.pop(context);
              },
              child: const Text("delete"),
            ),
          ],
        ),
      ),
    );
  }
}
