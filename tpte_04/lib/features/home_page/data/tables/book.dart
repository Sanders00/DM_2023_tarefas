import 'package:drift/drift.dart';

class TbBook extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().named('title')();
  TextColumn get author => text().named('author')();
  TextColumn get genre => text().named('genre')();
  TextColumn get year => text().named('year')();
  @override
  Set<Column> get primaryKey => {id};
}
