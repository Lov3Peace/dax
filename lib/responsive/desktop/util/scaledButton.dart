import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/responsive/desktop/util/responsive_shorthand.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/tactile_button.dart';

class ScaledButton extends StatefulWidget {
  const ScaledButton({super.key});

  @override
  State<ScaledButton> createState() => _ScaledButtonState();
}

bool activated = false;
double intialLayerOpacity = 1.0;
double secondaryLayerOpacity = 0;
double initialLayerHeight = 250;
double initialLayerWidth = 100;

class _ScaledButtonState extends State<ScaledButton> {
  @override
  Widget build(BuildContext context) {
    return TactileButton(
      onTap: () {
        setState(() {
          activated = !activated;
        });
      },
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                  color: white,
                  height: activated ? 30.w(context) : initialLayerHeight,
                  width: activated ? 30.w(context) : initialLayerWidth,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Expanded(
                child: GradientContainer(
                  height: activated ? 30.w(context) : initialLayerHeight,
                  width: activated ? 30.w(context) : initialLayerWidth,
                  text: "New Project",
                  textSize: 16,
                  fontWeight: FontWeight.w600,
                  gradient1: red,
                  gradient2: pink,
                  neonGlow: pink,
                  borderColor: tran,
                  borderRadius: 25.w(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
