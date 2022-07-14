import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:joris/models/chuck_norris_joke.dart';

class JokesController extends GetxController {
  var dio = Dio();
  var jokeIsLoading = false.obs;
  var currentJoke = Rxn<ChuckNorrisJoke>();

  void updateJoke() async {
    jokeIsLoading(true);
    try {
      var response = await dio.get("https://api.chucknorris.io/jokes/random/");
      var joke = ChuckNorrisJoke.fromJson(response.data);
      currentJoke(joke);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      jokeIsLoading(false);
    }
  }

  // Future<List<ChuckNorrisJoke>?> textJokeSearch(String? searchText) async {
  //   try {
  //     var response = await Dio().get("https://api.chucknorris.io/jokes/search?query=$searchText");
  //     var jsonResponse = json.decode(response.data!);
  //     return null;
  //   } catch (e) {
  //     return null;
  //   }
  // }
}

