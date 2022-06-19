import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:joris/utils/jokes_getter.dart';
import 'package:firebase_database/firebase_database.dart';

DatabaseReference ref = FirebaseDatabase.instance.ref();

class Joke extends StatefulWidget {
  const Joke({Key? key}) : super(key: key);

  @override
  JokeState createState() => JokeState();
}

class JokeState extends State<Joke> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder(
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${snapshot.error} occurred',
                  style: const TextStyle(fontSize: 18),
                ),
              );
            } else if (snapshot.hasData) {
              final data = snapshot.data;
              return Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(20, 100, 20, 120),
                child: Card(
                  color: Colors.amber,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              jsonDecode(data.toString())['value'],
                              style: const TextStyle(fontSize: 18)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  DatabaseReference ref =
                                      FirebaseDatabase.instance.ref().child('/jokes');
                                  var jsonJoke = jsonDecode(data.toString());
                                  await ref.set(jsonJoke);
                                  setState(() {
                                    //TODO: add firebase like
                                  });
                                },
                                child: const Text("Like"),
                              ),
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {});
                                },
                                child: const Text("Next"),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }

          // Displaying LoadingSpinner to indicate waiting state
          return const Center(
            child: CircularProgressIndicator(),
          );
        },

        // Future that needs to be resolved
        // inorder to display something on the Canvas
        future: JokesGetter.getJoke(),
      ),
    );
  }
}

class JokesScreen extends StatelessWidget {
  const JokesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Joris - jokes revolution"),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.favorite),
              tooltip: 'Go to the next page',
              onPressed: () {
                Navigator.pushNamed(context, "/favourites");
              },
            ),
          ],
        ),
        body: const Center(
          child: Joke(),
        ),
      ),
    );
  }
}
