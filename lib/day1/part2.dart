import 'dart:io';

day1Part2() async {
  final input = File('inputs/day1Input.txt');
  List<int> left = [];
  List<int> right = [];
  num result = 0;
  List<List<int>> lines = await input.readAsLines().then(
      (List<String> fileLines) => fileLines
          .map((line) => line.split('   ').map(int.parse).toList())
          .toList());
  for (var line in lines) {
    left.add(line[0]);
    right.add(line[1]);
  }
  for (var leftNumber in left) {
    result += leftNumber *
        right.where((rightNumber) => rightNumber == leftNumber).length;
  }
  print('day1 part2: $result');
}
