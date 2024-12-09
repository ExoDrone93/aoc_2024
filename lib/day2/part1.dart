import 'dart:io';

bool isSafe(List<int> line) {
  var initialDiff = line[0] - line[1];
  if (initialDiff.sign == 0 || initialDiff.abs() > 3) {
    return false;
  }

  for (var i = 1; i < line.length; i++) {
    var diff = line[i - 1] - line[i];
    if (diff.abs() > 3 || diff.abs() < 1 || initialDiff.sign != diff.sign) {
      return false;
    }
  }
  return true;
}

day2Part1() async {
  final input = File('inputs/day2Input.txt');
  int result = 0;
  List<List<int>> lines = await input.readAsLines().then(
      (List<String> fileLines) => fileLines
          .map((line) => line.split(' ').map(int.parse).toList())
          .toList());
  for (var line in lines) {
    if (isSafe(line)) {
      result += 1;
    }
  }
  print('day2 part1: $result');
}
