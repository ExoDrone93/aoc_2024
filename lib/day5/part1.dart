import 'dart:io';

class ParsedInput {
  List<List<int>> rules, pages;

  ParsedInput(this.rules, this.pages);

  static Future<ParsedInput> parseInput(String path) async {
    List<String> file = await File(path).readAsLines();
    List<List<int>> rules = [];
    List<List<int>> pages = [];
    bool isRule = true;

    for (var line in file) {
      if (line == '') {
        isRule = false;
        continue;
      }

      if (isRule == true) {
        List<int> rule = line.split('|').map<int>((page) => int.parse(page)).toList();
        rules.add(rule);
      } else {
        List<int> pageList = line.split(',').map<int>((page) => int.parse(page)).toList();
        pages.add(pageList);
      }
    }

    return ParsedInput(rules, pages);
  }
}

Future<Map<String, List<List<int>>>> day5Part1() async {
  ParsedInput parsedInput = await ParsedInput.parseInput('inputs/day5Input.txt');

  int result = 0;
  List<List<int>> incorrectLists = [];

  for (var pageCollections in parsedInput.pages) {
    bool isOk = true;
    for (var rule in parsedInput.rules) {
      if (pageCollections.contains(rule[0]) && pageCollections.contains(rule[1])) {
        if (pageCollections.indexOf(rule[1]) < pageCollections.indexOf(rule[0])) {
          isOk = false;
          break;
        }
      }
    }

    if (isOk) {
      result += pageCollections.elementAt((pageCollections.length / 2).round() - 1);
    } else {
      incorrectLists.add(pageCollections);
    }
  }

  print(result);
  return {'rules': parsedInput.rules, 'incorrectLists': incorrectLists};
}
