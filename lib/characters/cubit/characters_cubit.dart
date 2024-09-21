import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:ricktionary/characters/characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;

  CharactersCubit(
    this.charactersRepository,
  ) : super(CharactersInitial());

  Future<void> loadCharacters() async {
    if (state.isLastPage) return;

    final pageToLoad = state.page + 1;
    final result = await charactersRepository.getCharacters(pageToLoad);

    switch (result) {
      case GetCharactersSuccess(:final characters):
        emit(CharactersLoaded(
          characters: state.characters + characters,
          page: pageToLoad,
          isLastPage:  characters.isEmpty,
        ));
        break;
      case GetCharactersFailure():
        emit(CharactersFailure(result.message));
        break;
    }
  }

  Future<void> refreshCharacters() async {
    emit(CharactersInitial());
    await loadCharacters();
  }
}
