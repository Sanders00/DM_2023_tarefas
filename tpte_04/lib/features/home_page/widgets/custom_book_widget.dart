import 'package:flutter/material.dart';
import 'package:tpte_04/features/home_page/data/database/app_db.dart';
import 'package:drift/drift.dart' as drift;

//import '../presentation/detail_page.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {super.key,
      required this.book,
      required this.appDb,
      required this.notify,
      required this.context});
  final AppDb appDb;
  final TbBookData book;
  final Function notify;
  final BuildContext context;

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
                        id: drift.Value(book.id),
                        title: drift.Value(_titleController.text),
                        author: drift.Value(_authorController.text),
                        genre: drift.Value(_genreController.text),
                        year: drift.Value(_yearController.text));
                    appDb.updateBook(entity);
                    Navigator.pop(context);
                    _titleController.text = '';
                    _authorController.text = '';
                    _genreController.text = '';
                    _yearController.text = '';
                  },
                  child: const Text('Update')),
            ],
          );
        });
  }

  deleteDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Are you sure you want to delete ${book.title}?"),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {
                      appDb.deleteBook(book.id);
                      notify();
                      Navigator.pop(context);
                    },
                    child: const Text("Delete"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"),
                  ),
                ],
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {},
        child: Center(
            child: SizedBox(
          height: 350,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.title,
                  style: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.genre,
                  style: const TextStyle(
                      fontSize: 16, fontStyle: FontStyle.italic),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.author,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  book.year,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: updateDialog,
                    child: const Text("update"),
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.red),
                    ),
                    onPressed: () {
                      deleteDialog();
                    },
                    child: const Text("delete"),
                  ),
                ],
              ),
            ],
          ),
        )),
      ),
    );
  }
}
