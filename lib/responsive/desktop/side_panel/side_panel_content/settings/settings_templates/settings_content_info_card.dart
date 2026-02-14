import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  const SettingsCard({
    super.key,
    required this.title,
    required this.children,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.only(bottom: 2.h(context)),
      padding: padding ?? EdgeInsets.all(2.w(context)),
      decoration: BoxDecoration(
        color: tran,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 1.h(context),
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 3.5.sp(context),
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          ...children,
        ],
      ),
    );
  }
}
