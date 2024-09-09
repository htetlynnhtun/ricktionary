class CharacterModel {
  final String name;
  final String image;
  final String species;
  final String status;

  CharacterModel({
    required this.name,
    required this.image,
    required this.species,
    required this.status,
  });

  static List<CharacterModel> get dummyData => [
    CharacterModel(
      name: "Rick Sanchez",
      image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Morty Smith",
      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Summer Smith",
      image: "https://rickandmortyapi.com/api/character/avatar/3.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Beth Smith",
      image: "https://rickandmortyapi.com/api/character/avatar/4.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Jerry Smith",
      image: "https://rickandmortyapi.com/api/character/avatar/5.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Abadango Cluster Princess",
      image: "https://rickandmortyapi.com/api/character/avatar/6.jpeg",
      species: "Alien",
      status: "Alive",
    ),
    CharacterModel(
      name: "Aqua Morty",
      image: "https://rickandmortyapi.com/api/character/avatar/7.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Arturo",
      image: "https://rickandmortyapi.com/api/character/avatar/8.jpeg",
      species: "Human",
      status: "Dead",
    ),
    CharacterModel(
      name: "Birdperson",
      image: "https://rickandmortyapi.com/api/character/avatar/9.jpeg",
      species: "Alien",
      status: "Alive",
    ),
    CharacterModel(
      name: "Blips and Chitz",
      image: "https://rickandmortyapi.com/api/character/avatar/10.jpeg",
      species: "Alien",
      status: "Unknown",
    ),
    CharacterModel(
      name: "Butler",
      image: "https://rickandmortyapi.com/api/character/avatar/12.jpeg",
      species: "Human",
      status: "Dead",
    ),
    CharacterModel(
      name: "C-137",
      image: "https://rickandmortyapi.com/api/character/avatar/13.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Captain Planet",
      image: "https://rickandmortyapi.com/api/character/avatar/14.jpeg",
      species: "Human",
      status: "Unknown",
    ),
    CharacterModel(
      name: "Evil Morty",
      image: "https://rickandmortyapi.com/api/character/avatar/15.jpeg",
      species: "Human",
      status: "Alive",
    ),
    CharacterModel(
      name: "Gazorpazorpfield",
      image: "https://rickandmortyapi.com/api/character/avatar/16.jpeg",
      species: "Alien",
      status: "Unknown",
    ),
    CharacterModel(
      name: "Krombopulos Michael",
      image: "https://rickandmortyapi.com/api/character/avatar/17.jpeg",
      species: "Alien",
      status: "Dead",
    ),
    CharacterModel(
      name: "Mr. Poopybutthole",
      image: "https://rickandmortyapi.com/api/character/avatar/18.jpeg",
      species: "Alien",
      status: "Alive",
    ),
    CharacterModel(
      name: "Principal Vagina",
      image: "https://rickandmortyapi.com/api/character/avatar/19.jpeg",
      species: "Human",
      status: "Unknown",
    ),
    CharacterModel(
      name: "Rick Sanchez Clone",
      image: "https://rickandmortyapi.com/api/character/avatar/20.jpeg",
      species: "Human",
      status: "Dead",
    ),
  ];
}
