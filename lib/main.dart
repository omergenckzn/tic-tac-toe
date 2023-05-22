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
        primarySwatch: Colors.blue,
      ),
      home: const TicTacToe(),
    );
  }
}

class TicTacToe extends StatefulWidget {
  const TicTacToe({Key? key}) : super(key: key);

  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {

  List<String> turnList = ["", "", "", "", "", "", "", "", ""];
  int turnCount = 0;
  bool isOTurn = true;

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 24,),
          Expanded(
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ), itemBuilder: (context, index) {

              return oneButton(index);
            }),
          )
        ],
      ),
    );
  }

  Padding oneButton(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(style: ElevatedButton.styleFrom(
      ), onPressed: turnList[index] == "" ? () {
        onPressed(index);

      } : () {}, child: Text(turnList[index])),
    );
  }


  void onPressed(int index) {
    setState(() {
      if (turnList[index] == "") {
        turnList[index] = "O";
        turnCount++;
        int randomIndex = random(0, 8);
        if(turnList[randomIndex] == "") {
          turnList[randomIndex] = "X";
        } else {
          turnList[randomIndex+1] = "X";
        }
      }

      _decideWinner();
    });
  }


  void _decideWinner() {
    if (turnList[0] == turnList [1] && turnList[0] == turnList [2] &&
        turnList[0] != "") {
      _showAlertDialog(turnList[0]);

    }
    if (turnList[3] == turnList [4] && turnList[3] == turnList [5] &&
        turnList[3] != "") {
      //is winner
      _showAlertDialog(turnList[3]);
    }
    if (turnList[6] == turnList [7] && turnList[6] == turnList [8] &&
        turnList[6] != "") {
      _showAlertDialog(turnList[6]);
      //is winner
    }

    if (turnList[0] == turnList[3] && turnList[0] == turnList[6] &&
        turnList[0] != "") {
      _showAlertDialog(turnList[0]);
      //is winnder
    }
    if (turnList[1] == turnList[4] && turnList[1] == turnList[7] &&
        turnList[1] != "") {
      _showAlertDialog(turnList[1]);
      //is winnder
    }
    if (turnList[2] == turnList[5] && turnList[2] == turnList[8] &&
        turnList[2] != "") {
      _showAlertDialog(turnList[2]);
      //is winnder
    }

    if (turnList[0] == turnList[4] && turnList[0] == turnList[8] &&
        turnList[0] != "") {
      _showAlertDialog(turnList[0]);
      //is winnder
    }
    if (turnList[2] == turnList[4] && turnList[2] == turnList[6] &&
        turnList[2] != "") {
      _showAlertDialog(turnList[2]);

    }

    if (turnCount == 9) {
      _showDrawDialog();
    }
  }






  void _showAlertDialog(String player) {
    showDialog(context: context, builder: (context) {
     return Dialog(
        child: Column(
          children: [
            Text("the Player $player is win the game"),
            ElevatedButton(onPressed: (){
              setState(() {
                turnList = ["", "", "", "", "", "", "", "", ""];
                turnCount = 0;
              });
              Navigator.of(context).pop();
            }, child: Text("Restart")),
          ],
        ),
      );
    });
  }

  void _showDrawDialog() {
    showDialog(context: context, builder: (context) {
      return Dialog(
        child: Column(
          children: [
            Text("Its a draw"),
            ElevatedButton(onPressed: (){
              setState(() {
                turnList = ["", "", "", "", "", "", "", "", ""];
                turnCount = 0;
              });
              Navigator.of(context).pop();
            }, child: Text("Restart")),
          ],
        ),
      );
    });
  }

  int random(int min, int max) {
    return min + Random().nextInt(max - min);
  }


}