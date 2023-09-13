import 'dart:async';

import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../widgets/app_button.dart';


class ChainReactionGame extends FlameGame {

  @override
  FutureOr<void> onLoad() {
    print("onLoad");  
    return super.onLoad();
  }
  @override
  void onAttach() {
    // TODO: implement onAttach
    super.onAttach();
  }

  @override
  void onDetach() {
    // TODO: implement onDetach
    super.onDetach();
  }

  @override
  void onMount() {
    // TODO: implement onMount
    super.onMount();
  }

  @override
  void onRemove() {
    // TODO: implement onRemove
    super.onRemove();
  }
  @override
  void onGameResize(Vector2 size) {
    // TODO: implement onGameResize
    super.onGameResize(size);
  }

  @override
  void update(double dt) {
    // TODO: implement update
    super.update(dt);
  }
}
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
    var noOfCellHorizontally = (width) ~/ 64;//c
    var noOfCellVertically = (height) ~/ 64;//r
    print(
        "[M] $height $width ${noOfCellHorizontally * 64} ${noOfCellVertically * 64}");
    var horizontalGap = width - noOfCellHorizontally * 64;
    var verticalGap = height - noOfCellVertically * 64;
    // print("[M] $board");
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
                        fillCell(row, column);
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

  void fillCell(int row, int column) {
    setState(() {
      if (filledWith["$row$column"] != null) {
        filledWith["$row$column"] = CellBall(
          count: filledWith["$row$column"]!.count + 1,
          color: _getBallColor(filledWith["$row$column"]?.occupiedBy),
          occupiedBy: playerIndex,
        );
      } else {
        filledWith["$row$column"] = CellBall(
          count: 1,
          color: _getBallColor(filledWith["$row$column"]?.occupiedBy),
          occupiedBy: playerIndex,
        );
      }
    });
  }

  collideCells() {}

  Color _getBallColor(int? index) {
    if (index == 0) {
      return Colors.green;
    }
    return Colors.red;
  }
}
