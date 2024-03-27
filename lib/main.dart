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

  void chooseComputerText(){
      final random = Random();
      final randomNumber = random.nextInt(3);
      final hand = Hand.values[randomNumber];
      setState(() {
        computerHand = hand;
      });
      decideResult();
    }
  
  void decideResult(){
    if(myHand == null || computerHand == null){
      return;
    }
    final Result result;
    if(myHand == computerHand){
      result = Result.draw;
    }else if(myHand == Hand.rock && computerHand == Hand.scissors){
      result = Result.win;
    }else if(myHand == Hand.scissors && computerHand == Hand.paper){
      result = Result.win;
    }else if(myHand == Hand.paper && computerHand == Hand.rock){
      result = Result.win;
    }else{
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
            Text('相手️',
            style: TextStyle(fontSize: 30),
            ),
            Text(
              computerHand?.text ?? '?',
              style: TextStyle(fontSize: 150),
            ),
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
              myHand?.text ?? '?',
              style: TextStyle(fontSize: 150),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FloatingActionButton(
            onPressed:(){
              setState(() {
                myHand = Hand.rock;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✊',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
            ),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                myHand = Hand.scissors;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✌️',
              style: TextStyle(fontSize: 30),
            ),
          ),
          const SizedBox(
            width: 16,
            ),
          FloatingActionButton(
            onPressed: (){
              setState(() {
                myHand = Hand.paper;
              });
              chooseComputerText();
            },
            tooltip: 'Increment',
            child: const Text(
              '✋',
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
          ),
        

    );
  }
}
enum Hand{
  rock,
  scissors,
  paper;
  String get text{
    switch(this){
      case Hand.rock:
        return '✊';
      case Hand.scissors:
        return '✌️';
      case Hand.paper:
        return '✋';
    }
  }
}
enum Result{
  win,
  lose,
  draw;
  String get text{
    switch(this){
      case Result.win:
        return '勝ち';
      case Result.lose:
        return '負け';
      case Result.draw:
        return 'あいこ';
    }
  }
}

