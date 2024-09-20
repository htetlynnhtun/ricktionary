import 'package:graphql/client.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/character_dto.dart';
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

final class CharactersGqlService {
  final _client = GraphQLClient(
    link: HttpLink(
      'https://rickandmortyapi.com/graphql',
    ),
    cache: GraphQLCache(),
  );

  Future<List<CharacterDto>> getCharacters(int page) async {
    const query = r'''
      query($page: Int) {
	      characters(page: $page) {
          results {
            id
            name
            status
            species
            image
          }
        }
      }	
    ''';
    final result = await _client.query(QueryOptions(
      document: gql(query),
      variables: {'page': page},
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final List json = result.data?['characters']['results'] ?? [];

    return json.map((e) => CharacterDto.fromMap(e)).toList();
  }
}

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
