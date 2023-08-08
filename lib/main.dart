import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:tinderui/functions/alertFunction.dart';
import 'package:tinderui/widgets/appBar.dart';
import 'package:tinderui/widgets/bottomBar.dart';
import 'package:tinderui/utils/constants.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<SwipeItem> _swipeItems = <SwipeItem>[];
  MatchEngine? _matchEngine;
  List<String> names = [
    'Ayush Bhai',
    'Lavesh Verma',
    'TDBS',
    'Shivam Verma'
  ];

  @override
  void initState() {
    for (int i = 0; i < names.length; i++) {
      _swipeItems.add(
        SwipeItem(
          content: Content(text: names[i]),
          likeAction: () {
            actions(context, names[i], 'Liked');
          },
          nopeAction: () {
            actions(context, names[i], 'Rejected');
          },
          superlikeAction: () {
            actions(context, names[i], 'SuperLiked');
          },
        ),
      );
    }
    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(height: 70),
            TopBar(),
            Expanded(
                child: Container(
              child: SwipeCards(
                matchEngine: _matchEngine!,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          names[index],
                          style: TextStyle(
                              fontSize: 32,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(images[index]),
                            fit: BoxFit.cover),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.all(20),
                  );
                },
                onStackFinished: () {
                  return ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("The List is over")));
                },
              ),
            )),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

class Content {
  final String? text;
  Content({this.text});
}
