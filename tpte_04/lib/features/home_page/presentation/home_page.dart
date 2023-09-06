import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:tpte_04/features/home_page/data/database/app_db.dart';

import '../widgets/custom_book_widget.dart';
//import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppDb _appDb;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _filterController = TextEditingController();

  bool filterByTitle = true;

  @override
  void initState() {
    _appDb = AppDb();
    super.initState();
  }

  @override
  void dispose() {
    _appDb.close();
    _titleController.dispose();
    _authorController.dispose();
    _genreController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  refresh() {
    setState(() {});
  }

  addDialog() {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add Book"),
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
                    _appDb.createBook(entity);
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
        toolbarHeight: 120 + kToolbarHeight,
        centerTitle: true,
        title: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.book),
                    Text('Library of Babel'),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: addDialog,
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Filter by:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Title",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      value: filterByTitle,
                      onChanged: (value) {
                        setState(() {
                          filterByTitle = value!;
                        });
                      }),
                ),
                Expanded(
                  child: CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      title: const Text(
                        "Author",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                      value: !filterByTitle,
                      onChanged: (value) {
                        setState(() {
                          filterByTitle = !value!;
                        });
                      }),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 12.0,
                bottom: 12.0,
                left: 8.0,
                right: 8.0,
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)),
                child: TextField(
                  onChanged: (value) => setState(() {
                    _filterController.text = value;
                  }),
                  decoration: InputDecoration(
                    labelText:
                        "Search Books by ${filterByTitle ? "title" : "author"}...",
                    border: InputBorder.none,
                    icon: IconButton(
                        onPressed: () {}, icon: const Icon(Icons.search)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FutureBuilder<List<TbBookData>>(
          future: _appDb.getBooks(),
          builder: (context, snapshot) {
            final List<TbBookData>? books = snapshot.data;
            if (snapshot.connectionState != ConnectionState.done) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text('ERROR'),
              );
            }
            if (books != null) {
              return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
                  itemCount: books.length,
                  itemBuilder: (context, index) {
                    final book = books[index];
                    if (filterByTitle) {
                      if (book.title
                          .toLowerCase()
                          .contains(_filterController.text.toLowerCase())) {
                        return CustomCard(
                          context: context,
                          notify: refresh,
                          appDb: _appDb,
                          book: book,
                        );
                      }
                    } else {
                      if (book.author
                          .toLowerCase()
                          .contains(_filterController.text.toLowerCase())) {
                        return CustomCard(
                          context: context,
                          notify: refresh,
                          appDb: _appDb,
                          book: book,
                        );
                      }
                    }

                    return const SizedBox();
                  });
            }
            return const Text('No Data Found');
          },
        ),
      ),
    );
  }
}
