import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricktionary/characters/characters.dart';
import 'package:ricktionary/characters/data/characters_cache.dart';
import 'package:ricktionary/characters/data/characters_gql_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final charactersService = CharactersGqlService();
  final charactersCache = CharactersCache();
  await charactersCache.init();

  runApp(
    RepositoryProvider<CharactersRepository>(
      create: (context) => CharactersRepositoryImpl(
        charactersService: charactersService,
        charactersCache: charactersCache,
      ),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CharacterPage(),
    );
  }
}
