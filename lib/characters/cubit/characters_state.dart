part of 'characters_cubit.dart';

@immutable
sealed class CharactersState {}

final class CharactersInitial extends CharactersState {}

final class CharactersLoading extends CharactersState {}

final class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded({required this.characters});
}

final class CharactersFailure extends CharactersState {
  final String message;

  CharactersFailure(this.message);
}
