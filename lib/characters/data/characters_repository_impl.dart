import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/character_dto.dart';
import 'package:ricktionary/characters/data/characters_cache.dart';
import 'package:ricktionary/characters/data/characters_gql_service.dart';
import 'package:ricktionary/core/core.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final _charactersService = CharactersGqlService();
  final _charactersCache = CharactersCache();

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
    final characterDtos = await _charactersService.getCharacters(page);
    final characters = characterDtos.map((dto) => dto.toDomain()).toList();
    final cachedCharacters = await _charactersCache.retrieve();
    final paginated = Paginated(
      cachedCharacters + characters,
      characters.isEmpty ? null : () => _retrieveCharacters(page: page + 1),
    );
    await _charactersCache.upsert(paginated.items);
    return paginated;
  }
}
