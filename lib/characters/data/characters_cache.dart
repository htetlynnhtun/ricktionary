import 'package:ricktionary/characters/characters.dart';

class CharactersCache {
  final _cache = <Character>[];

  Future<List<Character>> retrieve() async {
    return _cache;
  }

  Future<void> upsert(List<Character> characters) async {
    _cache.clear();
    _cache.addAll(characters);
  }
}
