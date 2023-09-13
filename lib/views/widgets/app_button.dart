import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Cell extends StatelessWidget {
  final void Function(int row, int column) onTap;
  final Widget? child;
  const Cell({
    super.key,
    required this.onTap,
    required this.row,
    required this.column,
    this.child,
  });
  final int row;
  final int column;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        onTap(row, column);
      },
      child: Container(
        width: 64,
        height: 64,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
          ),
        ),
        child: child,
      ),
    );
  }
}

class CellBall extends StatelessWidget {
  final Color color;
  final int count;
  final int occupiedBy;
  const CellBall({
    super.key,
    required this.count,
    required this.color,
    required this.occupiedBy,
  });

  @override
  Widget build(BuildContext context) {
    if (count == 1) {
      return SingleBall(color: color);
    }
    if (count == 2) {
      return DoubleBall(color: color);
    }
    return TrippleBall(color: color);
  }
}

class SingleBall extends StatelessWidget {
  final Color color;
  const SingleBall({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(128),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.grey.withOpacity(0.6))
        ],
        gradient: RadialGradient(
          center: const Alignment(0, -0.75),
          colors: [
            Colors.white,
            color,
          ],
        ),
      ),
    );
  }
}

class DoubleBall extends StatelessWidget {
  final Color color;
  const DoubleBall({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        Positioned(
          top: 8,
          right: 4,
          child: SingleBall(
            color: color,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: SingleBall(
            color: color,
          ),
        ),
      ],
    );
  }
}

class TrippleBall extends StatelessWidget {
  final Color color;
  const TrippleBall({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // fit: StackFit.expand,
      children: [
        Positioned(
          top: 8,
          right: 4,
          child: SingleBall(
            color: color,
          ),
        ),
        Positioned(
          top: 8,
          left: 8,
          child: SingleBall(
            color: color,
          ),
        ),
        Positioned(
          top: 24,
          left: 20,
          child: SingleBall(
            color: color,
          ),
        ),
      ],
    ).animate(autoPlay: true).shake(duration: Duration(days: 1));
  }
}

class Ball {
  int row;
  int column;
  int playerId;
  Widget? widget;
  int count;

  Ball({
    required this.row,
    required this.column,
    required this.playerId,
    this.widget,
    this.count = 0,
  });
}
  // setState(() {
                        //   filledWith["$row$column"] = TrippleBall();

                        //   SingleBall(
                        //       color:
                        //           playerIndex == 0 ? Colors.red : Colors.green);
                        //   changePlayer();
                        //   // Color((Random().nextDouble() * 0xFFFFFF).toInt())
                        //   //     .withOpacity(1.0);
                        // });
                        // print("Row $row , Column $column");
                        // showCupertinoDialog(
                        //   context: context,
                        //   builder: (context) {
                        //     return CupertinoAlertDialog(
                        //       content: Column(
                        //         children: [
                        //           Text(
                        //             "Row $row , Column $column",
                        //             style: GoogleFonts.nunito(fontSize: 16,

                        //             ),
                        //           ),
                        //         ],
                        //       ),
                        //       actions: [
                        //         CupertinoButton(
                        //           child: Text(
                        //             "Ok",
                        //             style: GoogleFonts.nunito(
                        //               fontSize: 16,
                        //               letterSpacing: 2.0,
                        //             ),
                        //           ),
                        //           onPressed: () {
                        //             Navigator.pop(context);
                        //           },
                        //         )
                        //       ],
                        //     );
                        //   },
                        // );