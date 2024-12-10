import 'dart:io';

class Patrol {
  List<String> guard = ['^', '>', 'v', '<'];
  List<String> patrolMap = [];

  Patrol(this.patrolMap);

  updateMapAfterStep(String persona, List<int> oldPositions, List<int> newPositions) {
    if (oldPositions[0] == newPositions[0]) {
      var row = patrolMap[oldPositions[0]].split('');
      var oldCol = oldPositions[1];
      var newCol = newPositions[1];

      row[oldCol] = 'X';
      row[newCol] = persona;

      patrolMap[oldPositions[0]] = row.join('');
    } else if (oldPositions[1] == newPositions[1]) {
      var oldRow = patrolMap[oldPositions[0]].split('');
      var newRow = patrolMap[newPositions[0]].split('');
      var col = oldPositions[1];

      oldRow[col] = 'X';
      newRow[col] = persona;

      patrolMap[newPositions[0]] = newRow.join('');

      patrolMap[oldPositions[0]] = oldRow.join('');
    }
  }

  getGuardPosition() {
    for (var row = 0; row < patrolMap.length; row++) {
      for (var col = 0; col < patrolMap[row].length; col++) {
        if (guard.contains(patrolMap[row][col])) {
          return [row, col, patrolMap[row][col]];
        }
      }
    }
    return null;
  }

  bool step(List<dynamic> initPos) {
    int row = initPos[0], col = initPos[1];
    String facing = initPos[2];
    List<int>? newPos;
    bool? out;

    switch (facing) {
      case '^':
        out = isOut(row - 1, col);
        newPos = (!isOut(row - 1, col) && isNotObstacle(row - 1, col)) ? [row - 1, col] : null;
        break;
      case '>':
        out = isOut(row, col + 1);
        newPos = (!isOut(row, col + 1) && isNotObstacle(row, col + 1)) ? [row, col + 1] : null;
        break;
      case 'v':
        out = isOut(row + 1, col);
        newPos = (!isOut(row + 1, col) && isNotObstacle(row + 1, col)) ? [row + 1, col] : null;
        break;
      case '<':
        out = isOut(row, col - 1);
        newPos = (!isOut(row, col - 1) && isNotObstacle(row, col - 1)) ? [row, col - 1] : null;
        break;
    }

    if (out == true) {
      return false;
    }

    if (newPos == null) {
      String newDirection = guard[(guard.indexOf(facing) + 1) % 4];
      updateMapAfterStep(newDirection, [row, col], [row, col]);
      return true;
    }

    updateMapAfterStep(facing, [row, col], newPos);
    return true;
  }

  bool isNotObstacle(int row, int col) {
    return patrolMap[row][col] != '#';
  }

  bool isOut(int row, int col) {
    return row < 0 || row >= patrolMap.length || col < 0 || col >= patrolMap[row].length;
  }
}

day6part1() async {
  List<String> file = await File('inputs/day6Input.txt').readAsLines();
  Patrol patrol = Patrol(file);
  int result = 0;
  RegExp resultPattern = RegExp(r'[X^>v<]');

  while (true) {
    var pos = patrol.getGuardPosition();
    if (pos == null || patrol.step(pos) == false) {
      break;
    }
  }

  for (var row in patrol.patrolMap) {
    result += resultPattern.allMatches(row).length;
  }

  print(patrol.patrolMap.join('\n'));

  print(result);
}
