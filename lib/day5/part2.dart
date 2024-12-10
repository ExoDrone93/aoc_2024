import 'package:aoc_2024_dart/day5/part1.dart';

day5part2() async {
  Map<String, List<List<int>>> input = await day5Part1();
  List<List<int>> incorrectLists = input['incorrectLists'] as List<List<int>>;
  List<List<int>> rules = input['rules'] as List<List<int>>;
  int result = 0;

  Map<int, List<int>> weightedRules = {};

  for (List<int> rule in rules) {
    if (!weightedRules.containsKey(rule[0])) {
      weightedRules[rule[0]] = [];
    }
    weightedRules[rule[0]]!.add(rule[1]);
  }

  for (List<int> incorrectList in incorrectLists) {
    incorrectList.sort((a, b) {
      if (weightedRules[a]?.contains(b) == true) {
        return -1;
      } else if (weightedRules[b]?.contains(a) == true) {
        return 1;
      } else {
        return 0;
      }
    });
    result += incorrectList.elementAt((incorrectList.length / 2).round() - 1);
  }

  print(result);
}
