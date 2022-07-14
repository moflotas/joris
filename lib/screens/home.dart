import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:joris/controllers/firebase_controller.dart';
import 'package:joris/controllers/jokes_controller.dart';
import 'package:get/get.dart';
import 'package:joris/models/chuck_norris_joke.dart';
import 'package:joris/routes.dart';
import 'package:joris/shared_widgets/joke_card.dart';
import 'package:joris/shared_widgets/small_joke_card.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final JokesController jokesController = Get.put(JokesController());
  final FirebaseController firebaseController = Get.put(FirebaseController());

  final _selectedIndex = 1.obs;
  final PageController controller = PageController(initialPage: 1);

  void _onScreenChanged(int index) {
    _selectedIndex(index);
  }

  void _onItemTapped(int index) {
    _onScreenChanged(index);
    controller.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Joris"),
        backgroundColor: Get.theme.backgroundColor,
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_emoticon),
              label: 'Browse',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined),
              label: 'Favourites',
            ),
          ],
          currentIndex: _selectedIndex.value,
          selectedItemColor: Get.theme.backgroundColor,
          onTap: _onItemTapped,
        ),
      ),
      body: PageView(
        controller: controller,
        onPageChanged: _onScreenChanged,
        children: <Widget>[
          Center(
            child: TextButton(
              onPressed: () => throw Exception("Some random exception"),
              style: TextButton.styleFrom(
                primary: Colors.white,
                backgroundColor: Get.theme.backgroundColor,
                onSurface: Colors.grey,
              ),
              child: const Text("Crashlytics test"),
            ),
          ),
          SafeArea(
            child: Center(
              child: Obx(() => jokesController.jokeIsLoading.value
                  ? const CircularProgressIndicator()
                  : getLargeCard(jokesController.currentJoke.value, true)),
            ),
          ),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: firebaseController.list(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot<Map<String, dynamic>> doc =
                        snapshot.data!.docs[index];
                    return GestureDetector(
                      onTap: () => Get.toNamed(
                        Routes.cardBigPage,
                        arguments: [
                          ChuckNorrisJoke.fromJson(
                            doc.data()!,
                          ),
                        ],
                      ),
                      child: getModelCardWidget(
                        ChuckNorrisJoke.fromJson(
                          doc.data()!,
                        ),
                      ),
                    );
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
