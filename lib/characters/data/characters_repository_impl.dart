import 'package:graphql/client.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/character_dto.dart';
import 'package:ricktionary/characters/data/characters_cache.dart';
import 'package:ricktionary/characters/data/characters_gql_service.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final CharactersGqlService charactersService;
  final CharactersCache charactersCache;

  CharactersRepositoryImpl({
    required this.charactersService,
    required this.charactersCache,
  });

  @override
  Future<GetCharactersResult> getCharacters(int page) async {
    try {
      final characterDtos = await charactersService.getCharacters(page);
      await charactersCache.refresh(page, characterDtos);
      final characters = [for (final dto in characterDtos) dto.toDomain()];
      return GetCharactersSuccess(characters);
    } on OperationException {
      final cachedCharacters = await charactersCache.retrieve(page);
      return GetCharactersSuccess(
        cachedCharacters.map((dto) => dto.toDomain()).toList(),
      );
    } catch (e) {
      return GetCharactersFailure(e.toString());
    }
  }
}
