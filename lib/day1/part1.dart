import 'dart:io';

day1Part1() async {
  final input = File('inputs/day1Input.txt');
  List<int> left = [];
  List<int> right = [];
  int result = 0;
  List<List<int>> lines = await input.readAsLines().then(
      (List<String> fileLines) => fileLines
          .map((line) => line.split('   ').map(int.parse).toList())
          .toList());
  for (var line in lines) {
    left.add(line[0]);
    right.add(line[1]);
  }
  left.sort();
  right.sort();
  for (var i = 0; i < left.length; i++) {
    var diff = (left[i] - right[i]).abs();
    result += diff;
  }
  print('day1 part1: $result');
}
