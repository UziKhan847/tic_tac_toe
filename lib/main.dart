import 'package:flutter/material.dart';
import 'package:tic_tac_toe/widgets/box.dart';
import 'package:tic_tac_toe/widgets/player_box.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool playerOneTurn = true;

  final playerSymbols = List<String>.filled(9, '', growable: false);

  bool selectBox(int index) {
    if (playerSymbols[index].isEmpty) {
      setState(() {
        playerSymbols[index] = playerOneTurn ? 'O' : 'X';
        playerOneTurn = !playerOneTurn;
      });
      return checkWin(index);
    }

    return false;
  }

  bool checkWin(int index) {
    int row = index ~/ 3;
    int multipleOfThree = (row + 1) * 3 - index;
    int column = 3 - multipleOfThree;

    late int verticalOne;
    late int verticalTwo;
    late int horizontalOne;
    late int horizontalTwo;

    if (row == 0) {
      verticalOne = index + 3;
      verticalTwo = verticalOne + 3;

      if (column == 0) {
        horizontalOne = index + 1;
        horizontalTwo = horizontalOne + 1;
      } else if (column == 1) {
        horizontalOne = index - 1;
        horizontalTwo = index + 1;
      } else if (column == 2) {
        horizontalOne = index - 1;
        horizontalTwo = horizontalOne - 1;
      }
    } else if (row == 1) {
      verticalOne = index - 3;
      verticalTwo = index + 3;

      if (column == 0) {
        horizontalOne = index + 1;
        horizontalTwo = horizontalOne + 1;
      } else if (column == 1) {
        horizontalOne = index - 1;
        horizontalTwo = index + 1;
      } else if (column == 2) {
        horizontalOne = index - 1;
        horizontalTwo = horizontalOne - 1;
      }
    } else if (row == 2) {
      verticalOne = index - 3;
      verticalTwo = verticalOne - 3;

      if (column == 0) {
        horizontalOne = index + 1;
        horizontalTwo = horizontalOne + 1;
      } else if (column == 1) {
        horizontalOne = index - 1;
        horizontalTwo = index + 1;
      } else if (column == 2) {
        horizontalOne = index - 1;
        horizontalTwo = horizontalOne - 1;
      }
    }

    print('Column: $column');
    print('Row: $row');
    print('Index: $index');
    print('Index Remain: ${index % 2}');
    print('VertOne: $verticalOne');
    print('VertTwo: $verticalTwo');
    print('HoriOne: $horizontalOne');
    print('HoriTwo: $horizontalTwo');
    print(playerSymbols);
    // print(playerSymbols[4] == playerSymbols[2]);
    // print(playerSymbols[4] == playerSymbols[6]);
    // print(index % 2 == 0);

    if (playerSymbols[verticalOne] == playerSymbols[index] &&
        playerSymbols[verticalTwo] == playerSymbols[index]) {
      return true;
    } else if (playerSymbols[horizontalOne] == playerSymbols[index] &&
        playerSymbols[horizontalTwo] == playerSymbols[index]) {
      return true;
    }
    if (index.isEven) {
      if ((index == 0 || index % 4 == 0) &&
          playerSymbols[4] == playerSymbols[0] &&
          playerSymbols[4] == playerSymbols[8]) {
        return true;
      }
      if (playerSymbols[4].isNotEmpty &&
          index % 2 == 0 &&
          playerSymbols[4] == playerSymbols[2] &&
          playerSymbols[4] == playerSymbols[6]) {
        return true;
      }
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PlayerBox(
                boxColor: Colors.red.shade600,
                borderColor:
                    playerOneTurn ? Colors.red.shade900 : Colors.red.shade600,
                playerNumber: 1,
                elevation: playerOneTurn ? 5 : 0,
              ),
              const SizedBox(height: 25),
              Material(
                elevation: 5,
                shadowColor: Colors.grey.shade600,
                child: SizedBox(
                  height: 255,
                  width: 255,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 9,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return Box(
                        boxColor: index.isEven
                            ? Colors.green.shade300
                            : Colors.green.shade500,
                        onPressed: () {
                          bool didWin = selectBox(index);

                          print(didWin);
                        },
                        playerSymbol: playerSymbols[index],
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 25),
              PlayerBox(
                boxColor: Colors.blue.shade600,
                borderColor: !playerOneTurn
                    ? Colors.blue.shade900
                    : Colors.blue.shade600,
                playerNumber: 2,
                elevation: !playerOneTurn ? 5 : 0,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              playerOneTurn = true;
              playerSymbols.fillRange(0, 9, '');
            });
          },
          shape: const CircleBorder(),
          backgroundColor: Colors.grey.shade200,
          child: const Icon(
            Icons.restart_alt_rounded,
            size: 35,
          ),
        ),
      ),
    );
  }
}
