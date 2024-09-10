import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ricktionary/characters/character_model.dart';
import 'package:ricktionary/characters/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());

  Future<void> loadCharacters() async {
    emit(CharactersLoading());
    await Future.delayed(const Duration(seconds: 2));
    List<Character> characters = [];
    for (final (i, e) in CharacterModel.dummyData.indexed) {
      characters.add(Character(
        id: i,
        name: e.name,
        status: e.status,
        species: e.species,
        imageUrl: e.image,
      ));
    }
    emit(CharactersLoaded(characters: characters));
  }
}
