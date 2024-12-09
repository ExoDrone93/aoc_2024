import 'dart:io';

day3Part1() async {
  String input = await File('inputs/day3Input.txt').readAsString();
  RegExp pattern = RegExp(r'(mul\(\d{1,3},\d{1,3}\))');
  Iterable<RegExpMatch> matches = pattern.allMatches(input);
  List pairs = [];
  int result = 0;
  for (var m in matches) {
    var match = m[0];
    RegExp unnecessaryPArt = RegExp(r'[mul()]+');
    var pair = match?.replaceAll(unnecessaryPArt, '');
    pairs.add(pair?.split(',').toList());
  }
  for (var pair in pairs) {
    result += int.parse(pair[0]) * int.parse(pair[1]);
  }
  print('day3 part1: $result');
}
