import 'dart:math';

import 'package:flutter/material.dart';

class SoftClose extends Curve {
  final double count;

  SoftClose({this.count = 3});

  // t = x
  @override
  double transformInternal(double t) {
    var val = cos(count * 2 * pi * t) * 0.5 + 0.5;
    return val; //f(x)
  }
}
