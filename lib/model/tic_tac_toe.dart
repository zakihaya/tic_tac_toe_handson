import 'package:tuc_tac_toe_handson/model/players.dart';

class TicTacToe {
  final List<List<String>> board;
  final Players players;
  final String currentPlayer;

  TicTacToe(
      {required this.board,
      required this.players,
      required this.currentPlayer});

  factory TicTacToe.start({
    playerX = "X",
    playerO = "O",
  }) {
    final players = Players(playerX: playerX, playerO: playerO);

    return TicTacToe(
      board: [
        ["", "", ""],
        ["", "", ""],
        ["", "", ""],
      ],
      players: players,
      currentPlayer: players.playerX,
    );
  }

  TicTacToe placeMark(int row, int column) {
    if (board[row][column].isEmpty) {
      final newBoard = List.of(board);
      newBoard[row][column] = currentPlayer == players.playerX ? "X" : "O";
      final newPlayer =
          currentPlayer == players.playerX ? players.playerO : players.playerX;

      return TicTacToe(
        board: newBoard,
        players: players,
        currentPlayer: newPlayer,
      );
    }

    return this;
  }

  String getWinner() {
    for (int i = 0; i < 3; i++) {
      // row = i におけるよこの判定
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0].isNotEmpty) {
        return board[i][0] == "X" ? players.playerX : players.playerO;
      }
      // col = i におけるたての判定
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i].isNotEmpty) {
        return board[0][i] == "X" ? players.playerX : players.playerO;
      }
    }
    // 左上から右下への斜めの判定
    if (board[0][0] == board[1][1] &&
        board[1][1] == board[2][2] &&
        board[0][0].isNotEmpty) {
      return board[0][0] == "X" ? players.playerX : players.playerO;
    }
    // 右上から左下への斜めの判定
    if (board[0][2] == board[1][1] &&
        board[1][1] == board[2][0] &&
        board[0][2].isNotEmpty) {
      return board[0][2] == "X" ? players.playerX : players.playerO;
    }
    return "";
  }

  bool isDraw() {
    return getWinner().isEmpty &&
        board.every((row) => row.every((cell) => cell.isNotEmpty));
  }

  TicTacToe resetBoard() {
    return TicTacToe.start(playerX: players.playerX, playerO: players.playerO);
  }
}
