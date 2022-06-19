import 'package:dio/dio.dart';

class JokesGetter {
  static Future<String?> getJoke() async {
    try {
      Response<String> response = await Dio().get("https://api.chucknorris.io/jokes/random/");
      String body = response.data.toString();
      // var jsonJoke = jsonDecode(body);
      // ChuckNorrisJoke(jsonJoke['categories'], jsonJoke['url'], jsonJoke['value'])
      return body;
    } catch (e) {
      return null;
    }
  }
}