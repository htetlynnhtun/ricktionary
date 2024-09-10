import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ricktionary/characters/character_model.dart';

class CharacterItemView extends StatelessWidget {
  const CharacterItemView({
    super.key,
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: ColoredBox(
        color: Theme.of(context).colorScheme.surfaceContainer,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: character.image,
              fit: BoxFit.contain,
              width: 150,
              height: 150,
            ),
            Expanded(
              child: SizedBox(
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        character.name,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Row(
                        spacing: 4,
                        children: [
                          ClipOval(
                            child: ColoredBox(
                              color: character.statusColor,
                              child: const SizedBox.square(dimension: 12),
                            ),
                          ),
                          Text('${character.status} - ${character.species}'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on CharacterModel {
  Color get statusColor {
    switch (status) {
      case 'Alive':
        return Colors.green;
      case 'Dead':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }
}
