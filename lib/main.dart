import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';

void main() {
  runApp(const MyApp());
}


class Content {
  final String? text;
  final Color? color;

  Content({this.text, this.color});
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Swipe Cards Demo',
      home: MyHomePage(title: 'Swipe Cards Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class ChuckNorrisJoke extends SwipeItem {
  static final List<Color> _colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.grey,
    Colors.purple,
    Colors.pink
  ];

  static var totalInstances = 0;

  ChuckNorrisJoke()
      : super(
          content: Content(
              text: "Тут должна была быть случайная шутка про Чака Норриса, но async передает привет $totalInstances раз(а)",
              color: _colors[totalInstances++ % _colors.length]),
          likeAction: () {
            // decision = Decision.like;
            // print("like");
          },
          nopeAction: () {
            // decision = Decision.nope;
            // print("dislike");
          },
        );
}

class MyHomePageState extends State<MyHomePage> {
  final List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  int totalItems = 2;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    _swipeItems.add(ChuckNorrisJoke());
    _swipeItems.add(ChuckNorrisJoke());

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              title: Text(widget.title!),
            ),
            body: Stack(children: [
              SizedBox(
                child: SwipeCards(
                  matchEngine: _matchEngine!,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        alignment: Alignment.center,
                        color: _swipeItems[index].content.color,
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            _swipeItems[index].content.text,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 25),
                          ),
                        ));
                  },
                  onStackFinished: () {},
                  itemChanged: (SwipeItem item, int index) {
                    _swipeItems.add(ChuckNorrisJoke());
                  },
                  fillSpace: true,
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _matchEngine!.currentItem?.nope();
                        },
                        child: const Text("Nope"),
                      ),
                      ElevatedButton(
                          onPressed: () {
                            _matchEngine!.currentItem?.like();
                          },
                          child: const Text("Like"))
                    ],
                  ))
            ])));
  }
}
