import 'package:graphql/client.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/character_dto.dart';
import 'package:ricktionary/characters/data/characters_cache.dart';
import 'package:ricktionary/characters/data/characters_gql_service.dart';
import 'package:ricktionary/core/core.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersGqlService charactersService;
  final CharactersCache charactersCache;

  CharactersRepositoryImpl({
    required this.charactersService,
    required this.charactersCache,
  });

  @override
  Future<GetCharactersResult> getCharacters() async {
    try {
      final paginatedCharacters = await _retrieveCharacters();
      return GetCharactersSuccess(paginatedCharacters);
    } catch (e) {
      return GetCharactersFailure(e.toString());
    }
  }

  Future<Paginated<Character>> _retrieveCharacters({int page = 1}) async {
    try {
      var characters = await charactersService.getCharacters(page);
      if (page > 1) {
        final cachedCharacters = await charactersCache.retrieve();
        characters = [...cachedCharacters, ...characters];
      }
      final paginated = Paginated(
        [for (final dto in characters) dto.toDomain()],
        characters.isEmpty ? null : () => _retrieveCharacters(page: page + 1),
      );
      await charactersCache.upsert(characters);
      return paginated;
    } on OperationException catch (_) {
      final cachedCharacters = await charactersCache.retrieve();
      return Paginated(
        [for (final dto in cachedCharacters) dto.toDomain()],
        null,
      );
    }
  }
}
