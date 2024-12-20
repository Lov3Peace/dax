import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BillingUi extends StatelessWidget {
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _paypalAccountController = TextEditingController();

  // ValueNotifiers to track the editable state of each TextField
  final ValueNotifier<bool> _isCardEditable = ValueNotifier(false);
  final ValueNotifier<bool> _isPaypalAccountEditable = ValueNotifier(false);

  final ValueNotifier<bool> _paypalEnabled = ValueNotifier(false);

  BillingUi() {
    _loadPaypalPreference();
  }

  // Load PayPal switch state from SharedPreferences
  Future<void> _loadPaypalPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _paypalEnabled.value = prefs.getBool('paypalEnabled') ?? false;
  }

  // Save PayPal switch state to SharedPreferences
  Future<void> _savePaypalPreference(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('paypalEnabled', value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Billing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          // First Row: Card Number and Edit Button
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isCardEditable,
                  builder: (context, isEditable, child) {
                    return TextField(
                      controller: _cardNumberController,
                      decoration: const InputDecoration(
                        labelText: 'Card Number',
                        border: InputBorder.none, // Removes the underline
                      ),
                      readOnly: !isEditable, // Control the editable state
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _isCardEditable.value = !_isCardEditable.value;
                },
              ),
            ],
          ),
          const Divider(
            endIndent: 10,
            indent: 10,
            color: Color.fromARGB(168, 255, 255, 255),
          ),
          // Second Row: Paypal and Switch
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'PayPal',
                style: TextStyle(fontSize: 18),
              ),
              ValueListenableBuilder<bool>(
                valueListenable: _paypalEnabled,
                builder: (context, value, child) {
                  return Switch(
                    value: value,
                    onChanged: (bool newValue) {
                      _paypalEnabled.value = newValue;
                      _savePaypalPreference(newValue);
                    },
                  );
                },
              ),
            ],
          ),
          // Third Row: Paypal Account and Edit Button
          Row(
            children: [
              Expanded(
                child: ValueListenableBuilder<bool>(
                  valueListenable: _isPaypalAccountEditable,
                  builder: (context, isEditable, child) {
                    return TextField(
                      controller: _paypalAccountController,
                      decoration: const InputDecoration(
                        labelText: 'PayPal Account',
                        border: InputBorder.none, // Removes the underline
                      ),
                      readOnly: !isEditable, // Control the editable state
                    );
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _isPaypalAccountEditable.value = !_isPaypalAccountEditable.value;
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
