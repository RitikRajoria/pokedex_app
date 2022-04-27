import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/pokemon_bloc.dart';
import 'package:pokedex/bloc/pokemon_state.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'bloc/nav_cubit.dart';

class PokedexView extends StatelessWidget {
  const PokedexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokedex'),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is PokemonLoadInProgress) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is PokemonPageLoadSuccess) {
          return GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
            itemCount: state.pokemonListings.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  BlocProvider.of<NavCubit>(context)
                      .showPokemonDetails(state.pokemonListings[index].id);
                },
                child: Card(
                  child: GridTile(
                    child: Column(
                      children: [
                        // CachedNetworkImage(
                        //   imageUrl: "${state.pokemonListings[index].imageUrl}",
                        //   placeholder: (context, url) =>
                        //       CircularProgressIndicator(),
                        //   errorWidget: (context, url, error) =>
                        //       Icon(Icons.error),
                        // ),
                        Image.network(state.pokemonListings[index].imageUrl),
                        Text(state.pokemonListings[index].name),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is PokemonPageLoadFailed) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          return Container(
            child: Text("asdasd"),
          );
        }
      }),
    );
  }
}
