import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'gamelogic.dart';
import 'logicClass.dart';

//import 'package:flutter/animation.dart';

void main() {
  runApp(MaterialApp(
    home: TicTacToePage(),
  ));
}

class TicTacToePage extends StatefulWidget {
  @override
  _TicTacToePageState createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  Widget getIcon(token t) {
    if (t == token.o) {
      return Icon(
        Icons.radio_button_unchecked,
        size: 80,
        color: Colors.white,
      );
    }
    if (t == token.x) {
      return Icon(
        Icons.close,
        size: 80,
        color: Colors.white,
      );
    } else
      return null;
  }

  Color getColor(int row, int col) {
    return colorBoard[row][col]
        ? Colors.red.withOpacity(0.2)
        : Colors.blue;
  }

  void winnerPopup() {
    if (winnerCheck(board)) {
      //currentPlayer = "${currentPlayer.substring(7, 9)} Won";
    } else if (fullBoard(board)) {
      //currentPlayer = "draw";
    } else {
      changePlayer(currentPlayer);
    }
  }

  Widget singleExpandedBox(int row, int col) {
    return Expanded(
      child: OneBox(
        buttonChild: getIcon(board[row][col]),
        colors: getColor(row, col),
        onPressed: () {
          updateBox(row, col);
          setState(() {});
        },
      ),
    );
  }

  Widget expandedRow(int row) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          singleExpandedBox(row, 0),
          singleExpandedBox(row, 1),
          singleExpandedBox(row, 2),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD6AA7C),
      body: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/paper.jpg'), fit: BoxFit.cover)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Tic-Tac-Toe",
                  style: TextStyle(
                      fontSize: 40,
                      color: Color(0xFF848AC1),
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Text(
                  "$currentPlayer",
                  style: TextStyle(
                      fontSize: 24,
                      color: Color(0xFF848AC1),
                      fontFamily: 'Quicksand'),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                margin: EdgeInsets.all(6),
                child: Column(
                  children: <Widget>[
                    expandedRow(0),
                    expandedRow(1),
                    expandedRow(2),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      child: FlatButton(
                        color: Color(0xFF848AC1),
                        onPressed: () {
                          gameReset();
                          setState(() {});
                        },
                        child: Text("Reset",
                            style:
                            TextStyle(fontSize: 25, color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                    flex: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void updateBox(int r, int c) {
    if (legitMove(board[r][c])) {
      if (currentPlayer == token.x) {
        board[r][c] = token.x;
      } else {
        board[r][c] = token.o;
      }
      winnerPopup();
    }
  }
}

