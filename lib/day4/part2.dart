import 'dart:io';

bool isValidPosition(int row, int col, int rows, int cols) {
  return row >= 0 && row < rows && col >= 0 && col < cols;
}

bool checkXMAS(List<String> input, int row, int col) {
  List<List<int>> directionPairs = [
    [1, 1, -1, -1],
    [1, -1, -1, 1]
  ];

  int matches = 0;

  int rows = input.length;
  int cols = input[row].length;

  for (var direction in directionPairs) {
    int topRow = row + direction[0];
    int topCol = col + direction[1];
    int bottomRow = row + direction[2];
    int bottomCol = col + direction[3];
    if (!isValidPosition(topRow, topCol, rows, cols) ||
        !isValidPosition(bottomRow, bottomCol, rows, cols)) {
      break;
    }

    if (input[topRow][topCol] == 'M' && input[bottomRow][bottomCol] == 'S' ||
        input[topRow][topCol] == 'S' && input[bottomRow][bottomCol] == 'M') {
      matches += 1;
    }
  }

  if (matches == 2) {
    return true;
  } else {
    return false;
  }
}

day4Part2() async {
  List<String> input = await File('inputs/day4Input.txt').readAsLines();

  int result = 0;

  for (var row = 0; row < input.length; row++) {
    for (var col = 0; col < input[row].length; col++) {
      if (input[row][col] == 'A' && checkXMAS(input, row, col)) {
        result += 1;
      }
    }
  }

  print('day4 part2: $result');
}
