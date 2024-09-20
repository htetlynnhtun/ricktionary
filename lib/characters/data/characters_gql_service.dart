import 'package:graphql/client.dart';
import 'package:ricktionary/characters/data/character_dto.dart';

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
