import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/core/core.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(
    this.charactersRepository,
  ) : super(CharactersInitial());

  VoidCallback? loadMoreCharacters;

  Future<void> loadCharacters() async {
    emit(CharactersLoading());

    final result = await charactersRepository.getCharacters();

    switch (result) {
      case GetCharactersSuccess(:final characters):
        _handleCharactersLoaded(characters);
        break;
      case GetCharactersFailure():
        loadMoreCharacters = null;
        emit(CharactersFailure(result.message));
        break;
    }
  }

  void _handleCharactersLoaded(Paginated<Character> characters) {
    emit(CharactersLoaded(characters: characters.items));
    if (characters.next != null) {
      loadMoreCharacters = () async {
        final newCharacters = await characters.next!();
        _handleCharactersLoaded(newCharacters);
      };
    }
  }
}
