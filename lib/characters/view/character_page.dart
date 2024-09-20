import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/view/character_item_view.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersCubit(
        context.read(),
      )..loadCharacters(),
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
            CharactersLoaded(:final characters) => CharactersLoadedView(
                characters: characters,
                loadMore: context.read<CharactersCubit>().loadMoreCharacters,
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

class CharactersLoadedView extends StatelessWidget {
  const CharactersLoadedView({
    super.key,
    required this.characters,
    this.loadMore,
  });

  final List<Character> characters;
  final VoidCallback? loadMore;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollEndNotification &&
            notification.metrics.extentAfter == 0) {
          loadMore?.call();
        }
        return false;
      },
      child: Scrollbar(
        child: RefreshIndicator(
          onRefresh: context.read<CharactersCubit>().loadCharacters,
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: characters.length + (loadMore == null ? 0 : 1),
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              if (index >= characters.length) {
                return const LoadMoreIndicator();
              }
              return CharacterItemView(
                character: characters[index],
              );
            },
          ),
        ),
      ),
    );
  }
}

class LoadMoreIndicator extends StatelessWidget {
  const LoadMoreIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 32,
        width: 32,
        child: CircularProgressIndicator(strokeWidth: 1.5),
      ),
    );
  }
}
