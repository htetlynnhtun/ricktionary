import 'package:flutter/material.dart';
import 'package:ricktionary/characters/character_model.dart';
import 'package:ricktionary/characters/view/character_item_view.dart';

class CharacterPage extends StatelessWidget {
  const CharacterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CharacterView();
  }
}

class CharacterView extends StatelessWidget {
  const CharacterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: 19,
          separatorBuilder: (_, index) => const SizedBox(height: 16),
          itemBuilder: (context, index) =>
              CharacterItemView(character: CharacterModel.dummyData[index]),
        ),
      ),
    );
  }
}
