import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Janken'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Hand? myHand;
  Hand? computerHand;
  Result? result;

  void chooseComputerText() {
    final random = Random();
    final randomNumber = random.nextInt(3);
    final hand = Hand.values[randomNumber];
    setState(() {
      computerHand = hand;
    });
    decideResult();
  }

  void decideResult() {
    if (myHand == null || computerHand == null) {
      return;
    }
    final Result result;
    if (myHand == computerHand) {
      result = Result.win;
    } else {
      result = Result.lose;
    }
    setState(() {
      this.result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '相手️',
              style: TextStyle(fontSize: 30),
            ),
            if (computerHand != null) // computerHandがnullでない場合のみ画像を表示
              Image.asset(
                'assets/${computerHand!.imageName}.jpeg', // computerHandに応じた画像を選択
                width: 150, // 画像のサイズを指定
                height: 150,
              )
            else
              Text(
                '?',
                style: TextStyle(fontSize: 150),
              ),
            // ここまで変更
            SizedBox(
              height: 50,
            ),
            Text(
              result?.text ?? '?',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              myHand?.emoji ?? '?',
              style: TextStyle(fontSize: 150),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.up;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👆',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.down;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👇',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.right;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👉',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myHand = Hand.left;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '👈',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}

enum Hand {
  up,
  down,
  left,
  right;

  // 画像ファイル名を返すプロパティ
  String get imageName {
    switch (this) {
      case Hand.up:
        return 'up';
      case Hand.down:
        return 'down';
      case Hand.left:
        return 'left';
      case Hand.right:
        return 'right';
    }
  }

  // 絵文字を返すプロパティ
  String get emoji {
    switch (this) {
      case Hand.up:
        return '👆';
      case Hand.down:
        return '👇';
      case Hand.left:
        return '👈';
      case Hand.right:
        return '👉';
    }
  }
}

enum Result {
  win,
  lose;

  String get text {
    switch (this) {
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
    }
  }
}
