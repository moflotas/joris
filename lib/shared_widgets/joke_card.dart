import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joris/controllers/firebase_controller.dart';
import 'package:joris/controllers/jokes_controller.dart';
import 'package:joris/models/chuck_norris_joke.dart';

Widget getLargeCard(ChuckNorrisJoke? joke, bool showButtons) {
  return joke != null
      ? JokeWidget(
          joke.value,
          showButtons: showButtons,
        )
      : JokeWidget(
          "Loading error",
          isNull: true,
          showButtons: showButtons,
        );
}

class JokeWidget extends StatelessWidget {
  final String text;
  final bool showButtons;
  final bool isNull;
  final jokesController = Get.put(JokesController());
  final firebaseController = Get.put(FirebaseController());

  JokeWidget(this.text,
      {this.showButtons = true, this.isNull = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Get.theme.backgroundColor,
          ),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
        child: SizedBox(
          width: Get.width * 0.7,
          height: Get.height * 0.5,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: isNull
                    ? [
                        const Image(
                          image:
                              AssetImage('lib/assets/chucknorris_loading.gif'),
                        ),
                        TextButton(
                          onPressed: () {
                            jokesController.updateJoke();
                          },
                          style: TextButton.styleFrom(
                            primary: Get.theme.primaryColor,
                            backgroundColor: Get.theme.backgroundColor,
                            onSurface: Colors.grey,
                          ),
                          child: const Text("Ready to see some jokes?"),
                        ),
                      ]
                    : [
                        Text(
                          text,
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Visibility(
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          visible: showButtons,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TextButton(
                                onPressed: () {
                                  jokesController.updateJoke();
                                },
                                style: TextButton.styleFrom(
                                  primary: Get.theme.primaryColor,
                                  backgroundColor: Get.theme.backgroundColor,
                                  onSurface: Colors.grey,
                                ),
                                child: const Text("Hate"),
                              ),
                              TextButton(
                                onPressed: () {
                                  firebaseController.addOrUpdate(
                                      jokesController.currentJoke.value!);
                                  jokesController.updateJoke();
                                },
                                style: TextButton.styleFrom(
                                  primary: Colors.white,
                                  backgroundColor: Get.theme.backgroundColor,
                                  onSurface: Colors.grey,
                                ),
                                child: const Text("Like"),
                              ),
                            ],
                          ),
                        ),
                      ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
