import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/app_navigator.dart';
import 'package:pokedex/bloc/nav_cubit.dart';
import 'package:pokedex/bloc/pokemon_event.dart';
import 'package:pokedex/pokedex_view.dart';

import 'bloc/pokemon_bloc.dart';
import 'bloc/pokemon_details_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final pokemondetailscubit = PokemonDetailsCubit();

    return MaterialApp(
      title: 'Pokedex App',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
              .copyWith(secondary: Colors.redAccent)),
      home: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => PokemonBloc()..add(PokemonPageRequest(page: 0)),
        ),
        BlocProvider(
          create: (context) =>
              NavCubit(pokemonDetailsCubit: pokemondetailscubit),
        ),
        BlocProvider(
          create: (context) => pokemondetailscubit,
        ),
      ], child: AppNavigator()),
    );
  }
}
