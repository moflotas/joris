import 'package:flutter/material.dart';
import 'package:joris/shared_widgets/joke_card.dart';
import 'package:get/get.dart';

class JokesBigScreen extends StatelessWidget {
  const JokesBigScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Concrete joke"),
        backgroundColor: Get.theme.backgroundColor,
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: getLargeCard(
        Get.arguments[0],
        false,
      ),
    );
  }
}
