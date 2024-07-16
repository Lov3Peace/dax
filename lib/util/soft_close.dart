import 'dart:math';

import 'package:flutter/material.dart';

class SoftClose extends Curve {
  final double count;

  const SoftClose({this.count = 0});

  // t = x
  @override
  double transformInternal(double t) {
    var val = sin(1.7 * t);
    return val; //f(x)
  }
}
