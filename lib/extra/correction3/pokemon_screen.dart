import 'package:flutter/material.dart';
import 'package:untitled1/extra/correction3/pokemon_api.dart';
import 'package:untitled1/extra/correction3/pokemon_model.dart';

class PokemonScreen extends StatelessWidget {
  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: PokemonAPIManager().loadPokemon(),
        builder:
            (BuildContext context, AsyncSnapshot<PokemonResponse> response) {
          if (response.hasError) {
            return const Text('Erreur !');
          } else if (response.hasData) {
            return Text('Requête OK : ${response.data.toString()}');
          } else {
            return const CircularProgressIndicator.adaptive();
          }
        },
      ),
    );
  }
}
