import 'package:ricktionary/characters/characters.dart';

abstract class CharactersRepository {
  Future<GetCharactersResult> getCharacters(int page);
}

sealed class GetCharactersResult {}

final class GetCharactersSuccess extends GetCharactersResult {
  final List<Character> characters;

  GetCharactersSuccess(this.characters);
}

final class GetCharactersFailure extends GetCharactersResult {
  final String message;

  GetCharactersFailure(this.message);
}
