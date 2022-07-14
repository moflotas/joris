import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:joris/models/chuck_norris_joke.dart';

class FirebaseController extends GetxController {
  final jokesDB = FirebaseFirestore.instance;

  Future<ChuckNorrisJoke?> get(String id) async {
    try {
      var snapshot = await jokesDB.collection("favourite_jokes").doc(id).get();
      if (snapshot.data() == null) return null;
      return ChuckNorrisJoke.fromJson(snapshot.data()!);
    } catch (e) {
      Get.snackbar("Error", e.toString());
      return null;
    }
  }

  void addOrUpdate(ChuckNorrisJoke joke) async {
    try {
      await jokesDB.collection("favourite_jokes").doc(joke.id).set(joke.toJson());
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> list() {
    return jokesDB.collection("favourite_jokes").snapshots();
  }

  // Remove route by it's ID
  void removeJoke(String routeId) async {
    try {
      await jokesDB.collection("favourite_jokes").doc(routeId).delete();
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
