// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokemon_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokemonResponse _$PokemonResponseFromJson(Map<String, dynamic> json) =>
    PokemonResponse(
      (json['height'] as num).toInt(),
      json['name'] as String,
      PokemonCries.fromJson(json['cries'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PokemonResponseToJson(PokemonResponse instance) =>
    <String, dynamic>{
      'height': instance.height,
      'name': instance.name,
      'cries': instance.cries,
    };

PokemonCries _$PokemonCriesFromJson(Map<String, dynamic> json) => PokemonCries(
      json['latest'] as String,
      json['legacy'] as String,
    );

Map<String, dynamic> _$PokemonCriesToJson(PokemonCries instance) =>
    <String, dynamic>{
      'latest': instance.latest,
      'legacy': instance.legacy,
    };
