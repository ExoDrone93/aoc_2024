import 'dart:io';

import 'package:aoc_2024_dart/day2/part1.dart';

day2Part2() async {
  final input = File('inputs/day2Input.txt');
  int result = 0;
  List<List<int>> lines = await input.readAsLines().then(
      (List<String> fileLines) => fileLines
          .map((line) => line.split(' ').map(int.parse).toList())
          .toList());

  List<List<int>> unsafeReports = [];
  for (var line in lines) {
    if (isSafe(line)) {
      result += 1;
    } else {
      unsafeReports.add(line);
    }
  }

  for (var line in unsafeReports) {
    for (var i = 0; i < line.length; i++) {
      var tmp = List<int>.from(line);
      tmp.removeAt(i);
      if (isSafe(tmp)) {
        result += 1;
        break;
      }
    }
  }

  print('day2 part2: $result');
}
