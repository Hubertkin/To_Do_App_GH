import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Color customColor({String? date}) {
  switch (date) {
    case 'Today':
      return Colors.blue;
    case 'Yesterday':
      return Colors.pink;
    case 'Tomorrow':
      return Colors.amber;
    default:
      return Colors.grey;
  }
}

String deadline({DateTime? date}) {
  if (date!.isAtSameMomentAs(DateTime.now())) {
    return 'Today';
  } else if (date.isAfter(DateTime.now())) {
    return 'Yesterday';
  } else if (date.isBefore(DateTime.now())) {
    return 'Tomorrow';
  } else {
    return DateFormat().format(date);
  }
}
