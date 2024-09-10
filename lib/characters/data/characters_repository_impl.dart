import 'package:graphql/client.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/character_dto.dart';

final class CharactersRepositoryImpl implements CharactersRepository {
  final _charactersService = CharactersGqlService();

  @override
  Future<GetCharactersResult> getCharacters() async {
    try {
      final characters = await _charactersService.getCharacters();
      return GetCharactersSuccess(characters.map((e) => e.toDomain()).toList());
    } catch (e) {
      return GetCharactersFailure(e.toString());
    }
  }
}

final class CharactersGqlService {
  final _client = GraphQLClient(
    link: HttpLink(
      'https://rickandmortyapi.com/graphql',
    ),
    cache: GraphQLCache(),
  );

  Future<List<CharacterDto>> getCharacters() async {
    const query = r'''
      query {
	      characters(page: 1) {
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
    ));

    if (result.hasException) {
      throw result.exception!;
    }

    final List json = result.data?['characters']['results'] ?? [];

    return json.map((e) => CharacterDto.fromMap(e)).toList();
  }
}
