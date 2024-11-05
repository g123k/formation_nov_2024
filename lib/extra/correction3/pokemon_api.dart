import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:untitled1/extra/correction3/pokemon_model.dart';

part 'pokemon_api.g.dart';

@RestApi()
abstract class PokemonAPI {
  factory PokemonAPI(Dio dio, {required String baseUrl}) = _PokemonAPI;

  // https://pokeapi.co/api/v2/pokemon/ditto
  @GET('/pokemon/ditto')
  Future<PokemonResponse> loadPokemon();
}

class PokemonAPIManager {
  factory PokemonAPIManager() {
    _instance ??= PokemonAPIManager._();
    return _instance!;
  }

  static PokemonAPIManager? _instance;

  final PokemonAPI _api;

  PokemonAPIManager._()
      : _api = PokemonAPI(Dio(), baseUrl: 'https://pokeapi.co/api/v2/');

  Future<PokemonResponse> loadPokemon() => _api.loadPokemon();
}
