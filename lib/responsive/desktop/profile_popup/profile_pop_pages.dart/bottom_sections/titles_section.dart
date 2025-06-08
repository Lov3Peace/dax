import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/gradient_label.dart';
import 'package:flutter_application_1/util/imports.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../util/tactile_button.dart';

class PCTitles extends StatefulWidget {
  PCTitles({super.key});

  @override
  State<PCTitles> createState() => _PCTitlesState();
}

class _PCTitlesState extends State<PCTitles> {
  final List<Map<String, dynamic>> availableButtons = [
    {"id": "btn1", "label": "Creator"},
    {"id": "btn2", "label": "Project Manager"},
    {"id": "btn3", "label": "Developer"},
    {"id": "btn4", "label": "Engineer"},
    {"id": "btn5", "label": "Liaison"},
  ];

  // Predefined gradient colors for each title
  final Map<String, List<Color>> buttonGradients = {
    "btn1": [Colors.red, Colors.orange], // Creator
    "btn2": [Colors.blue, Colors.indigo], // Project Manager
    "btn3": [Colors.green, Colors.teal], // Developer
    "btn4": [Colors.purple, Colors.deepPurple], // Engineer
    "btn5": [Colors.pink, Colors.redAccent], // Liaison
  };

  Set<String> selectedButtons = {};

  @override
  void initState() {
    super.initState();
    loadSelectedButtons();
  }

  Future<void> loadSelectedButtons() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedButtons = prefs.getStringList('selected_buttons')?.toSet() ?? {};
    });
  }

  Future<void> saveSelectedButtons() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('selected_buttons', selectedButtons.toList());
  }

  void showSelectionDialog() {
    Set<String> tempSelection = Set.from(selectedButtons);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Earned Titles"),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: availableButtons.map((button) {
                  bool isSelected = tempSelection.contains(button["id"]);
                  return CheckboxListTile(
                    title: Text(button["label"]),
                    value: isSelected,
                    onChanged: (bool? value) {
                      setDialogState(() {
                        if (value == true && tempSelection.length < 3) {
                          tempSelection.add(button["id"]);
                        } else if (value == false) {
                          tempSelection.remove(button["id"]);
                        }
                      });
                    },
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
            TactileButton(
              onTap: () {
                setState(() {
                  selectedButtons = tempSelection;
                });
                saveSelectedButtons();
                Navigator.pop(context);
              },
              child: GradientContainer(
                gradient1: Colors.blue,
                gradient2: Colors.purple,
                height: 1.h(context),
                width: 1.5.w(context),
                neonGlow: Colors.purple,
                text: 'Confirm',
                textSize: 2.5.sp(context),
                borderColor: Colors.transparent,
                borderRadius: 500,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h(context),
      width: 18.w(context),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(30),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'Titles',
              style: TextStyle(fontSize: 3.25.sp(context), color: Colors.white),
            ),
            SizedBox(height: 1.h(context)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                selectedButtons.isEmpty
                    ? Center(
                        child: TactileButton(
                          onTap: showSelectionDialog,
                          child: GradientContainer(
                            gradient1: Colors.blue,
                            gradient2: Colors.purple,
                            height: 1.h(context),
                            width: 1.5.w(context),
                            neonGlow: Colors.purple,
                            text: 'Choose Titles',
                            textSize: 2.5.sp(context),
                            borderColor: Colors.transparent,
                            borderRadius: 500,
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: selectedButtons.map((buttonId) {
                          final button = availableButtons
                              .firstWhere((b) => b["id"] == buttonId);
                          final gradientColors = buttonGradients[buttonId] ??
                              [Colors.grey, Colors.black];

                          return Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 0.5.h(context)), // Adds spacing
                            child: TactileButton(
                              onTap:
                                  showSelectionDialog, // Opens selection modal
                              child: GradientContainer(
                                gradient1: gradientColors[0],
                                gradient2: gradientColors[1],
                                height: 5,
                                width: 20,
                                neonGlow: gradientColors[1],
                                text: button["label"],
                                textSize: 2.5.sp(context),
                                borderColor: Colors.transparent,
                                borderRadius: 500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
