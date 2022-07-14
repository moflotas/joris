import 'dart:math';

import 'package:flutter/material.dart';
import 'package:joris/controllers/firebase_controller.dart';
import 'package:joris/models/chuck_norris_joke.dart';

String spoilerJoke(String text) {
  String res = '${text.substring(0, min(50, text.length))}...';
  return res;
}

Widget getModelCardWidget(ChuckNorrisJoke model,
    {bool removable = false, FirebaseController? controller}) {
  return Card(
    margin: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            child: const Icon(
              Icons.tag_faces_rounded,
              color: Color.fromRGBO(44, 83, 72, 1),
              size: 36,
            ),
          ),
          Flexible(
            flex: 3,
            fit: FlexFit.tight,
            child: Text(
              spoilerJoke(model.value),
              style: const TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
