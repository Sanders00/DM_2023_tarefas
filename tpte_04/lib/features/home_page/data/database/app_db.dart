import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../tables/book.dart';

part 'app_db.g.dart';

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'app.sqlite'));

    return NativeDatabase(file);
  });
}

@DriftDatabase(tables: [TbBook])
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<TbBookData>> getBooks() async {
    return await select(tbBook).get();
  }

  Future<TbBookData> getSingleBook(int id) async {
    return await (select(tbBook)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<int> createBook(TbBookCompanion entity) async {
    return await into(tbBook).insert(entity);
  }

  Future<bool> updateBook(TbBookCompanion entity) async {
    return await update(tbBook).replace(entity);
  }

  Future<int> deleteBook(int id) async {
    return await (delete(tbBook)..where((tbl) => tbl.id.equals(id))).go();
  }
}
