import 'dart:convert';

import 'package:ricktionary/characters/characters.dart';

class CharacterDto {
  final int id;
  final String name;
  final String status;
  final String species;
  final String image;

  CharacterDto({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'image': image,
    };
  }

  factory CharacterDto.fromMap(Map<String, dynamic> map) {
    return CharacterDto(
      id: switch (map['id']) {
        int() => map['id'],
        _ => int.parse(map['id'])
      },
      name: map['name'] as String,
      status: map['status'] as String,
      species: map['species'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CharacterDto.fromJson(String source) => CharacterDto.fromMap(json.decode(source) as Map<String, dynamic>);
}

extension CharacterDtoMapper on CharacterDto {
  Character toDomain() {
    return Character(
      id: id,
      name: name,
      status: status,
      species: species,
      imageUrl: image,
    );
  }
}
