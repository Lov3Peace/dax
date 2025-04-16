// import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:flutter/widgets.dart';

extension sizeShortcuts on num {
  /// Calculates the height depending on the device's screen size
  ///
  /// Eg: 20.h(context) -> will take 20% of the screen's height
  double h(BuildContext context) => this * MediaQuery.of(context).size.height / 100;

  /// Calculates the width depending on the device's screen size
  ///
  /// Eg: 20.w(context) -> will take 20% of the screen's width
  double w(BuildContext context) => this * MediaQuery.of(context).size.width / 100;

  /// Calculates the sp (Scalable Pixel) depending on the device's screen size
  double sp(BuildContext context) => this * (MediaQuery.of(context).size.width / 3) / 100;
}
