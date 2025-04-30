import 'package:flutter/material.dart';
import 'package:flutter_application_1/util/imports.dart';
import '../../../../../../util/gradient_label.dart';
import '../../../../../../util/tactile_button.dart';

class WalletC2 extends StatefulWidget {
  WalletC2({Key? key}) : super(key: key);

  @override
  State<WalletC2> createState() => _WalletC2State();
}

class _WalletC2State extends State<WalletC2> {
  final TextEditingController _controller = TextEditingController();
  bool isEditable = false;
  bool isHidden = true;
  bool isSwitch = false;
  bool isSwitch2 = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 1.5.h(context)),
      child: Container(
        height: 35.h(context),
        width: 33.w(context),
        decoration: const BoxDecoration(
          color: const Color.fromARGB(70, 32, 32, 40),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w(context), vertical: 3.h(context)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //This row contains textfiled for the linked card, visibility icon, and save/edit tactile button
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        enabled: isEditable,
                        obscureText: isHidden,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: 'Linked Card',
                          hintStyle: const TextStyle(color: Colors.white70),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                          // enabledBorder: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          //   borderSide: BorderSide(color: Colors.grey),
                          // ),
                          // focusedBorder: const OutlineInputBorder(
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          //   borderSide: BorderSide(color: Colors.white),
                          // ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            onPressed: () => setState(() => isHidden = !isHidden),
                            icon: Icon(
                              isHidden ? Icons.visibility_off : Icons.visibility,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TactileButton(
                      onTap: () {
                        if (isEditable) {
                          debugPrint('Saved: ${_controller.text}');
                        }
                        setState(() => isEditable = !isEditable);
                      },
                      child: GradientContainer(
                        gradient1: isEditable ? blue : Colors.transparent,
                        gradient2: isEditable ? const Color.fromARGB(255, 85, 221, 89) : Colors.transparent,
                        height: 1.h(context),
                        width: 2.h(context),
                        neonGlow: isEditable ? greenGlow : Colors.transparent,
                        text: isEditable ? 'Save' : 'Edit',
                        textSize: 2.sp(context),
                        borderColor: Colors.white38,
                        borderRadius: 500,
                        // Use default color if not editable
                      ),
                    ),
                  ],
                ),
                const Divider(color: Colors.grey),
                SizedBox(
                  height: 1.h(context),
                ),
                //this colummn holds the multifactor Authentication and the Blur info on load swicthes
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Security & Privacy',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 3.sp(context),
                      ),
                    ),
                    SizedBox(
                      height: 1.h(context),
                    ),
                    buildSwitchRow(
                      context,
                      'Multifactor Authentication',
                      isSwitch,
                      (bool value) => setState(() => isSwitch = value),
                    ),
                    SizedBox(
                      height: 1.h(context),
                    ),
                    buildSwitchRow(
                      context,
                      'Blur Info On Load',
                      isSwitch2,
                      (bool value) => setState(() => isSwitch2 = value),
                    ),
                  ],
                ),
                SizedBox(
                  height: 1.h(context),
                ),
                const Divider(color: Colors.grey),
                SizedBox(
                  height: 1.h(context),
                ),
                //this column holds financial statements for the duration of account access
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Statements',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 3.sp(context),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          getCurrentMonth(),
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 2.sp(context),
                          ),
                        ),
                        TactileButton(
                          onTap: () {},
                          child: GradientContainer(
                            gradient1: blue,
                            gradient2: const Color.fromARGB(255, 85, 221, 89),
                            height: 1.h(context),
                            width: 2.h(context),
                            neonGlow: greenGlow,
                            text: 'View',
                            textSize: 2.sp(context),
                            borderColor: Colors.white38,
                            borderRadius: 500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSwitchRow(BuildContext context, String label, bool value, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 2.sp(context),
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Container(
            width: 50,
            height: 28,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: value
                  ? const LinearGradient(
                      colors: [blue, Color.fromARGB(255, 85, 221, 89)],
                    )
                  : const LinearGradient(
                      colors: [Colors.grey, Colors.grey],
                    ),
            ),
            child: AnimatedAlign(
              duration: const Duration(milliseconds: 200),
              alignment: value ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  String getCurrentMonth() {
    final now = DateTime.now();
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return '${months[now.month - 1]} ${now.year}';
  }
}
