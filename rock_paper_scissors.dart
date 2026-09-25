import 'dart:io';

List<String> moves = ['rock', 'paper', 'scissors'];

/// Displays the title of the game.
void showTitle() {
  print('===== ROCK, PAPER, SCISSORS =====');
}

/// Gets the name of a player.
String getPlayerName(String player) {
  stdout.write('Enter $player name: ');
  String? input = stdin.readLineSync();

  if (input == null || input.trim().isEmpty) {
    return player;
  }

  return input.trim();
}

/// Checks if the player's move is valid.
String? validateMove(String? input) {
  if (input == null) {
    return null;
  }

  String move = input.trim().toLowerCase();

  if (moves.contains(move)) {
    return move;
  }

  return null;
}

/// Gets a valid move from the player.
String getMove(String player) {
  while (true) {
    stdout.write('$player, enter your move (rock/paper/scissors): ');

    String? input = stdin.readLineSync();
    String? move = validateMove(input);

    if (move != null) {
      return move;
    }

    print('Invalid move. Please type rock, paper, or scissors.');
  }
}

/// Hides Player 1's move by printing blank lines.
void hideMove() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}

/// Decides the winner of the round.
String? decideWinner(String playerOneMove, String playerTwoMove) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  if (playerOneMove == 'rock') {
    if (playerTwoMove == 'scissors') {
      return 'Player 1';
    }
  }

  if (playerOneMove == 'paper') {
    if (playerTwoMove == 'rock') {
      return 'Player 1';
    }
  }

  if (playerOneMove == 'scissors') {
    if (playerTwoMove == 'paper') {
      return 'Player 1';
    }
  }

  return 'Player 2';
}

void main() {
  showTitle();

  String playerOne = getPlayerName('Player 1');
  String playerTwo = getPlayerName('Player 2');

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int round = 1;

  String? playAgain;

  do {
    print('');
    print('--- Round $round ---');

    String playerOneMove = getMove(playerOne);

    hideMove();

    String playerTwoMove = getMove(playerTwo);

    print('');
    print('$playerOne chose $playerOneMove.');
    print('$playerTwo chose $playerTwoMove.');

    String? winner = decideWinner(playerOneMove, playerTwoMove);

    if (winner == null) {
      print("Result: It's a draw!");
    } else if (winner == 'Player 1') {
      print('Result: $playerOne wins the round!');
      playerOneScore++;
    } else {
      print('Result: $playerTwo wins the round!');
      playerTwoScore++;
    }

    print(
      'Score -> $playerOne: $playerOneScore | '
      '$playerTwo: $playerTwoScore',
    );

    stdout.write('Play again? (y/n): ');
    playAgain = stdin.readLineSync()?.trim().toLowerCase();

    round++;
  } while (playAgain == 'y');

  print('');
  print('===== FINAL SCORE =====');
  print('$playerOne: $playerOneScore');
  print('$playerTwo: $playerTwoScore');

  if (playerOneScore == playerTwoScore) {
    print("Overall winner: It's a draw!");
  } else if (playerOneScore > playerTwoScore) {
    print('Overall winner: $playerOne');
  } else {
    print('Overall winner: $playerTwo');
  }
}
