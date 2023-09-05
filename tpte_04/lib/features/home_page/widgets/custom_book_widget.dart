import 'package:flutter/material.dart';
import 'package:tpte_04/features/home_page/data/database/app_db.dart';

import '../presentation/detail_page.dart';

class CustomCard extends StatelessWidget {
  const CustomCard(
      {super.key,
      required this.book,
      required this.appDb,
      required this.notify});
  final AppDb appDb;
  final TbBookData book;
  final Function notify;
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  appDb: appDb,
                  book: book,
                  notify: notify,
                ),
              ));
        },
        child: Center(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                book.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 350,
              width: double.infinity,
            ),
          ],
        )),
      ),
    );
  }
}
