import 'package:json_annotation/json_annotation.dart';

part 'pokemon_model.g.dart';

/// Pour générer le code
/// flutter pub run build_runner watch --delete-conflicting-outputs
@JsonSerializable()
class PokemonResponse {
  @JsonKey(name: 'height')
  final int height;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'cries')
  final PokemonCries cries;

  PokemonResponse(this.height, this.name, this.cries);

  factory PokemonResponse.fromJson(Map<String, dynamic> json) =>
      _$PokemonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonResponseToJson(this);

  @override
  String toString() {
    return 'PokemonResponse{height: $height, name: $name, cries: $cries}';
  }
}

/// Sous-objet du JSON = nouvelle classe
@JsonSerializable()
class PokemonCries {
  @JsonKey(name: 'latest')
  final String latest;
  @JsonKey(name: 'legacy')
  final String legacy;

  PokemonCries(this.latest, this.legacy);

  factory PokemonCries.fromJson(Map<String, dynamic> json) =>
      _$PokemonCriesFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonCriesToJson(this);

  @override
  String toString() {
    return 'PokemonCries{latest: $latest, legacy: $legacy}';
  }
}
