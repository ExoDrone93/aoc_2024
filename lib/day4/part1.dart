import 'dart:io';

int checkXMAS(List<String> input, int row, int col) {
  List<List<int>> directions = [
    [0, 1],
    [0, -1],
    [1, 0],
    [-1, 0],
    [1, 1],
    [-1, -1],
    [1, -1],
    [-1, 1]
  ];

  int matches = 0;

  String target = 'XMAS';
  int rows = input.length;
  int cols = input[row].length;

  for (var direction in directions) {
    bool found = true;

    for (var i = 0; i < target.length; i++) {
      int newRow = row + i * direction[0];
      int newCol = col + i * direction[1];

      if (newRow < 0 ||
          newRow >= rows ||
          newCol < 0 ||
          newCol >= cols ||
          input[newRow][newCol] != target[i]) {
        found = false;
        break;
      }
    }

    if (found) {
      matches += 1;
    }
  }

  return matches;
}

day4Part1() async {
  List<String> input = await File('inputs/day4Input.txt').readAsLines();

  int result = 0;

  for (var row = 0; row < input.length; row++) {
    for (var col = 0; col < input[row].length; col++) {
      if (input[row][col] == 'X') {
        result += checkXMAS(input, row, col);
      }
    }
  }

  print('day4 part1: $result');
}
