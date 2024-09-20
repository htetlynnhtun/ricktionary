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

  Future<List<CharacterDto>> retrieve() async {
    final characterMaps = await database.query(charactersTable);
    return [
      for (final map in characterMaps) CharacterDto.fromMap(map),
    ];
  }

  Future<void> upsert(List<CharacterDto> characters) async {
    final batch = database.batch();
    batch.delete(charactersTable);
    for (final dto in characters) {
      batch.insert(
        charactersTable,
        dto.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await batch.commit(noResult: true);
  }
}
