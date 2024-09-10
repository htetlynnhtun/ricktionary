import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/view/character_item_view.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersCubit()..loadCharacters(),
      child: const CharacterView(),
    );
  }
}

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<CharactersCubit, CharactersState>(
          builder: (context, state) => switch (state) {
            CharactersInitial() || CharactersLoading() => const Center(
                child: CircularProgressIndicator(),
              ),
            CharactersLoaded(:final characters) => ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: characters.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) => CharacterItemView(
                  character: characters[index],
                ),
              ),
            CharactersFailure(:final message) => Center(
                child: Text(message),
              ),
          },
        ),
      ),
    );
  }
}
