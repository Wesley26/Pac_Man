import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:pac_man/components/path.dart';
import 'package:pac_man/components/pixel.dart';
import 'package:pac_man/components/player.dart';

/*
 * Home page class component.
 */

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static int numberInRow = 11;
  int numberOfSquares = numberInRow * 17; //builds the map made out of squares
  int player = numberInRow * 15 + 1; //player start position

  /*
   * barriers - Array storing which square indices act as game barriers.
   */
  List<int> barriers = [
    0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, // top X-Axis
    11, 22, 33, 44, 55, 66, 77, 99, 110, 121, 132, 143, 154, 165,
    176, // left Y-Axis
    177, 178, 179, 180, 181, 182, 183, 184, 185, 186, // bottom X-axis
    175, 164, 153, 142, 131, 120, 109, 87, 76, 65, 54, 43, 32,
    21, //right Y-axis
    78, 79, 80, 81, 70, 59, 61, 72, 83, 84, 85, 86, 24, 35, 46, 57,
    26, 37, 38, 39, 28, 30, 41, 52, 63, // top-half of the course
    100, 101, 102, 103, 114, 125, 127, 116, 105, 106, 107, 108,
    156, 145, 134, 123, 162, 151, 140, 129, 158, 147, 148, 149,
    160, // bottom-half of the course
  ];

  String direction = "right"; //controls pac_man player direction

  void startGame() {
    /*
     * startGame - void function starts moving pac_man
     * Note: Set timer to 300 milliseconds, any other speed is either too fast
     * or too slow for pac man's movement speed.
     */
    Timer.periodic(Duration(milliseconds: 300), (timer) {
      switch (direction) {
        case "left":
          moveLeft();
          break;
        case "right":
          moveRight();
          break;
        case "up":
          moveUp();
          break;
        case "down":
          moveDown();
          break;
      }
    });
  }

  void moveLeft() {
    //controls player left movement
    if (!barriers.contains(player - 1)) {
      setState(() {
        player--;
      });
    }
  }

  void moveRight() {
    //controls player right movement
    if (!barriers.contains(player + 1)) {
      setState(() {
        player++;
      });
    }
  }

  void moveUp() {
    //controls player up movement
    if (!barriers.contains(player - numberInRow)) {
      setState(() {
        player -= numberInRow;
      });
    }
  }

  void moveDown() {
    //controls player down movement
    if (!barriers.contains(player + numberInRow)) {
      setState(() {
        player += numberInRow;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                if (details.delta.dy > 0) {
                  direction = "down";
                } else if (details.delta.dy < 0) {
                  direction = "up";
                }
                //print(direction); //uncomment for direction output in console
              },
              onHorizontalDragUpdate: (details) {
                if (details.delta.dx > 0) {
                  direction = "right";
                } else if (details.delta.dx < 0) {
                  direction = "left";
                }
                //print(direction); //uncomment for direction output in console
              },
              child: Container(
                child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: numberOfSquares,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: numberInRow),
                    itemBuilder: (BuildContext context, int index) {
                      if (player == index) {
                        switch (direction) {
                          //controls direction pac_man is facing
                          case "left":
                            return Transform.rotate(
                              angle: pi,
                              child: MyPlayer(),
                            );
                          case "right":
                            return MyPlayer();
                          case "up":
                            return Transform.rotate(
                              angle: 3 * pi / 2,
                              child: MyPlayer(),
                            );
                          case "down":
                            return Transform.rotate(
                              angle: pi / 2,
                              child: MyPlayer(),
                            );
                          default:
                            return MyPlayer();
                        }
                      } else if (barriers.contains(index)) {
                        return MyPixel(
                          innerColor: Colors.blue[700],
                          outerColor: Colors.blue[700],
                          //child: Text(index.toString()), //uncomment for index
                        );
                      } else {
                        return MyPath(
                          innerColor: Colors.yellow,
                          outerColor: Colors.black,
                          //child: Text(index.toString()), //uncomment for index
                        );
                      }
                    }),
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Score: ",
                    style: TextStyle(color: Colors.white, fontSize: 40),
                  ),
                  GestureDetector(
                      onTap: startGame,
                      child: Text(
                        "P L A Y",
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
