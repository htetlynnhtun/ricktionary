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
    emit(CharactersLoading());

    final result = await charactersRepository.getCharacters();

    emit(switch (result) {
      GetCharactersSuccess(:final characters) => CharactersLoaded(
          characters: characters,
        ),
      GetCharactersFailure() => CharactersFailure(
          'Failed to load characters',
        ),
    });
  }
}
