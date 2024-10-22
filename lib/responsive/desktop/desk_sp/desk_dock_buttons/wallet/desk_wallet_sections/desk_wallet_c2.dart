import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class WalletC2 extends StatelessWidget {
  WalletC2({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool isEditable = false;
    bool isHidden = true;
    bool isSwitch = false;
    bool isSwitch2 = false;

    return Padding(
      padding: EdgeInsets.only(top: 1.5.h),
      child: Container(
        height: 36.h,
        width: 33.w,
        decoration: const BoxDecoration(
          color: Color(0xFF272626),
          borderRadius: BorderRadius.all(Radius.circular(40)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildWalletAddressSection(setState, isEditable, isHidden),
                  const Divider(color: Colors.grey),
                  _buildSecurityPrivacySection(setState, isSwitch, isSwitch2),
                  const Divider(color: Colors.grey),
                  _buildStatementsSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWalletAddressSection(StateSetter setState, bool isEditable, bool isHidden) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                enabled: isEditable,
                obscureText: isHidden,
                decoration: const InputDecoration(
                  labelText: 'Linked Card',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 6),
        Column(
          children: [
            ElevatedButton(
              onPressed: () => setState(() => isEditable = !isEditable),
              child: Text(isEditable ? 'Save' : 'Edit'),
            ),
            const SizedBox(height: 6),
            ElevatedButton(
              onPressed: () => setState(() => isHidden = !isHidden),
              child: Text(isHidden ? 'Show' : 'Hide'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityPrivacySection(StateSetter setState, bool isSwitch, bool isSwitch2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Security & Privacy',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        _buildSwitchRow(
          'Multifactor Authentication',
          isSwitch,
          (bool newBool) => setState(() => isSwitch = newBool),
        ),
        _buildSwitchRow(
          'Blur Info On Load',
          isSwitch2,
          (bool newBool) => setState(() => isSwitch2 = newBool),
        ),
      ],
    );
  }

  Widget _buildSwitchRow(String label, bool switchValue, ValueChanged<bool> onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
        Switch(
          value: switchValue,
          activeColor: Colors.white,
          activeTrackColor: const Color(0xFFDD53F5),
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildStatementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Statements',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CurrentMonthText(),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View'),
            ),
          ],
        ),
      ],
    );
  }
}

class CurrentMonthText extends StatelessWidget {
  const CurrentMonthText({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    List<String> months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    String currentMonth = months[now.month - 1];
    int currentYear = now.year;

    return Text(
      '$currentMonth $currentYear',
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    );
  }
}
