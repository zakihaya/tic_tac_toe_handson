import 'package:flutter/material.dart';
import 'package:tuc_tac_toe_handson/model/tic_tac_toe.dart';

class Board extends StatefulWidget {
  const Board({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BoardState();
}

class _BoardState extends State<Board> {
  // ゲームの状態
  TicTacToe _ticTacToe = TicTacToe.start(playerX: "Dash", playerO: "Sparky");

  @override
  Widget build(BuildContext context) {
    // 画面いっぱいに描画領域だけを確保しています
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 横方向のマス数(3個)
            ),
            itemCount: 9, // 縦横のマス数の合計(3x3=9個),
            itemBuilder: (context, index) {
              final row = index ~/ 3; // 行番号
              final col = index % 3; // 列番号
              final mark = _ticTacToe.board[row][col]; // マス目の状態

              return GestureDetector(
                onTap: () {
                  setState(() {
                    final winner = _ticTacToe.getWinner();
                    if (mark.isEmpty && winner.isEmpty) {
                      _ticTacToe = _ticTacToe.placeMark(row, col);
                    }
                  });
                },
                child: Container(
                  // マス目の罫線をgrayで描画
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Center(
                    child: Text(
                      mark,
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
