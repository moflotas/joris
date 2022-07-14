// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chuck_norris_joke.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChuckNorrisJoke _$ChuckNorrisJokeFromJson(Map<String, dynamic> json) =>
    ChuckNorrisJoke(
      id: json['id'] as String,
      categories: json['categories'] as List<dynamic>,
      url: json['url'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$ChuckNorrisJokeToJson(ChuckNorrisJoke instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'value': instance.value,
      'categories': instance.categories,
    };
