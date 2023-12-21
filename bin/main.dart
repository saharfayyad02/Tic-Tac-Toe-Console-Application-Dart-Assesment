import 'package:dart_application_1/dart_application_1.dart'
    as dart_application_1;
import 'dart:io';

void main() {
  // Initialize the Tic-Tac-Toe board
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ' '));

  // Display an empty board with numbers from 1 to 9
  displayBoard(board);

  // Game loop
  while (true) {
    // Player X's turn
    makeMove(board, 'X');

    // Display the board after X's move
    displayBoard(board);

    // Check for a winner or draw
    if (isGameOver(board)) {
      break;
    }

    // Player O's turn
    makeMove(board, 'O');

    // Display the board after O's move
    displayBoard(board);

    // Check for a winner or draw
    if (isGameOver(board)) {
      break;
    }
  }
}

void displayBoard(List<List<String>> board) {
  print('\nCurrent Board:');
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      int cellNumber = i * 3 + j + 1;
      String cellValue =
          board[i][j] == ' ' ? cellNumber.toString() : board[i][j];
      stdout.write('$cellValue');
      if (j < 2) {
        stdout.write('  |  ');
      }
    }
    print('');
    if (i < 2) {
      print('---+-----+---');
    }
  }
}

void makeMove(List<List<String>> board, String player) {
  while (true) {
    print('\nPlayer $player, enter your move (1-9):');
    int move = int.parse(stdin.readLineSync()!);

    // Validate the move
    if (move >= 1 && move <= 9) {
      // Convert move to row and column indices
      int row = (move - 1) ~/ 3;
      int col = (move - 1) % 3;

      // Check if the cell is empty
      if (board[row][col] == ' ') {
        // Make the move
        board[row][col] = player;
        break;
      } else {
        print('Error: Cell already occupied. Try again.');
      }
    } else {
      print('Error: Invalid move. Please enter a number between 1 and 9.');
    }
  }
}

bool isGameOver(List<List<String>> board) {
  if (checkWinner(board, 'X')) {
    print('Player X wins!');
    return true;
  } else if (checkWinner(board, 'O')) {
    print('Player O wins!');
    return true;
  } else if (isBoardFull(board)) {
    print('It\'s a draw!');
    return true;
  }
  return false;
}

bool checkWinner(List<List<String>> board, String player) {
  // Check rows and columns
  for (int i = 0; i < 3; i++) {
    if (board[i][0] == player &&
        board[i][1] == player &&
        board[i][2] == player) {
      return true; // Row winner
    }
    if (board[0][i] == player &&
        board[1][i] == player &&
        board[2][i] == player) {
      return true; // Column winner
    }
  }

  // Check diagonals
  if (board[0][0] == player && board[1][1] == player && board[2][2] == player) {
    return true; // Diagonal from top-left to bottom-right
  }
  if (board[0][2] == player && board[1][1] == player && board[2][0] == player) {
    return true; // Diagonal from top-right to bottom-left
  }

  return false; // No winner
}

bool isBoardFull(List<List<String>> board) {
  for (var row in board) {
    if (row.contains(' ')) {
      return false; // There's an empty cell
    }
  }
  return true; // Board is full
}
