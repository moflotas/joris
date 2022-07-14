import 'package:json_annotation/json_annotation.dart';

part 'chuck_norris_joke.g.dart';


@JsonSerializable()
class ChuckNorrisJoke {
  final String id;
  final String url;
  final String value;
  final List<dynamic> categories;

  ChuckNorrisJoke({required this.id, required this.categories, required this.url, required this.value});

  factory ChuckNorrisJoke.fromJson(Map<String, dynamic> json) => _$ChuckNorrisJokeFromJson(json);
  Map<String, dynamic> toJson() => _$ChuckNorrisJokeToJson(this);
}