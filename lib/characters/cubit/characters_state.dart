part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {
  const CharactersState({
    this.characters = const [],
    this.page = 0,
    this.isLastPage = false,
  });
  final List<Character> characters;
  final int page;
  final bool isLastPage;
}

final class CharactersInitial extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  const CharactersLoaded({
    required super.characters,
    required super.page,
    required super.isLastPage,
  });
}

final class CharactersFailure extends CharactersState {
  final String message;
  const CharactersFailure(this.message);
}
