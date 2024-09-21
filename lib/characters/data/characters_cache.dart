import 'package:path/path.dart';
import 'package:ricktionary/characters/data/character_dto.dart';
import 'package:ricktionary/characters/data/const_values.dart';
import 'package:sqflite/sqflite.dart';

class CharactersCache {
  late final Database database;

  Future<void> init() async {
    final path = join(
      await getDatabasesPath(),
      'ricktionary.db',
    );
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, __) {
        db.execute('''
          CREATE TABLE $charactersTable(
            id INTEGER PRIMARY KEY,
            name TEXT,
            status TEXT,
            species TEXT,
            image TEXT
          )
        ''');
      },
    );
  }

  Future<List<CharacterDto>> retrieve(int page) async {
    final characterMaps = await database.query(
      charactersTable,
      limit: charactersPerPage,
      offset: (page - 1) * charactersPerPage,
    );
    return characterMaps.map(CharacterDto.fromMap).toList();
  }

  Future<void> refresh(int page, List<CharacterDto> characters) async {
    await _delete(page);
    _insert(characters);
  }

  Future<void> _insert(List<CharacterDto> characters) async {
    final batch = database.batch();
    for (final dto in characters) {
      batch.insert(
        charactersTable,
        dto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<void> _delete(int page) async {
    final offset = (page - 1) * charactersPerPage;
    final batch = database.batch();
    batch.delete(
      charactersTable,
      where:
          'id IN (SELECT id FROM $charactersTable LIMIT $charactersPerPage OFFSET ?)',
      whereArgs: [offset],
    );
    await batch.commit(noResult: true);
  }
}
