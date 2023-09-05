// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// ignore_for_file: type=lint
class $TbBookTable extends TbBook with TableInfo<$TbBookTable, TbBookData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TbBookTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _authorMeta = const VerificationMeta('author');
  @override
  late final GeneratedColumn<String> author = GeneratedColumn<String>(
      'author', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genreMeta = const VerificationMeta('genre');
  @override
  late final GeneratedColumn<String> genre = GeneratedColumn<String>(
      'genre', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _yearMeta = const VerificationMeta('year');
  @override
  late final GeneratedColumn<String> year = GeneratedColumn<String>(
      'year', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, title, author, genre, year];
  @override
  String get aliasedName => _alias ?? 'tb_book';
  @override
  String get actualTableName => 'tb_book';
  @override
  VerificationContext validateIntegrity(Insertable<TbBookData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('author')) {
      context.handle(_authorMeta,
          author.isAcceptableOrUnknown(data['author']!, _authorMeta));
    } else if (isInserting) {
      context.missing(_authorMeta);
    }
    if (data.containsKey('genre')) {
      context.handle(
          _genreMeta, genre.isAcceptableOrUnknown(data['genre']!, _genreMeta));
    } else if (isInserting) {
      context.missing(_genreMeta);
    }
    if (data.containsKey('year')) {
      context.handle(
          _yearMeta, year.isAcceptableOrUnknown(data['year']!, _yearMeta));
    } else if (isInserting) {
      context.missing(_yearMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TbBookData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TbBookData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      author: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}author'])!,
      genre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}genre'])!,
      year: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}year'])!,
    );
  }

  @override
  $TbBookTable createAlias(String alias) {
    return $TbBookTable(attachedDatabase, alias);
  }
}

class TbBookData extends DataClass implements Insertable<TbBookData> {
  final int id;
  final String title;
  final String author;
  final String genre;
  final String year;
  const TbBookData(
      {required this.id,
      required this.title,
      required this.author,
      required this.genre,
      required this.year});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['author'] = Variable<String>(author);
    map['genre'] = Variable<String>(genre);
    map['year'] = Variable<String>(year);
    return map;
  }

  TbBookCompanion toCompanion(bool nullToAbsent) {
    return TbBookCompanion(
      id: Value(id),
      title: Value(title),
      author: Value(author),
      genre: Value(genre),
      year: Value(year),
    );
  }

  factory TbBookData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TbBookData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      author: serializer.fromJson<String>(json['author']),
      genre: serializer.fromJson<String>(json['genre']),
      year: serializer.fromJson<String>(json['year']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'author': serializer.toJson<String>(author),
      'genre': serializer.toJson<String>(genre),
      'year': serializer.toJson<String>(year),
    };
  }

  TbBookData copyWith(
          {int? id,
          String? title,
          String? author,
          String? genre,
          String? year}) =>
      TbBookData(
        id: id ?? this.id,
        title: title ?? this.title,
        author: author ?? this.author,
        genre: genre ?? this.genre,
        year: year ?? this.year,
      );
  @override
  String toString() {
    return (StringBuffer('TbBookData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('genre: $genre, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, author, genre, year);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TbBookData &&
          other.id == this.id &&
          other.title == this.title &&
          other.author == this.author &&
          other.genre == this.genre &&
          other.year == this.year);
}

class TbBookCompanion extends UpdateCompanion<TbBookData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> author;
  final Value<String> genre;
  final Value<String> year;
  const TbBookCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.author = const Value.absent(),
    this.genre = const Value.absent(),
    this.year = const Value.absent(),
  });
  TbBookCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String author,
    required String genre,
    required String year,
  })  : title = Value(title),
        author = Value(author),
        genre = Value(genre),
        year = Value(year);
  static Insertable<TbBookData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? author,
    Expression<String>? genre,
    Expression<String>? year,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (genre != null) 'genre': genre,
      if (year != null) 'year': year,
    });
  }

  TbBookCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? author,
      Value<String>? genre,
      Value<String>? year}) {
    return TbBookCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      genre: genre ?? this.genre,
      year: year ?? this.year,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (author.present) {
      map['author'] = Variable<String>(author.value);
    }
    if (genre.present) {
      map['genre'] = Variable<String>(genre.value);
    }
    if (year.present) {
      map['year'] = Variable<String>(year.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TbBookCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('author: $author, ')
          ..write('genre: $genre, ')
          ..write('year: $year')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(e);
  late final $TbBookTable tbBook = $TbBookTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tbBook];
}
