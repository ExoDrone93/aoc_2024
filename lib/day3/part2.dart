import 'dart:io';

day3Part2() async {
  String input = await File('inputs/day3Input.txt').readAsString();
  RegExp splitPattern = RegExp(r"(?=do\(\)|don't\(\))");

  bool isEnabled = true;

  List<String> instructions = input.split(splitPattern);

  List pairs = [];
  int result = 0;

  for (var segment in instructions) {
    if (segment.startsWith('do()')) {
      isEnabled = true;
    } else if (segment.startsWith("don't()")) {
      isEnabled = false;
    }

    if (isEnabled) {
      RegExp pattern = RegExp(r'(mul\(\d{1,3},\d{1,3}\))');
      Iterable<RegExpMatch> matches = pattern.allMatches(segment);
      for (var m in matches) {
        var match = m[0];
        RegExp unnecessaryPArt = RegExp(r'[mul()]+');
        var pair = match?.replaceAll(unnecessaryPArt, '');
        pairs.add(pair?.split(',').toList());
      }
    }
  }

  for (var pair in pairs) {
    result += int.parse(pair[0]) * int.parse(pair[1]);
  }

  print('day3 part2: $result');
}
