import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/app_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Map<String, CellBall> filledWith = {};
  int playerIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  changePlayer() {
    if (playerIndex == 0) {
      playerIndex = 1;
    } else {
      playerIndex = 0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var noOfCellHorizontally = (width) ~/ 64;
    var noOfCellVertically = (height) ~/ 64;
    print(
        "[M] $height $width ${noOfCellHorizontally * 64} ${noOfCellVertically * 64}");
    var horizontalGap = width - noOfCellHorizontally * 64;
    var verticalGap = height - noOfCellVertically * 64;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            ...List.generate(
              noOfCellVertically,
              (index1) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ...List.generate(
                    noOfCellHorizontally,
                    (index2) => Cell(
                      row: index1,
                      column: index2,
                      child: filledWith["$index1$index2"],
                      onTap: (int row, int column) {
                        setState(() {
                          if (filledWith["$index1$index2"] != null) {
                            filledWith["$index1$index2"] = CellBall(
                                count: filledWith["$index1$index2"]!.count + 1,
                                color: Colors.red);
                          } else {
                            filledWith["$index1$index2"] =
                                const CellBall(count: 1, color: Colors.green);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<List<int>> board = [];

// Initialize the game board with 'rows' and 'columns'
  void initializeBoard(int rows, int columns) {
    board = List.generate(rows, (i) => List.generate(columns, (j) => 0));
  }

// Access a specific cell on the board
  int getCellValue(int row, int col) {
    if (row < 0 || row >= board.length || col < 0 || col >= board[0].length) {
      return -1; // Invalid cell
    }
    return board[row][col];
  }

// Update a cell's value
  void setCellValue(int row, int col, int value) {
    if (row >= 0 && row < board.length && col >= 0 && col < board[0].length) {
      board[row][col] = value;
    }
  }
}
